# Cloud Run service
resource "google_cloud_run_service" "selenium_standalone_chrome" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      containers {
        # Using the latest image from Artifact Registry
        image = var.image

        ports {
          container_port = var.port
        }

        env {
          name  = "SE_NODE_MAX_SESSIONS"
          value = tostring(var.max_sessions)
        }

        # Override flag required when max_sessions exceeds CPU count
        # This allows Selenium to accept more sessions than available CPU cores
        env {
          name  = "SE_NODE_OVERRIDE_MAX_SESSIONS"
          value = var.max_sessions > 1 ? "true" : "false"
        }

        resources {
          limits = {
            memory = var.memory_allocation
            cpu    = var.cpu_allocation
          }
        }
      }
    }
  }

  # Use the latest revision
  metadata {
    annotations = {
      "run.googleapis.com/client-name" = "terraform"
    }
  }

  # Configure traffic to latest revision
  traffic {
    percent         = 100
    latest_revision = true
  }
}