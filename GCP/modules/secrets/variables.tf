variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "environment" {
  description = "The environment"
  type        = string
}

variable "service_account_email" {
  description = "Service account email"
  type        = string
  sensitive   = true
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
  sensitive   = true
}

variable "neo4j_db_name" {
  description = "Database name for Neo4j"
  type        = string
  default     = "neo4j"
  sensitive   = true
}


variable "pusher_app_id" {
  description = "Pusher application ID"
  type        = string
  default     = "1149968"
  sensitive   = true
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

variable "pusher_secret" {
  description = "Pusher secret"
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

############################
# Auth0 Secrets
############################
variable "auth0_client_id" {
  description = "Auth0 client ID"
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
  sensitive   = true
}

variable "auth0_audience" {
  description = "Auth0 audience"
  type        = string
  sensitive   = true
}

variable "auth0_management_api_client_id" {
  description = "Auth0 management API client ID"
  type        = string
  sensitive   = true
}

variable "auth0_management_api_client_secret" {
  description = "Auth0 management API client secret"
  type        = string
  sensitive   = true
}

variable "auth0_management_api_audience" {
  description = "Auth0 management API audience"
  type        = string
  sensitive   = true
}

variable "auth0_management_api_domain" {
  description = "Auth0 management API domain"
  type        = string
  sensitive   = true
}

variable "selenium_urls" {
  description = "List of Selenium Cloud Run service URLs"
  type        = list(string)
  default     = []
}