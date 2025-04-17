variable "project_id" {
  description = "The project ID where resources will be created"
  type        = string
}

variable "topic_name" {
  description = "Name of the PubSub topic"
  type        = string
}

variable "environment" {
  description = "Environment identifier (e.g., prod, staging, dev)"
  type        = string
}

variable "service_name" {
  description = "Name of the service"
  type        = string
}

variable "region" {
  description = "The region to deploy to"
  type        = string
}

variable "image" {
  description = "The container image to deploy"
  type        = string
}

variable "pubsub_topics" {
  description = "Map of the Pub/Sub topics and their corresponding Cloud Run application environment variables"
  type        = map(string)
}


#variable "perimeter_id" {
#  description = "The ID of the VPC service perimeter to associate with this topic"
#  type        = string
#}

variable "pubsub_app_topic_map" {
  description = "A map of PubSub topics to their corresponding Cloud Run application environment variables"
  type        = map(string)
}

variable "labels" {
  description = "Environment labels"
  type        = map(string)
  default     = {
    managed-by = "terraform"
  }
}

variable "secrets" {
  description = "List of secrets to mount in the Cloud Run service"
  type = list(object({
    env_var   = string     # Environment variable name
    secret_id = string     # Secret ID in Secret Manager
    version   = string     # Version of the secret to use
  }))
  default = []
}