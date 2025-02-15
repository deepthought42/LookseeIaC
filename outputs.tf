# Secrets outputs
output "neo4j_password_secret_id" {
  value = module.secrets.neo4j_password_secret_id
}

output "neo4j_username_secret_id" {
  value = module.secrets.neo4j_username_secret_id
}

output "neo4j_bolt_uri_secret_id" {
  value = module.secrets.neo4j_bolt_uri_secret_id
}

output "neo4j_db_name_secret_id" {
  value = module.secrets.neo4j_db_name_secret_id
}

output "auth0_client_secret_id" {
  value = module.secrets.auth0_client_secret_id
}

# Pub/Sub outputs
output "url_topic_id" {
  value = module.pubsub.url_topic_id
}

output "page_created_topic_id" {
  value = module.pubsub.page_created_topic_id
}

# Cloud Run outputs
output "api_url" {
  value = module.api.service_url
}

output "page_builder_url" {
  value = module.page_builder.service_url
} 