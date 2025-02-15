# URL Pub/Sub topic
output "url_topic_id" {
  description = "The ID of the URL Pub/Sub topic"
  value       = google_pubsub_topic.url_topic.id
}

output "url_topic_name" {
  description = "The name of the URL Pub/Sub topic"
  value       = google_pubsub_topic.url_topic.name
}

# PageCreated Pub/Sub topic
output "page_created_topic_id" {
  description = "The ID of the PageCreated Pub/Sub topic"
  value       = google_pubsub_topic.page_created_topic.id
}

output "page_created_topic_name" {
  description = "The name of the PageCreated Pub/Sub topic"
  value       = google_pubsub_topic.page_created_topic.name
}

# PageAudit Pub/Sub topic
output "page_audit_topic_id" {
  description = "The ID of the PageAudit Pub/Sub topic"
  value       = google_pubsub_topic.page_audit_topic.id
}

output "page_audit_topic_name" {
  description = "The name of the PageAudit topic"
  value       = google_pubsub_topic.page_audit_topic.name
}

# JourneyVerified Pub/Sub topic
output "journey_verified_topic_id" {
  description = "The ID of the JourneyVerified Pub/Sub topic"
  value       = google_pubsub_topic.journey_verified_topic.id
}

output "journey_verified_topic_name" {
  description = "The name of the JourneyVerified topic"
  value       = google_pubsub_topic.journey_verified_topic.name
}


# JourneyDiscarded Pub/Sub topic
output "journey_discarded_topic_id" {
  description = "The ID of the JourneyDiscarded Pub/Sub topic"
  value       = google_pubsub_topic.journey_discarded_topic.id
}

output "journey_discarded_topic_name" {
  description = "The name of the JourneyDiscarded topic"
  value       = google_pubsub_topic.journey_discarded_topic.name
}

# JourneyCandidate Pub/Sub topic
output "journey_candidate_topic_id" {
  description = "The ID of the JourneyCandidate Pub/Sub topic"
  value       = google_pubsub_topic.journey_candidate_topic.id
}

output "journey_candidate_topic_name" {
  description = "The name of the JourneyCandidate topic"
  value       = google_pubsub_topic.journey_candidate_topic.name
}

# AuditUpdate Pub/Sub topic
output "audit_update_topic_id" {
  description = "The ID of the AuditUpdate Pub/Sub topic"
  value       = google_pubsub_topic.audit_update_topic.id
}

output "audit_update_topic_name" {
  description = "The name of the AuditUpdate topic"
  value       = google_pubsub_topic.audit_update_topic.name
}

# JourneyCompletionCleanup Pub/Sub topic
output "journey_completion_cleanup_topic_id" {
  description = "The ID of the JourneyCompletionCleanup Pub/Sub topic"
  value       = google_pubsub_topic.journey_completion_cleanup_topic.id
}

output "journey_completion_cleanup_topic_name" {
  description = "The name of the JourneyCompletionCleanup topic"
  value       = google_pubsub_topic.journey_completion_cleanup_topic.name
}