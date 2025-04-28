output "neo4j_password_secret_id" {
  description = "The ID of the neo4j password secret"
  value       = google_secret_manager_secret.neo4j_password.id
}

output "neo4j_password_secret_name" {
  description = "The name of the neo4j password secret"
  value       = google_secret_manager_secret.neo4j_password.name
}

output "neo4j_username_secret_id" {
  description = "The ID of the neo4j username secret"
  value       = google_secret_manager_secret.neo4j_username.id
}

output "neo4j_username_secret_name" {
  description = "The name of the neo4j username secret"
  value       = google_secret_manager_secret.neo4j_username.name
}

output "neo4j_bolt_uri_secret_id" {
  description = "The ID of the neo4j bolt URI secret"
  value       = google_secret_manager_secret.neo4j_bolt_uri.id
}

output "neo4j_bolt_uri_secret_name" {
  description = "The name of the neo4j bolt URI secret"
  value       = google_secret_manager_secret.neo4j_bolt_uri.name
}

# Neo4j Production Database Name Secret
output "neo4j_db_name_secret_id" {
  description = "The ID of the neo4j database name secret"
  value       = google_secret_manager_secret.neo4j_db_name.id
}

output "neo4j_db_name_secret_name" {
  description = "The name of the neo4j database name secret"
  value       = google_secret_manager_secret.neo4j_db_name.name
}

output "pusher_app_id_secret_id" {
  description = "The ID of the Pusher app ID secret"
  value       = google_secret_manager_secret.pusher_app_id.id
}

output "pusher_app_id_secret_name" {
  description = "The name of the Pusher app ID secret"
  value       = google_secret_manager_secret.pusher_app_id.name
}

output "pusher_key_secret_id" {
  description = "The ID of the Pusher key secret"
  value       = google_secret_manager_secret.pusher_key.id
}

output "pusher_key_secret_name" {
  description = "The name of the Pusher key secret"
  value       = google_secret_manager_secret.pusher_key.name
}

output "pusher_cluster_secret_id" {
  description = "The ID of the Pusher cluster secret"
  value       = google_secret_manager_secret.pusher_cluster.id
}

output "pusher_cluster_secret_name" {
  description = "The name of the Pusher cluster secret"
  value       = google_secret_manager_secret.pusher_cluster.name
}





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
