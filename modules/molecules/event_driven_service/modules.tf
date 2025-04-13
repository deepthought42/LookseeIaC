locals {
  resource_labels = merge(var.labels, {
    environment = var.environment
  })
}

module "cloud_run" {
  source = "../cloud_run"
  project_id = var.project_id
  environment = var.environment
  service_name = var.service_name
  image = var.image
  region = var.region
  labels = local.resource_labels
  
  environment_variables = {
    for env_var, topic_name in var.pubsub_app_topic_map : env_var => topic_name
  }

  secrets = {
    for secret in var.secrets : secret.env_var => {
      secret_id = secret.secret_id
      version   = secret.version
    }
  }
}

module "pubsub_topic" {
  source                = "../../atoms/pubsub/topic"
  project_id           = var.project_id
  topic_name           = var.topic_name
  service_account_email = google_service_account.pubsub_sa.email
  perimeter_id         = var.perimeter_id
  labels               = var.labels
}

module "pubsub_subscription" {
  source                = "../pubsub/subscription"
  project_id           = var.project_id
  subscription_name    = "${var.service_name}-subscription"
  topic_id            = var.topic_id
  push_endpoint       = module.cloud_run.cloud_run_url
  service_account_email = google_service_account.pubsub_sa.email
  depends_on          = [module.cloud_run, module.pubsub_topic]
}