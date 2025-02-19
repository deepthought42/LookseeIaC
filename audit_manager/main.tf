# Configure the Google Cloud provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# Cloud Run service
resource "google_cloud_run_service" "page_builder" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      containers {
        # Using the latest image from Artifact Registry
        image = "${var.region}-docker.pkg.dev/${var.project_id}/audit-manager/audit-manager:latest"
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
