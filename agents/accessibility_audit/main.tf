data "google_project" "project" {
  project_id = var.project_id
}

module "pubsub_perimeter" {
  source = "../../../molecules/security/service_perimeter"
  environment = var.environment
  service_name = var.service_name
  access_policy_id = var.access_policy_id
  perimeter_name   = "crawler-perimeter"
  
  project_numbers     = [data.google_project.project.number]
  restricted_services = ["pubsub.googleapis.com"]
  allowed_services    = ["pubsub.googleapis.com"]
  
  access_level_names = [var.vpc_access_level]
}

module "page-builder" {
  source = "../../services/page-builder"
  project_id = var.project_id
  environment = var.environment
  service_name = "Page_Builder"
  vpc_perimeter_id = module.pubsub_perimeter.perimeter_id
  region = var.region
}
