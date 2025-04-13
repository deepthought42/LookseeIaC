variable "project_id" {
  description = "The ID of the project where resources will be created"
  type        = string
}

variable "region" {
  description = "The region where resources will be created"
  type        = string
}

variable "environment" {
  description = "The environment (dev, prod, etc)"
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

variable "pubsub_topics" {
  description = "List of PubSub topic names to publish messages to"
  type        = map(string)
}

variable "service_account_name" {
  description = "Name of the service account for the Cloud Run service"
  type        = string
  default     = "cloudrun-pubsub-sa"
}

variable "labels" {
  description = "Environment labels"
  type        = map(string)
}