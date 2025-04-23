locals {
  resource_labels = merge(var.labels, {
    environment = var.environment
    application = var.service_name
  })
}

module "cloud_run" {
  source = "../../atoms/cloud_run"
  project_id = var.project_id
  environment = var.environment
  service_name = var.service_name
  image = var.image
  region = var.region
  labels = local.resource_labels
  pubsub_topics = var.pubsub_topics
  service_account_email = var.service_account_email
  vpc_connector_name = var.vpc_connector_name
  topic_id = var.topic_id
  #secrets = {
  #  for secret in var.secrets : secret.env_var => {
  #    secret_id = secret.secret_id
  #    version   = secret.version
  #  }
  #}
}

resource "google_pubsub_topic" "$${var.topic_name}_topic" {
  name    = var.topic_name
  project = var.project_id

  # Optional: Add labels if you want to organize/identify your resources
  labels = var.labels

  message_storage_policy {
    allowed_persistence_regions = [
      var.region
    ]
  }
}

module "pubsub_subscription" {
  source                = "../../atoms/pubsub/push_subscription"
  project_id            = var.project_id
  subscription_name     = "${var.service_name}-subscription"
  topic_id              = module.pubsub_topic.id
  push_endpoint         = module.cloud_run.cloud_run_url
  service_account_email = var.service_account_email
  depends_on            = [module.cloud_run, module.pubsub_topic]
  environment           = var.environment
  service_name          = var.service_name
}