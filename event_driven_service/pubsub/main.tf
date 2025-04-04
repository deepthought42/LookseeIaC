# Create the Pub/Sub topic
resource "google_pubsub_topic" "$${var.topic_name}_topic" {
  name    = var.topic_name
  project = var.project_id

  # Optional: Add labels if you want to organize/identify your resources
  labels = {
    environment = var.environment
  }
}