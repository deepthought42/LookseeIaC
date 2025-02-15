# Create the Pub/Sub topic
# URL topic
resource "google_pubsub_topic" "url_topic" {
  name    = "URL"
  project = var.project_id

  # Optional: Add labels if you want to organize/identify your resources
  labels = {
    environment = var.environment
  }
}

# PageCreated topic
resource "google_pubsub_topic" "page_created_topic" {
  name    = "PageCreated"
  project = var.project_id

  labels = {
    environment = var.environment
  }
}

# PageAudit topic
resource "google_pubsub_topic" "page_audit_topic" {
  name    = "PageAudit"
  project = var.project_id

  labels = {
    environment = var.environment
  }
}

# JourneyVerified topic
resource "google_pubsub_topic" "journey_verified_topic" {
  name    = "JourneyVerified"
  project = var.project_id

  labels = {
    environment = var.environment
  }
}

# JourneyDiscarded topic
resource "google_pubsub_topic" "journey_discarded_topic" {
  name    = "JourneyDiscarded"
  project = var.project_id

  labels = {
    environment = var.environment
  }
}

# JourneyCandidate topic
resource "google_pubsub_topic" "journey_candidate_topic" {
  name    = "JourneyCandidate"
  project = var.project_id

  labels = {
    environment = var.environment
  }
}

# AuditUpdate topic
resource "google_pubsub_topic" "audit_update_topic" {
  name    = "AuditUpdate"
  project = var.project_id

  labels = {
    environment = var.environment
  }
}

# JourneyCompletionCleanup topic
resource "google_pubsub_topic" "journey_completion_cleanup_topic" {
  name    = "JourneyCompletionCleanup"
  project = var.project_id

  labels = {
    environment = var.environment
  }
}