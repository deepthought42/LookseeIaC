variable "project_id" {
  description = "The GCP project ID"
  default     = "webcrawler-450417"
}

variable "region" {
  description = "The region to deploy to"
  default     = "us-central1"
}

variable "environment" {
  description = "Environment (prod, dev, etc)"
  default     = "dev"
}

variable "neo4j_password" {
  description = "Neo4j password"
}

variable "auth0_client_id" {
  description = "Auth0 client id"
}

variable "auth0_client_secret" {
  description = "Auth0 client secret"
}

variable "neo4j_bolt_uri" {
  description = "Neo4j bolt URI"
}

variable "neo4j_db_name" {
  description = "Neo4j database name"
}

variable "neo4j_username" {
  description = "Neo4j username"
}

variable "smtp_password" {
  description = "SMTP password"
}

variable "smtp_username" {
  description = "SMTP username"
}

variable "pusher_key" {
  description = "Pusher key"
}

variable "pusher_app_id" {
  description = "Pusher app ID"
}

variable "pusher_cluster" {
  description = "Pusher cluster"
}
