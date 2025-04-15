# Create service account for PubSub to invoke Cloud Run
resource "google_service_account" "pubsub_sa" {
  project      = var.project_id
  account_id   = "${var.service_name}-pubsub-sa"
  display_name = "Service Account for PubSub to invoke Cloud Run"
}

# Grant PubSub service account the IAM role to invoke the Cloud Run service
resource "google_pubsub_subscription_iam_member" "pubsub_iam" {
  project = var.project_id
  subscription = var.subscription_name
  role = "roles/pubsub.publisher"
  member = "serviceAccount:${google_service_account.pubsub_sa.email}"
}