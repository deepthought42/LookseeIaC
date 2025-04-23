# Configure the Google Cloud provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# Create the VPC network
resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  description            = "WebCrawler VPC network"
}

resource "google_vpc_access_connector" "connector" {
  name   = "cloud-run-connector"
  region = var.region
  network = google_compute_network.vpc.name
  ip_cidr_range = "10.8.0.0/28"
  min_instances = 2
  max_instances = 3
  machine_type = "e2-micro"
}

# Create a service account for VPC management
resource "google_service_account" "vpc_service_account" {
  account_id   = "vpc-service-account"
  display_name = "VPC Service Account"
  description  = "Service account for VPC management"
}

# Assign necessary IAM roles to the service account
resource "google_project_iam_member" "vpc_admin" {
  project = var.project_id
  role    = "roles/compute.networkAdmin"
  member  = "serviceAccount:${google_service_account.vpc_service_account.email}"
}