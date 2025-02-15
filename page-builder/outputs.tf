output "service_url" {
  value = google_cloud_run_service.page_builder.status[0].url
}