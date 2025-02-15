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
        image = "${var.region}-docker.pkg.dev/${var.project_id}/page-builder/page-builder:latest"
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

# IAM policy to make the service public
resource "google_cloud_run_service_iam_member" "public_access" {
  service  = google_cloud_run_service.page_builder.name
  location = google_cloud_run_service.page_builder.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
