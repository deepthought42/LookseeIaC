locals {
  resource_labels = merge(var.labels, {
    environment = var.environment
  })
}

module "cloud_run" {
  source = "../cloud_run"
  project_id = var.project_id
  environment = var.environment
  pubsub_topics = var.publisher_topics
  service_name = var.service_name
  image = var.image
  region = var.region
  labels = local.resource_labels
}

module "pubsub" {
  source = "../pubsub"
  project_id = var.project_id
  environment = var.environment
  topic_name = var.topic_name
  service_name = var.service_name
  labels = local.resource_labels
  cloud_run_url = module.cloud_run.cloud_run_url
  depends_on = [module.cloud_run]
}