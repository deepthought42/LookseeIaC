output "secret_id" {
  description = "The ID of the secret"
  value       = google_secret_manager_secret.secret.id
}

output "secret_name" {
  description = "The name of the secret"
  value       = google_secret_manager_secret.secret.name
}

output "secret_version" {
  description = "The version of the secret"
  value       = google_secret_manager_secret_version.secret_version.version
} 