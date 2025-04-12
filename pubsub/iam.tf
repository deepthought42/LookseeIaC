# Create service account for PubSub to invoke Cloud Run
resource "google_service_account" "pubsub_sa" {
  project      = var.project_id
  account_id   = "${var.service_name}-pubsub-sa"
  display_name = "Service Account for PubSub to invoke Cloud Run"
}