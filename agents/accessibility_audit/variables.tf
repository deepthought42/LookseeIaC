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

variable "project_id" {
  description = "The project ID where resources will be created"
  type        = string
}

variable "environment" {
  description = "Environment (prod, dev, etc)"
  default     = "dev"
  type        = string
}

variable "region" {
  description = "The region to deploy to"
  default     = "us-central1"
  type        = string
}

variable "topic_map" {
  description = "A map of pubsub topics to their corresponding Cloud Run application environment variables"
  type        = map(string)
  default     = local.topic_map
}

variable "secrets" {
  description = "List of secrets to mount in the Cloud Run service"
  type = list(object({
    env_var   = string     # Environment variable name
    secret_id = string     # Secret ID in Secret Manager
    version   = string     # Version of the secret to use
  }))
  default = local.secrets