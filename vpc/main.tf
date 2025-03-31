# Configure the Google Cloud provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# Create the VPC network
resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  description            = "Custom VPC network"
}

# Create a subnet in the VPC
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.vpc_name}-subnet"
  ip_cidr_range = var.subnet_cidr
  network       = google_compute_network.vpc.id
  region        = var.region
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