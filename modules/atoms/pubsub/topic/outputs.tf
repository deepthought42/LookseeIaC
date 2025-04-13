output "topic_id" {
  description = "The ID of the PubSub topic"
  value       = google_pubsub_topic.topic.id
}

output "topic_name" {
  description = "The name of the PubSub topic"
  value       = google_pubsub_topic.topic.name
} 