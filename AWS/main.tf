terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.aws_profile != "" ? var.aws_profile : null
}

locals {
  resource_tags = merge(var.tags, {
    environment = var.environment
    application = "crawler"
  })
}

module "vpc" {
  source      = "./modules/vpc"
  environment = var.environment
  region      = var.region
  tags        = local.resource_tags
  vpc_cidr    = var.vpc_cidr
}

module "kinesis_streams" {
  source      = "./modules/kinesis"
  environment = var.environment
  tags        = local.resource_tags
  stream_names = [
    "url",
    "page_created",
    "page_audit",
    "journey_verified",
    "journey_discarded",
    "audit_error",
    "audit_update",
    "journey_candidate",
    "journey_completion_cleanup"
  ]
}

module "secrets" {
  source      = "./modules/secrets"
  environment = var.environment
  tags        = local.resource_tags
  secrets = {
    neo4j_password      = var.neo4j_password
    neo4j_username      = var.neo4j_username
    neo4j_db_name       = var.neo4j_db_name
    smtp_password       = var.smtp_password
    smtp_username       = var.smtp_username
    pusher_key          = var.pusher_key
    pusher_app_id       = var.pusher_app_id
    pusher_cluster      = var.pusher_cluster
    pusher_secret       = var.pusher_secret
    auth0_client_id     = var.auth0_client_id
    auth0_client_secret = var.auth0_client_secret
    auth0_domain        = var.auth0_domain
    auth0_audience      = var.auth0_audience
  }
}

module "neo4j_db" {
  source               = "./modules/neo4j-db"
  environment          = var.environment
  tags                 = local.resource_tags
  ami_id               = var.neo4j_ami_id
  instance_type        = var.neo4j_instance_type
  subnet_id            = module.vpc.private_subnet_ids[0]
  vpc_security_group   = module.vpc.neo4j_security_group_id
  key_name             = var.neo4j_key_name
  neo4j_username       = var.neo4j_username
  neo4j_password       = var.neo4j_password
  neo4j_db_name        = var.neo4j_db_name
}

module "api_service" {
  source                = "./modules/ecs_service"
  environment           = var.environment
  tags                  = local.resource_tags
  service_name          = "api"
  image                 = var.api_image
  cluster_id            = module.vpc.ecs_cluster_id
  subnet_ids            = module.vpc.private_subnet_ids
  security_group_id     = module.vpc.ecs_service_security_group_id
  execution_role_arn    = module.vpc.ecs_task_execution_role_arn
  task_role_arn         = module.vpc.ecs_task_role_arn
  region                = var.region
  assign_public_ip      = false
  environment_variables = {
    URL_STREAM_NAME               = module.kinesis_streams.stream_names["url"]
    JOURNEY_DISCARDED_STREAM_NAME = module.kinesis_streams.stream_names["journey_discarded"]
    AUDIT_ERROR_STREAM_NAME       = module.kinesis_streams.stream_names["audit_error"]
  }
}

module "page_builder_service" {
  source                = "./modules/ecs_service"
  environment           = var.environment
  tags                  = local.resource_tags
  service_name          = "page-builder"
  image                 = var.page_builder_image
  cluster_id            = module.vpc.ecs_cluster_id
  subnet_ids            = module.vpc.private_subnet_ids
  security_group_id     = module.vpc.ecs_service_security_group_id
  execution_role_arn    = module.vpc.ecs_task_execution_role_arn
  task_role_arn         = module.vpc.ecs_task_role_arn
  region                = var.region
  assign_public_ip      = false
  environment_variables = {
    PAGE_CREATED_STREAM_NAME   = module.kinesis_streams.stream_names["page_created"]
    PAGE_AUDIT_STREAM_NAME     = module.kinesis_streams.stream_names["page_audit"]
    JOURNEY_VERIFIED_STREAM    = module.kinesis_streams.stream_names["journey_verified"]
    AUDIT_ERROR_STREAM_NAME    = module.kinesis_streams.stream_names["audit_error"]
    NEO4J_URI                  = module.neo4j_db.bolt_uri
    NEO4J_DB_SECRET_ARN        = module.secrets.secret_arns["neo4j_db_name"]
    NEO4J_USER_SECRET_ARN      = module.secrets.secret_arns["neo4j_username"]
    NEO4J_PASSWORD_SECRET_ARN  = module.secrets.secret_arns["neo4j_password"]
  }
}

module "audit_manager_service" {
  source                = "./modules/ecs_service"
  environment           = var.environment
  tags                  = local.resource_tags
  service_name          = "audit-manager"
  image                 = var.audit_manager_image
  cluster_id            = module.vpc.ecs_cluster_id
  subnet_ids            = module.vpc.private_subnet_ids
  security_group_id     = module.vpc.ecs_service_security_group_id
  execution_role_arn    = module.vpc.ecs_task_execution_role_arn
  task_role_arn         = module.vpc.ecs_task_role_arn
  region                = var.region
  assign_public_ip      = false
  environment_variables = {
    PAGE_CREATED_STREAM_NAME = module.kinesis_streams.stream_names["page_created"]
    PAGE_AUDIT_STREAM_NAME   = module.kinesis_streams.stream_names["page_audit"]
    AUDIT_UPDATE_STREAM_NAME = module.kinesis_streams.stream_names["audit_update"]
    AUDIT_ERROR_STREAM_NAME  = module.kinesis_streams.stream_names["audit_error"]
    NEO4J_URI                = module.neo4j_db.bolt_uri
  }
}
