variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "environment" {
  description = "The environment"
  type        = string
}

variable "topic_name" {
  description = "The name of the Pub/Sub topic"
  type        = string
}

variable "service_name" {
  description = "The name of the service"
  type        = string
}

variable "labels" {
  description = "Default labels for PubSub resources"
  type        = map(string)
  default     = {}
}
