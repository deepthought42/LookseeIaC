# Create Cloud Run service
resource "google_cloud_run_service" "service" {
  name     = var.service_name
  location = var.region
  project  = var.project_id

  template {
    spec {
      containers {
        image = var.image

        ports {
          container_port = var.port
        }

        # Add environment variables from secrets
        env {
          name = "NEO4J_PASSWORD"
          value_from {
            secret_key_ref {
              name = "neo4j-password"
              key  = "latest"
            }
          }
        }

        env {
          name = "NEO4J_USERNAME"
          value_from {
            secret_key_ref {
              name = "neo4j-username"
              key  = "latest"
            }
          }
        }

        env {
          name = "NEO4J_BOLT_URI"
          value_from {
            secret_key_ref {
              name = "neo4j-bolt-uri"
              key  = "latest"
            }
          }
        }

        env {
          name = "NEO4J_DB_NAME"
          value_from {
            secret_key_ref {
              name = "neo4j-db-name"
              key  = "latest"
            }
          }
        }

        dynamic "env" {
          for_each = var.pubsub_topics
          content {
            name  = env.key
            value = env.value
          }
        }
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