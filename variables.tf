locals {
  secrets = [
    # Page Builder Secrets
    {
      env_var   = "pubsub.error_topic"
      secret_id = "projects/${var.project_id}/secrets/AuditError/versions/1"
      version   = "1"
    },
    {
      env_var   = "pubsub.audit_topic"
      secret_id = "projects/${var.project_id}/secrets/Audit/versions/1"
      version   = "1"
    },
    {
      env_var   = "pubsub.page_built"
      secret_id = "projects/${var.project_id}/secrets/PageCreated/versions/1"
      version   = "1"
    },
    {
      env_var   = "pubsub.journey_verified"
      secret_id = "projects/${var.project_id}/secrets/JourneyVerified/versions/1"
      version   = "1"
    },
    {
      env_var   = "pubsub.page_audit_topic"
      secret_id = "projects/${var.project_id}/secrets/PageAudit/versions/1"
      version   = "1"
    }
  ]
}

#variable "secrets" {
#  description = "List of secrets to mount in the Cloud Run service"
#  type = list(object({
#    env_var   = string     # Environment variable name
#    secret_id = string     # Secret ID in Secret Manager
#    version   = string     # Version of the secret to use
#  }))
#}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  default     = "us-central1"
  type        = string
}

variable "environment" {
  description = "Environment (dev, prod, etc)"
  type        = string
  default     = "dev"
}

#########################
# Pusher Secrets
#########################

variable "pusher_key" {
  description = "Pusher API key"
  type        = string
  sensitive   = true
}

variable "pusher_app_id" {
  description = "Pusher application ID"
  type        = string
}

variable "pusher_cluster" {
  description = "Pusher cluster region"
  type        = string
}

variable "pusher_secret" {
  description = "Pusher secret"
  type        = string
  sensitive   = true
}

#########################
# SMTP Secrets
#########################

variable "smtp_password" {
  description = "SMTP password for email service"
  type        = string
  sensitive   = true
}

variable "smtp_username" {
  description = "SMTP username for email service"
  type        = string
  sensitive   = true
}

#########################
# Neo4j Secrets
#########################

variable "neo4j_password" {
  description = "Neo4j database password"
  type        = string
  sensitive   = true
}

variable "neo4j_username" {
  description = "Neo4j database username"
  type        = string
}

variable "neo4j_bolt_uri" {
  description = "Neo4j database bolt URI"
  type        = string
}

variable "neo4j_db_name" {
  description = "Neo4j database name"
  type        = string
}

#########################
# Auth0 Secrets
#########################

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


#########################
# GCP Service Account
#########################

variable "credentials_file" {
  description = "Path to GCP service account credentials JSON file"
  type        = string
}

#########################
# Cloud Run Images
#########################

variable "page_builder_image" {
  description = "The container image to deploy"
  type        = string
  default     = "docker.io/deepthought42/page-builder:latest"
}

variable "api_image" {
  description = "Container image to deploy"
  type        = string
  default     = "docker.io/deepthought42/crawler-api:latest"
}


variable "audit_manager_image" {
  description = "Audit manager container image"
  type        = string
  default     = "docker.io/deepthought42/audit-manager:latest"
}

variable "audit_service_image" {
  description = "Audit service container image"
  type        = string
  default     = "docker.io/deepthought42/audit-update-service:latest"
}

variable "journey_executor_image" {
  description = "Journey Executor container image"
  type        = string
  default     = "docker.io/deepthought42/journey-executor:latest"
}

variable "journey_expander_image" {
  description = "Journey explander container image"
  type        = string
  default     = "docker.io/deepthought42/journey-expander:latest"
}

variable "content_audit_image" {
  description = "Content audit container image"
  type        = string
  default     = "docker.io/deepthought42/content-audit:latest"
}

variable "visual_design_audit_image" {
  description = "Visual design audit container image"
  type        = string
  default     = "docker.io/deepthought42/visual-design-audit:latest"
}

variable "information_architecture_audit_image" {
  description = "Information architecture audit container image"
  type        = string
  default     = "docker.io/deepthought42/information-architecture-audit:latest"
}

#########################
# VPC
#########################

variable "vpc_name" {
  description = "Name of the VPC network"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR range for the subnet"
  type        = string
}

variable "labels" {
  description = "Resource labels"
  type        = map(string)
}


#variable "access_policy_id" {
#  description = "Access policy ID"
#  type        = string
#}

#variable "vpc_access_level" {
#  description = "VPC access level"
#  type        = string
#}