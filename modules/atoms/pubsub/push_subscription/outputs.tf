output "pubsub_subscription_id" {
  value       = google_pubsub_subscription.subscription.id
  description = "The ID of the PubSub push subscription"
}