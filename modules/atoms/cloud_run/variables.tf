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
  description = "Map of PubSub topic names to publish messages to"
  type        = map(string)
  default     = {}
}

variable "service_account_email" {
  description = "Email of the service account for the Cloud Run service"
  type        = string
}

variable "labels" {
  description = "Environment labels"
  type        = map(string)
}

variable "topic_id" {
  description = "The ID of the PubSub topic to subscribe to"
  type        = string
}

variable "vpc_connector_name" {
  description = "The name of the VPC connector to use"
  type        = string
}
