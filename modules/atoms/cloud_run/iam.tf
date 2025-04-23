resource "google_cloud_run_service_iam_member" "pubsub_invoker" {
  location = var.region
  project  = var.project_id
  service  = var.service_name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${var.service_account_email}"
}