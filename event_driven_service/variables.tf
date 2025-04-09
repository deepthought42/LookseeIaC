variable "project_id" {
  description = "The ID of the project where resources will be created"
  type        = string
}

variable "environment" {
  description = "The environment (dev, prod, etc)"
  type        = string
}

variable "topic_name" {
  description = "The name of the Pub/Sub topic"
}

variable "publisher_topics" {
  description = "List of name of the Pub/Sub topics to publish messages to"
  type        = map(string)
}

variable "region" {
  description = "The region where resources will be created"
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
  description = "Name of the PubSub topic to publish to"
  type        = string
}

variable "service_account_name" {
  description = "Name of the service account for the Cloud Run service"
  type        = string
  default     = "cloudrun-pubsub-sa"
}

variable "labels" {
  description = "Environment labels"
  type        = map(string)
  default     = {
    environment = var.environment
    managed-by     = "terraform"
    application    = var.service_name
  }
}