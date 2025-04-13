variable "project_id" {
  description = "The project ID where resources will be created"
  type        = string
}

variable "topic_name" {
  description = "Name of the PubSub topic"
  type        = string
}

variable "service_account_email" {
  description = "The email of the service account that will be used to publish to the topic"
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

variable "perimeter_id" {
  description = "The ID of the VPC service perimeter to associate with this topic"
  type        = string
}

variable "pubsub_topics" {
  description = "The name of the Pub/Sub topic"
  type        = list(string)
}

variable "labels" {
  description = "Environment labels"
  type        = map(string)
  default     = {
    environment = var.environment
    managed-by  = "terraform"
    application = var.service_name
  }
}