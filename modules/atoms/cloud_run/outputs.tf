output "service_url" {
  value       = google_cloud_run_service.service.status[0].url
  description = "The URL of the deployed Cloud Run service"
}

output "cloud_run_url" {
  description = "The URL of the deployed Cloud Run service"
  value       = google_cloud_run_service.service.status[0].url
}
