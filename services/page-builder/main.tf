# Configure the Google Cloud provider
provider "google" {
  project = var.project_id
  region  = var.region
}

data "google_project" "project" {
  project_id = var.project_id
}

module "page-builder" {
  source              = "../../modules/molecules/event_driven_service"
  image               = var.image
  project_id          = var.project_id
  environment         = var.environment
  service_name        = "page-builder"
  topic_name          = "page-builder-topic"
  pubsub_topics       = ["topic-1", "topic-2", "notifications"]
  region              = var.region
  pubsub_app_topic_map    = var.pubsub_app_topic_map
  
  labels = {
    environment = var.environment
    managed-by  = "terraform"
    application = "page-builder"
    team        = "platform"
  }

  depends_on = [module.pubsub_perimeter]
}