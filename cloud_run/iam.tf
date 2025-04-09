# Create a service account for Cloud Run
resource "google_service_account" "cloud_run_pubsub" {
  account_id   = "cloud-run-pubsub-sa"
  display_name = "Cloud Run PubSub Publisher Service Account"
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
