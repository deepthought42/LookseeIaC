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

# Bind the custom role to the service account
resource "google_project_iam_binding" "cloud_run_pubsub_binding" {
  project = var.project_id
  role    = google_project_iam_custom_role.pubsub_publisher.id
  members = [
    "serviceAccount:${google_service_account.cloud_run_pubsub.email}"
  ]
}

# Create topic-level IAM bindings for the service account
resource "google_pubsub_topic_iam_member" "topic_publisher" {
  for_each = toset(var.pubsub_topics)
  
  project = var.project_id
  topic   = each.value
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${google_service_account.cloud_run_pubsub.email}"
}