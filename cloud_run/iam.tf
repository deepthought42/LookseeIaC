# Create a service account for Cloud Run
resource "google_service_account" "cloud_run_pubsub" {
  project      = var.project_id
  account_id   = "${var.service_account_name}-cloud-run-pubsub-sa"
  display_name = "Cloud Run PubSub Publisher Service Account"
}