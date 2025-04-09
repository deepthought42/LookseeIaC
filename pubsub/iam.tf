# Create service account for PubSub to invoke Cloud Run
resource "google_service_account" "pubsub_sa" {
  project      = var.project_id
  account_id   = "${var.service_name}-pubsub-sa"
  display_name = "Service Account for PubSub to invoke Cloud Run"
}

# Grant PubSub service account permission to invoke Cloud Run
resource "google_cloud_run_service_iam_member" "pubsub_invoker" {
  location = google_cloud_run_service.service.location
  project  = google_cloud_run_service.service.project
  service  = google_cloud_run_service.service.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.pubsub_sa.email}"
}