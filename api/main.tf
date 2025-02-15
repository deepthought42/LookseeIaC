# Configure the Google Cloud provider with authentication
provider "google" {
  project     = var.project_id
  region      = var.region
}

# Cloud Run service
resource "google_cloud_run_service" "api" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      containers {
        # Using the latest image from Artifact Registry
        image = "${var.region}-docker.pkg.dev/${var.project_id}/api/api:latest"

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

# Add IAM permissions for Cloud Run to access secrets
resource "google_secret_manager_secret_iam_member" "api_neo4j_password" {
  secret_id = "neo4j-password"
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_cloud_run_service.api.template[0].spec[0].service_account_name}"
}

resource "google_secret_manager_secret_iam_member" "api_neo4j_username" {
  secret_id = "neo4j-username"
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_cloud_run_service.api.template[0].spec[0].service_account_name}"
}

resource "google_secret_manager_secret_iam_member" "api_neo4j_bolt_uri" {
  secret_id = "neo4j-bolt-uri"
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_cloud_run_service.api.template[0].spec[0].service_account_name}"
}

resource "google_secret_manager_secret_iam_member" "api_neo4j_db_name" {
  secret_id = "neo4j-db-name"
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_cloud_run_service.api.template[0].spec[0].service_account_name}"
}

# IAM policy to make the service public
resource "google_cloud_run_service_iam_member" "public_access" {
  service  = google_cloud_run_service.api.name
  location = google_cloud_run_service.api.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
