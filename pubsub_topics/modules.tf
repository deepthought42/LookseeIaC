module "url_topic" {
  source = "../modules/atoms/pubsub/topic"
  project_id = var.project_id
  topic_name = var.url_topic_name
  labels = var.labels
  service_account_email = var.service_account_email
}

module "page_created_topic" {
  source = "../modules/atoms/pubsub/topic"
  project_id = var.project_id
  topic_name = var.page_created_topic_name
  labels = var.labels
  service_account_email = var.service_account_email
}

module "page_audit_topic" {
  source = "../modules/atoms/pubsub/topic"
  project_id = var.project_id
  topic_name = var.page_audit_topic_name
  labels = var.labels
  service_account_email = var.service_account_email
}

module "journey_verified_topic" {
  source = "../modules/atoms/pubsub/topic"
  project_id = var.project_id
  topic_name = var.journey_verified_topic_name
  labels = var.labels
  service_account_email = var.service_account_email
}

module "journey_discarded_topic" {
  source = "../modules/atoms/pubsub/topic"
  project_id = var.project_id
  topic_name = var.journey_discarded_topic_name
  labels = var.labels
  service_account_email = var.service_account_email
}

module "journey_candidate_topic" {
  source = "../modules/atoms/pubsub/topic"
  project_id = var.project_id
  topic_name = var.journey_candidate_topic_name
  labels = var.labels
  service_account_email = var.service_account_email
}

module "audit_update_topic" {
  source = "../modules/atoms/pubsub/topic"
  project_id = var.project_id
  topic_name = var.audit_update_topic_name
  labels = var.labels
  service_account_email = var.service_account_email
}

module "journey_completion_cleanup_topic" {
  source = "../modules/atoms/pubsub/topic"
  project_id = var.project_id
  topic_name = var.journey_completion_cleanup_topic_name
  labels = var.labels
  service_account_email = var.service_account_email
}

module "audit_error_topic" {
  source = "../modules/atoms/pubsub/topic"
  project_id = var.project_id
  topic_name = var.audit_error_topic_name
  labels = var.labels
  service_account_email = var.service_account_email
}