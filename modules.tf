provider "google" {
  project = var.project_id
  region  = var.region
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


# Page Builder module
module "page_builder" {
  source = "./services/page-builder"
  project_id = var.project_id
  environment = var.environment
  service_name = "Page_Builder"
  #vpc_perimeter_id = module.pubsub_perimeter.perimeter_id
  region = var.region
  pubsub_app_topic_map = var.topic_map
  url_topic_name = module.pubsub_topics.url_topic_name
  page_created_topic_name = module.pubsub_topics.page_created_topic_name
  page_audit_topic_name = module.pubsub_topics.page_audit_topic_name
  journey_verified_topic_name = module.pubsub_topics.journey_verified_topic_name
  service_account_email = google_service_account.pubsub_sa.email
}

# API module
module "api" {
  source = "./api"
  project_id  = var.project_id
  region     = var.region
  environment = var.environment
}
