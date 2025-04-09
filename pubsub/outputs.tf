# URL Pub/Sub topic
output "topic_id" {
  description = "The ID of the PubSub topic"
  value       = google_pubsub_topic.topic.id
}

output "pubsub_subscription_id" {
  value       = google_pubsub_subscription.push_subscription.id
  description = "The ID of the PubSub push subscription"
}

output "pubsub_service_account_email" {
  value       = google_service_account.pubsub_sa.email
  description = "The email of the service account used for PubSub to invoke Cloud Run"
}

output "pubsub_topic_name" {
  value       = google_pubsub_topic.topic.name
  description = "The name of the PubSub topic"
}
