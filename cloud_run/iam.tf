# Create a service account for Cloud Run
resource "google_service_account" "cloud_run_service_account" {
  project      = var.project_id
  account_id   = "${var.service_account_name}-cloud-run-sa"
  display_name = "Cloud Run Publisher Service Account"
}