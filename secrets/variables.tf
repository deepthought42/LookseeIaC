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

variable "neo4j_db_name" {
  description = "Database name for Neo4j"
  type        = string
  default     = "neo4j"
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