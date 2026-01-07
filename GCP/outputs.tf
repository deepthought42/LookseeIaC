# UI Service Outputs
output "ui_service_url" {
  description = "The Cloud Run URL for the UI service"
  value       = module.user_interface_cloud_run.service_url
}

output "ui_service_name" {
  description = "The name of the UI Cloud Run service"
  value       = module.user_interface_cloud_run.service_name
}

# Domain Mapping Outputs (only if domain_name is provided)
output "ui_domain_name" {
  description = "The custom domain name mapped to the UI service"
  value       = var.domain_name != null ? var.domain_name : null
}

output "ui_domain_mapping_status" {
  description = "Status of the domain mapping"
  value       = var.domain_name != null ? google_cloud_run_domain_mapping.ui_domain[0].status : null
}

output "ui_domain_resource_records" {
  description = "DNS resource records that need to be added to your domain's DNS configuration"
  value = var.domain_name != null ? [
    for record in google_cloud_run_domain_mapping.ui_domain[0].status[0].resource_records : {
      name   = record.name
      type   = record.type
      rrdata = record.rrdata
    }
  ] : null
}

output "ui_domain_ssl_certificate_status" {
  description = "Status of the automatically provisioned SSL certificate"
  value       = var.domain_name != null ? google_cloud_run_domain_mapping.ui_domain[0].status[0].conditions : null
}

