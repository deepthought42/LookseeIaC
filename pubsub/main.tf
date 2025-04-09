# Create the Pub/Sub topic
resource "google_pubsub_topic" "$${var.topic_name}" {
  name    = var.topic_name
  project = var.project_id

  # Optional: Add labels if you want to organize/identify your resources
  labels = var.labels
}

# Create PubSub push subscription to Cloud Run
resource "google_pubsub_subscription" "push_subscription" {
  name    = "${var.service_name}-push-sub"
  topic   = google_pubsub_topic.topic.name
  project = var.project_id

  push_config {
    push_endpoint = var.cloud_run_url
    
    oidc_token {
      service_account_email = google_service_account.pubsub_sa.email
    }
  }

  # Configure retry policy
  retry_policy {
    minimum_backoff = "10s"
    maximum_backoff = "600s"
  }

  labels = var.labels
}