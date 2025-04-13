
resource "google_pubsub_topic_iam_binding" "publisher" {
  project = var.project_id
  topic   = google_pubsub_topic.topic.name
  role    = "roles/pubsub.publisher"
  members = [
    "serviceAccount:${var.service_account_email}"
  ]
}