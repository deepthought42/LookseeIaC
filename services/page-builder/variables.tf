variable "project_id" {
  description = "The GCP project ID"
}

variable "region" {
  description = "The region to deploy to"
}

variable "environment" {
  description = "Environment (prod, dev, etc)"
}

variable "service_name" {
  description = "Name of the Cloud Run service"
  default     = "page-builder"
}

#variable "vpc_perimeter_id" {
#  description = "The ID of the VPC service perimeter to associate with this topic"
#  type        = string
#}

variable "pubsub_topics" {
  description = "List of PubSub topics to subscribe to"
  type        = list(string)
}

variable "pubsub_app_topic_map" {
  description = "Map of PubSub topics and their corresponding Cloud Run application environment variables"
  type        = map(string)
}

variable "image" {
  description = "The container image to deploy"
  type        = string
  default     = "https://hub.docker.com/r/deepthought42/page-builder"
}