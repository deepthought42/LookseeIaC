resource "google_pubsub_topic" "topic" {
  name    = var.topic_name
  project = var.project_id

  # Optional: Add labels if you want to organize/identify your resources
  labels = var.labels

  message_storage_policy {
    allowed_persistence_regions = [
      "us-central1"
    ]
  }
}

module "pubsub_perimeter" {
  source = "../../../molecules/security/service_perimeter"
  environment = var.environment
  service_name = var.service_name
  access_policy_id = var.access_policy_id
  perimeter_name   = "${var.topic_name}-perimeter"
  
  project_numbers     = [data.google_project.project.number]
  restricted_services = ["pubsub.googleapis.com"]
  allowed_services    = ["pubsub.googleapis.com"]
  
  access_level_names = [var.vpc_access_level]
}

