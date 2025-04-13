# Configure the Google Cloud provider
provider "google" {
  project = var.project_id
  region  = var.region
}

module "pubsub_perimeter" {
  source = "../../../molecules/security/service_perimeter"
  environment = var.environment
  service_name = var.service_name
  access_policy_id = var.access_policy_id
  perimeter_name   = "${var.topic_name}-perimeter"
  
  project_numbers     = [data.google_project.project.number]
  restricted_services = ["pubsub.googleapis.com"]
  allowed_services    = ["pubsub.googleapis.com"]
  
  access_level_names = [var.vpc_access_level]
}

module "page-builder" {
  source = "../../modules/molecules/event_driven_service"
  project_id           = var.project_id
  environment         = var.environment
  service_name        = "my-event-service"
  topic_name          = "my-service-topic"
  perimeter_id        = module.pubsub_perimeter.perimeter_id
  pubsub_topics       = ["topic-1", "topic-2", "notifications"]
  
  labels = {
    environment = var.environment
    managed-by  = "terraform"
    application = "my-event-service"
    team        = "platform"
  }
  depends_on = [module.pubsub_perimeter]
}