###########################
# PubSub Topics
###########################

output "url_topic_name" {
  description = "The name of the URL Pub/Sub topic"
  value       = module.url_topic.name
}

output "page_created_topic_name" {
  description = "The name of the PageCreated Pub/Sub topic"
  value       = module.page_created_topic.name
}

output "page_audit_topic_name" {
  description = "The name of the PageAudit topic"
  value       = module.page_audit_topic.name
}

output "journey_verified_topic_name" {
  description = "The name of the JourneyVerified topic"
  value       = module.journey_verified_topic.name
}

output "journey_discarded_topic_name" {
  description = "The name of the JourneyDiscarded topic"
  value       = module.journey_discarded_topic.name
}

output "journey_candidate_topic_name" {
  description = "The name of the JourneyCandidate topic"
  value       = module.journey_candidate_topic.name
}

output "audit_update_topic_name" {
  description = "The name of the AuditUpdate topic"
  value       = module.audit_update_topic.name
}

output "journey_completion_cleanup_topic_name" {
  description = "The name of the JourneyCompletionCleanup topic"
  value       = module.journey_completion_cleanup_topic.name
}

output "audit_error_topic_name" {
  description = "The name of the AuditError topic"
  value       = module.audit_error_topic.name
}