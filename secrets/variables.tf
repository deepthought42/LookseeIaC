variable "project_id" {
  description = "The GCP project ID"
}

variable "environment" {
  description = "The environment"
}

variable "service_account_email" {
  description = "Service account email"
  type        = string
}

variable "neo4j_password" {
  description = "Password for Neo4j database"
  type        = string
  sensitive   = true
}

variable "neo4j_username" {
  description = "Username for Neo4j database"
  type        = string
  default     = "neo4j"
}

variable "neo4j_bolt_uri" {
  description = "Bolt URI for Neo4j database"
  type        = string
  default     = "bolt://34.171.187.210:7687"
}

variable "neo4j_db_name" {
  description = "Database name for Neo4j"
  type        = string
  default     = "neo4j"
}

variable "auth0_client_id" {
  description = "Auth0 client id"
  type        = string
  sensitive   = true
}

variable "auth0_client_secret" {
  description = "Auth0 client secret"
  type        = string
  sensitive   = true
}

variable "auth0_domain" {
  description = "Auth0 domain"
  type        = string
}

variable "auth0_audience" {
  description = "Auth0 audience"
  type        = string
}


variable "pusher_app_id" {
  description = "Pusher application ID"
  type        = string
  default     = "1149968"
}

variable "pusher_key" {
  description = "Pusher key"
  type        = string
  sensitive   = true
}

variable "pusher_cluster" {
  description = "Pusher cluster"
  type        = string
  sensitive   = true
}

variable "smtp_password" {
  description = "SMTP password"
  type        = string
  sensitive   = true
}

variable "smtp_username" {
  description = "SMTP username"
  type        = string
  sensitive   = true
}