# Grant PubSub service account the IAM role to invoke the Cloud Run service
# This is now handled at the project level in the main iam.tf file
# resource "google_cloud_run_service_iam_member" "pubsub_invoker" {
#   location = var.location
#   project  = var.project_id
#   service  = var.service_name
#   role     = "roles/run.invoker"
#   member   = "serviceAccount:${var.service_account_email}"
#
#   depends_on = [var.cloud_run_service]
# }