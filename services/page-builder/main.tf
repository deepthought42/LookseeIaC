# Configure the Google Cloud provider
provider "google" {
  project = var.project_id
  region  = var.region
}

module "pubsub_event_driven_service" {
  source               = "../../modules/molecules/event_driven_service"
  image                = var.image
  project_id           = var.project_id
  environment          = var.environment
  service_name         = "page-builder"
  topic_name           = var.url_topic_name
  service_account_email = var.service_account_email
  pubsub_topics        = {
                            "pubsub.page_built": var.page_created_topic_name,
                            "pubsub.page_audit": var.page_audit_topic_name,
                            "pubsub.journey_verified": var.journey_verified_topic_name
                          }
  region               = var.region
  
  labels = {
    environment = var.environment
    managed-by  = "terraform"
    application = "page-builder"
    team        = "platform"
  }

  #depends_on = [module.pubsub_perimeter]
}