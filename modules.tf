locals {
  resource_labels = merge(var.labels, {
    environment = var.environment
    application = "crawler"
  })
}

provider "google" {
  project = var.project_id
  region  = var.region
  credentials = "/home/brandon/Dev/gcloud/webcrawler-450417-a21220d66d0e.json"
}


# VPC module
module "vpc" {
  source = "./modules/atoms/vpc"

  project_id  = var.project_id
  environment = var.environment
  labels = var.labels
}


module "pubsub_topics" {
  source = "./pubsub_topics"
  project_id = var.project_id
  region = var.region
  labels = var.labels
  service_account_email = google_service_account.pubsub_sa.email
  url_topic_name = "url"
  page_created_topic_name = "page_created"
  page_audit_topic_name = "page_audit"
  journey_verified_topic_name = "journey_verified"
  journey_discarded_topic_name = "journey_discarded"
  journey_candidate_topic_name = "journey_candidate"
  audit_update_topic_name = "audit_update"
  journey_completion_cleanup_topic_name = "journey_completion_cleanup"
  audit_error_topic_name = "audit_error"
}

# Secrets module
module "secrets" {
  source = "./secrets"
  project_id  = var.project_id
  environment = var.environment
  service_account_email = google_service_account.cloud_run_sa.email
  
  auth0_client_secret = var.auth0_client_secret
  auth0_client_id = var.auth0_client_id

  neo4j_password = var.neo4j_password
  neo4j_bolt_uri = var.neo4j_bolt_uri
  neo4j_db_name = var.neo4j_db_name
  neo4j_username = var.neo4j_username

  smtp_password = var.smtp_password
  smtp_username = var.smtp_username

  pusher_key = var.pusher_key
  pusher_app_id = var.pusher_app_id
  pusher_cluster = var.pusher_cluster
}






# PUBSUB PERIMETER
#module "pubsub_perimeter" {
#  source              = "./modules/molecules/security/service_perimeter"
#  environment         = var.environment
#  service_name        = var.service_vpcname
#  access_policy_id    = var.access_policy_id
#  perimeter_name      = "crawler-perimeter"
#  project_numbers     = [data.google_project.project.number]
#  restricted_services = ["pubsub.googleapis.com"]
#  allowed_services    = ["pubsub.googleapis.com"]
#  access_level_names  = [var.vpc_access_level]
#}


###############################
#
#  Cloud Run modules
#
###############################

# Page Builder Cloud Run module
module "page_builder_cloud_run" {
  source                = "./modules/atoms/cloud_run"
  project_id            = var.project_id
  environment           = var.environment
  service_name          = "page-builder"
  image                 = var.page_builder_image
  region                = var.region
  topic_id              = module.pubsub_topics.url_topic_id
  labels                = { "environment" = var.environment, "application" = "page-builder" }
  service_account_email = google_service_account.cloud_run_sa.email
  pubsub_topics         = {
                            "pubsub.page_built": module.pubsub_topics.page_created_topic_name,
                            "pubsub.page_audit_topic": module.pubsub_topics.page_audit_topic_name,
                            "pubsub.journey_verified": module.pubsub_topics.journey_verified_topic_name,
                            "pubsub.error_topic": module.pubsub_topics.audit_error_topic_name,
                            "spring.cloud.gcp.project-id": var.project_id,
                            "spring.cloud.gcp.region": var.region
                          }

  vpc_connector_name    = module.vpc.vpc_connector_name
}



# API module
module "api" {
  source = "./api"
  project_id  = var.project_id
  region     = var.region
  environment = var.environment
  service_name = "api"
  service_account_email = google_service_account.cloud_run_sa.email
  vpc_connector_name = module.vpc.vpc_connector_name
  url_topic_name = module.pubsub_topics.url_topic_name
  pubsub_topics = {
    "pubsub.url_topic": module.pubsub_topics.url_topic_name,
    "pubsub.discarded_journey_topic": module.pubsub_topics.journey_discarded_topic_name,
    "pubsub.error_topic": module.pubsub_topics.audit_error_topic_name
  }
}
