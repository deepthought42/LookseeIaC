# URL Pub/Sub topic
output "topic_id" {
  description = "The ID of the topic"
  value       = google_pubsub_topic.url_topic.id
}

output "url_topic_name" {
  description = "The name of the URL Pub/Sub topic"
  value       = google_pubsub_topic.url_topic.name
}

output "page_created_topic_name" {
  description = "The name of the PageCreated Pub/Sub topic"
  value       = google_pubsub_topic.page_created_topic.name
}

output "page_audit_topic_name" {
  description = "The name of the PageAudit topic"
  value       = google_pubsub_topic.page_audit_topic.name
}

output "journey_verified_topic_name" {
  description = "The name of the JourneyVerified topic"
  value       = google_pubsub_topic.journey_verified_topic.name
}

output "journey_discarded_topic_name" {
  description = "The name of the JourneyDiscarded topic"
  value       = google_pubsub_topic.journey_discarded_topic.name
}

output "journey_candidate_topic_name" {
  description = "The name of the JourneyCandidate topic"
  value       = google_pubsub_topic.journey_candidate_topic.name
}

output "audit_update_topic_name" {
  description = "The name of the AuditUpdate topic"
  value       = google_pubsub_topic.audit_update_topic.name
}

output "journey_completion_cleanup_topic_name" {
  description = "The name of the JourneyCompletionCleanup topic"
  value       = google_pubsub_topic.journey_completion_cleanup_topic.name
}