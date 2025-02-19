provider "google" {
  project = var.project_id
  region  = var.region
}

# Add variables for authentication
variable "credentials_file" {
  description = "Path to the Google Cloud service account credentials JSON file"
  type        = string
}

# Secrets module
module "secrets" {
  source = "./secrets"

  project_id  = var.project_id
  environment = var.environment

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

# Pub/Sub module
module "pubsub" {
  source = "./pubsub"

  project_id  = var.project_id
  environment = var.environment
}

# API module
module "api" {
  source = "./api"
  
  project_id  = var.project_id
  region     = var.region
  environment = var.environment
}

# Page Builder module
module "page_builder" {
  source = "./page-builder"

  project_id  = var.project_id
  region     = var.region
  environment = var.environment
}
