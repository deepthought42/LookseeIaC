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

variable "perimeter_id" {
  description = "The ID of the VPC service perimeter to associate with this topic"
  type        = string
}

variable "pubsub_topics" {
  description = "The name of the Pub/Sub topic"
  type        = list(string)
}

variable "pubsub_topic_map" {
  description = "A map of PubSub topics to their corresponding Cloud Run application environment variables"
  type        = map(string)
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