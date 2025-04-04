output "service_url" {
  value       = google_cloud_run_service.service.status[0].url
  description = "The URL of the deployed Cloud Run service"
}

output "service_account_email" {
  value       = google_service_account.cloud_run_sa.email
  description = "The email of the service account created for Cloud Run"
}
