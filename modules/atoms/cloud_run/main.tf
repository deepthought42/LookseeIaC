# Create Cloud Run service
resource "google_cloud_run_service" "service" {
  name     = var.service_name
  location = var.region
  project  = var.project_id

  template {
    spec {
      containers {
        image = var.image
      }
      service_account_name = var.service_account_email
    }
    metadata {
      annotations = {
        "run.googleapis.com/vpc-access-connector" = var.vpc_connector_name
        "run.googleapis.com/vpc-access-egress"    = "private-ranges-only"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

module "pubsub_subscription" {
  source                = "../../atoms/pubsub/push_subscription"
  project_id            = var.project_id
  subscription_name     = "${var.service_name}-subscription"
  topic_id              = var.topic_id
  push_endpoint         = google_cloud_run_service.service.status[0].url
  service_account_email = var.service_account_email
  environment           = var.environment
  service_name          = var.service_name
  region                = var.region
}