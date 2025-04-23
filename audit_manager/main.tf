# Configure the Google Cloud provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# Cloud Run service
resource "google_cloud_run_service" "audit_manager" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      containers {
        # Using the latest image from Artifact Registry
        image = "docker.io/deepthought42/audit-manager:latest"
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
