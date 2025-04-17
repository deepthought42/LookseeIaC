provider "google" {
  project = var.project_id
  region  = var.region
}

data "google_project" "project" {
  project_id = var.project_id
}

# VPC module
module "vpc" {
  source = "./modules/atoms/vpc"

  project_id  = provider.google.project
  environment = var.environment
  labels = var.labels
}

# Secrets module
#module "secrets" {
#  source = "./modules/atoms/secrets"

#  project_id  = data.google_project.project.number
#  environment = var.environment

#  auth0_client_secret = var.auth0_client_secret
#  auth0_client_id = var.auth0_client_id

#  neo4j_password = var.neo4j_password
#  neo4j_bolt_uri = var.neo4j_bolt_uri
#  neo4j_db_name = var.neo4j_db_name
#  neo4j_username = var.neo4j_username

#  smtp_password = var.smtp_password
#  smtp_username = var.smtp_username
  
#  pusher_key = var.pusher_key
#  pusher_app_id = var.pusher_app_id
#  pusher_cluster = var.pusher_cluster
#}






# PUBSUB PERIMETER
#module "pubsub_perimeter" {
#  source              = "./modules/molecules/security/service_perimeter"
#  environment         = var.environment
#  service_name        = var.service_name
#  access_policy_id    = var.access_policy_id
#  perimeter_name      = "crawler-perimeter"
#  project_numbers     = [data.google_project.project.number]
#  restricted_services = ["pubsub.googleapis.com"]
#  allowed_services    = ["pubsub.googleapis.com"]
#  access_level_names  = [var.vpc_access_level]
#}

# Pub/Sub module
module "pubsub" {
  source = "./modules/atoms/pubsub/topic"

  project_id  = data.google_project.project.number
  topic_name = var.pubsub_topic_name
  labels = var.labels
  service_account_email = module.google_service_account.pubsub_sa.email
  #perimeter_id = module.pubsub_perimeter.perimeter_id
  depends_on = [ module.pubsub_perimeter ]
}

# Page Builder module
module "page-builder" {
  source = "./services/page-builder"
  project_id = data.google_project.project.number
  environment = var.environment
  service_name = "Page_Builder"
  #vpc_perimeter_id = module.pubsub_perimeter.perimeter_id
  region = var.region
  pubsub_topics = var.pubsub_topics
  pubsub_app_topic_map = var.topic_map
}

# API module
module "api" {
  source = "./api"
  
  project_id  = data.google_project.project.number
  region     = var.region
  environment = var.environment
}