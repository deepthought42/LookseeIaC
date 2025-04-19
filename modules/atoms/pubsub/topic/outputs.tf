output "id" {
  description = "The ID of the PubSub topic"
  value       = google_pubsub_topic.topic.id
}

output "name" {
  description = "The name of the PubSub topic"
  value       = google_pubsub_topic.topic.name
} 