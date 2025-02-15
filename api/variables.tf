variable "project_id" {
  description = "The GCP project ID"
}

variable "region" {
  description = "The region to deploy to"
}

variable "environment" {
  description = "Environment (prod, dev, etc)"
}

variable "service_name" {
  description = "Name of the Cloud Run service"
  default     = "api"
}

variable "neo4j_password_secret" {
  description = "Name of the Neo4j password secret"
  default     = "neo4j-password"
}

variable "neo4j_username_secret" {
  description = "Name of the Neo4j username secret"
  default     = "neo4j-username"
}

variable "neo4j_bolt_uri_secret" {
  description = "Name of the Neo4j bolt URI secret"
  default     = "neo4j-bolt-uri"
}

variable "neo4j_db_name_secret" {
  description = "Name of the Neo4j database name secret"
  default     = "neo4j-db-name"
}