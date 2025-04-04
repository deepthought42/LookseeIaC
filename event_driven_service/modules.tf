module "pubsub" {
  source = "./modules/pubsub"
  project_id = var.project_id
  environment = var.environment
  topic_name = var.topic_name
}

module "cloud_run" {
  source = "./modules/cloud_run"
  project_id = var.project_id
  environment = var.environment
  topic_name = var.topic_name
}

