resource "google_pubsub_topic" "topic" {
  name    = var.topic_name
  project = var.project_id

  # Optional: Add labels if you want to organize/identify your resources
  labels = var.labels

  message_storage_policy {
    allowed_persistence_regions = [
      "us-central1"
    ]
  }

  depends_on = [google_access_context_manager_service_perimeter_resource.topic_perimeter]
}

resource "google_access_context_manager_service_perimeter_resource" "topic_perimeter" {
  perimeter_name = var.perimeter_id
  resource       = "projects/${var.project_id}/topics/${var.topic_name}"
}