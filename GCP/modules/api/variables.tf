variable "project_id" {
  description = "The GCP project ID"
}

variable "region" {
  description = "The region to deploy to"
}

variable "environment" {
  description = "Environment (prod, dev, etc)"
}

variable "image" {
  description = "Container image to deploy"
  type        = string
  default     = "docker.io/deepthought42/crawler-api:latest"
}

variable "service_name" {
  description = "Name of the Cloud Run service"
  default     = "api"
}

variable "service_account_email" {
  description = "The email address of the service account to use for the Cloud Run service"
  type        = string
  default     = "service-account@project-id.iam.gserviceaccount.com"
}

variable "vpc_connector_name" {
  description = "Name of the VPC connector"
  type        = string
  default     = "vpc-connector"
}

variable "port" {
  description = "The port to run the service on"
  type        = number
  default     = 9080
}


################################
# TOPICS
################################

variable "url_topic_name" {
  description = "Name of the URL topic"
  type        = string
}

################################
# SECRETS
################################

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

################################
# ENVIRONMENT VARIABLES
################################

variable "environment_variables" {
  description = "Environment variables"
  type        = map(string)
}

variable "secrets_variables" {
  description = "Map of secrets variables to set"
  type        = map(list(string))
  default     = {}
}

################################
# Instance configuration
################################

variable "memory_allocation" {
  description = "Memory allocated for cloud run instance"
  type        = string
  default     = "1Gi"
}

variable "cpu_allocation" {
  description = "CPU allocated for cloud run instance"
  type        = string
  default     = "0.5"
}

variable "memory_limit" {
  description = "Memory allocated for cloud run instance"
  type        = string
  default     = "2Gi"
}

variable "cpu_limit" {
  description = "CPU allocated for cloud run instance"
  type        = string
  default     = "1"
}