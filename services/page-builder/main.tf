# Configure the Google Cloud provider
provider "google" {
  project = var.project_id
  region  = var.region
}

data "google_project" "project" {
  project_id = var.project_id
}

module "page-builder" {
  source = "../../modules/molecules/event_driven_service"
  project_id           = var.project_id
  environment         = var.environment
  service_name        = "page-builder"
  topic_name          = "page-builder-topic"
  perimeter_id        = var.vpc_perimeter_id
  pubsub_topics       = ["topic-1", "topic-2", "notifications"] 
  pubsub_app_topic_map    = {
    "topic-1" = "TOPIC_1",
    "topic-2" = "TOPIC_2",
    "notifications" = "NOTIFICATIONS"
  }
  
  labels = {
    environment = var.environment
    managed-by  = "terraform"
    application = "my-event-service"
    team        = "platform"
  }

  secrets = [
    {
      env_var   = "SECRET_1"
      secret_id = "secret-1"
      version   = "1"
    },
    {
      env_var   = "SECRET_2"
      secret_id = "secret-2"
      version   = "1"
    }
  ]
  depends_on = [module.pubsub_perimeter]
}