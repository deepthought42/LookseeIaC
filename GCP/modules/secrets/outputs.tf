output "neo4j_password_secret_id" {
  description = "The ID of the neo4j password secret"
  value       = google_secret_manager_secret.neo4j_password.id
}

output "neo4j_password_secret_name" {
  description = "The name of the neo4j password secret"
  value       = google_secret_manager_secret.neo4j_password.secret_id
}

output "neo4j_username_secret_id" {
  description = "The ID of the neo4j username secret"
  value       = google_secret_manager_secret.neo4j_username.id
}

output "neo4j_username_secret_name" {
  description = "The name of the neo4j username secret"
  value       = google_secret_manager_secret.neo4j_username.secret_id
}

# Neo4j Production Database Name Secret
output "neo4j_db_name_secret_id" {
  description = "The ID of the neo4j database name secret"
  value       = google_secret_manager_secret.neo4j_db_name.id
}

output "neo4j_db_name_secret_name" {
  description = "The name of the neo4j database name secret"
  value       = google_secret_manager_secret.neo4j_db_name.secret_id
}

########################
# Pusher Secrets
########################
output "pusher_app_id_secret_id" {
  description = "The ID of the Pusher app ID secret"
  value       = google_secret_manager_secret.pusher_app_id.id
}

output "pusher_app_id_secret_name" {
  description = "The name of the Pusher app ID secret"
  value       = google_secret_manager_secret.pusher_app_id.secret_id
}

output "pusher_key_secret_id" {
  description = "The ID of the Pusher key secret"
  value       = google_secret_manager_secret.pusher_key.id
}

output "pusher_key_secret_name" {
  description = "The name of the Pusher key secret"
  value       = google_secret_manager_secret.pusher_key.secret_id
}

output "pusher_cluster_secret_id" {
  description = "The ID of the Pusher cluster secret"
  value       = google_secret_manager_secret.pusher_cluster.id
}

output "pusher_cluster_secret_name" {
  description = "The name of the Pusher cluster secret"
  value       = google_secret_manager_secret.pusher_cluster.secret_id
}

output "pusher_secret_id" {
  description = "The ID of the Pusher secret"
  value       = google_secret_manager_secret.pusher_secret.id
}

output "pusher_secret_name" {
  description = "The name of the Pusher secret"
  value       = google_secret_manager_secret.pusher_secret.secret_id
}

########################
# SMTP Secrets
########################

# SMTP Password Secret
output "smtp_password_secret_id" {
  description = "The ID of the SMTP password secret"
  value       = google_secret_manager_secret.smtp_password.id
}

output "smtp_password_secret_name" {
  description = "The name of the SMTP password secret"
  value       = google_secret_manager_secret.smtp_password.name
}

output "smtp_username_secret_id" {
  description = "The ID of the SMTP username secret"
  value       = google_secret_manager_secret.smtp_username.id
}

output "smtp_username_secret_name" {
  description = "The name of the SMTP username secret"
  value       = google_secret_manager_secret.smtp_username.name
}

########################
# Auth0 Secrets
########################

output "auth0_domain_secret_id" {
  description = "The ID of the Auth0 domain secret"
  value       = google_secret_manager_secret.auth0_domain.id
}

output "auth0_domain_secret_name" {
  description = "The name of the Auth0 domain secret"
  value       = google_secret_manager_secret.auth0_domain.secret_id
}

output "auth0_audience_secret_id" {
  description = "The ID of the Auth0 audience secret"
  value       = google_secret_manager_secret.auth0_audience.id
}

output "auth0_audience_secret_name" {
  description = "The name of the Auth0 audience secret"
  value       = google_secret_manager_secret.auth0_audience.secret_id
}

output "auth0_client_id_secret_id" {
  description = "The ID of the Auth0 client ID secret"
  value       = google_secret_manager_secret.auth0_client_id.id
}

output "auth0_client_id_secret_name" {
  description = "The name of the Auth0 client ID secret"
  value       = google_secret_manager_secret.auth0_client_id.secret_id
}

output "auth0_client_secret_secret_id" {
  description = "The ID of the Auth0 client secret secret"
  value       = google_secret_manager_secret.auth0_client_secret.id
}

output "auth0_client_secret_secret_name" {
  description = "The name of the Auth0 client secret secret"
  value       = google_secret_manager_secret.auth0_client_secret.secret_id
}

output "auth0_management_api_client_id_secret_id" {
  description = "The ID of the Auth0 management API client ID secret"
  value       = google_secret_manager_secret.auth0_management_api_client_id.id
}

output "auth0_management_api_client_id_secret_name" {
  description = "The name of the Auth0 management API client ID secret"
  value       = google_secret_manager_secret.auth0_management_api_client_id.secret_id
}

output "auth0_management_api_client_secret_secret_id" {
  description = "The ID of the Auth0 management API client secret secret"
  value       = google_secret_manager_secret.auth0_management_api_client_secret.id
}

output "auth0_management_api_client_secret_secret_name" {
  description = "The name of the Auth0 management API client secret secret"
  value       = google_secret_manager_secret.auth0_management_api_client_secret.secret_id
}

output "auth0_management_api_audience_secret_id" {
  description = "The ID of the Auth0 management API audience secret"
  value       = google_secret_manager_secret.auth0_management_api_audience.id
}

output "auth0_management_api_audience_secret_name" {
  description = "The name of the Auth0 management API audience secret"
  value       = google_secret_manager_secret.auth0_management_api_audience.secret_id
}

output "auth0_management_api_domain_secret_id" {
  description = "The ID of the Auth0 management API domain secret"
  value       = google_secret_manager_secret.auth0_management_api_domain.id
}

output "auth0_management_api_domain_secret_name" {
  description = "The name of the Auth0 management API domain secret"
  value       = google_secret_manager_secret.auth0_management_api_domain.secret_id
}

########################
# Selenium URLs Secret
########################

output "selenium_urls_secret_id" {
  description = "The ID of the Selenium URLs secret"
  value       = google_secret_manager_secret.selenium_urls.id
}

output "selenium_urls_secret_name" {
  description = "The name of the Selenium URLs secret"
  value       = google_secret_manager_secret.selenium_urls.secret_id
}