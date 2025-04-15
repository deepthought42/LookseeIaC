locals {
  topic_map = {
    # Page Builder Topics
    "pubsub.error_topic" = "projects/${var.project_id}/topics/AuditError"
    "pubsub.audit_topic" = "projects/${var.project_id}/topics/Audit"
    "pubsub.page_built"  = "projects/${var.project_id}/topics/PageCreated"
    "pubsub.journey_verified" = "projects/${var.project_id}/topics/JourneyVerified"
    "pubsub.page_audit_topic" = "projects/${var.project_id}/topics/PageAudit"
  }

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

  auth0_secrets = {
    "AUTH0_CLIENT_ID" = "projects/${var.project_id}/secrets/Auth0ClientId/versions/1"
    "AUTH0_CLIENT_SECRET" = "projects/${var.project_id}/secrets/Auth0ClientSecret/versions/1"
    "AUTH0_ISSUER_BASE_URL" = "projects/${var.project_id}/secrets/Auth0IssuerBaseUrl/versions/1"
    "AUTH0_AUDIENCE" = "projects/${var.project_id}/secrets/Auth0Audience/versions/1"
    "AUTH0_DOMAIN" = "projects/${var.project_id}/secrets/Auth0Domain/versions/1"
    "AUTH0_ISSUER" = "projects/${var.project_id}/secrets/Auth0Issuer/versions/1"
  }
}

variable "topic_map" {
  description = "A map of pubsub topics to their corresponding Cloud Run application environment variables"
  type        = map(string)
}

variable "secrets" {
  description = "List of secrets to mount in the Cloud Run service"
  type = list(object({
    env_var   = string     # Environment variable name
    secret_id = string     # Secret ID in Secret Manager
    version   = string     # Version of the secret to use
  }))
}

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

variable "auth0_client_id" {
  description = "Auth0 client ID"
  type        = string
}

variable "auth0_client_secret" {
  description = "Auth0 client secret"
  type        = string
  sensitive   = true
}

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

variable "credentials_file" {
  description = "Path to GCP service account credentials JSON file"
  type        = string
}

variable "service_name" {
  description = "Name of the Cloud Run service"
  type        = string
}

variable "image" {
  description = "Container image to deploy"
  type        = string
}

variable "pubsub_topic_name" {
  description = "Name of the PubSub topic"
  type        = string
}

variable "pubsub_topics" {
  description = "Map of PubSub topics and their corresponding Cloud Run application environment variables"
  type        = map(string)
}

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

variable "pubsub_service_account_email" {
  description = "Service account email for PubSub admin"
  type        = string
}
