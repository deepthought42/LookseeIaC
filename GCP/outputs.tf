# UI Service Outputs
output "ui_service_url" {
  description = "The Cloud Run URL for the UI service"
  value       = module.user_interface_cloud_run.service_url
}

output "ui_service_name" {
  description = "The name of the UI Cloud Run service"
  value       = module.user_interface_cloud_run.service_name
}

