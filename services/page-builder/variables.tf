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

variable "pubsub_app_topic_map" {
  description = "Map of PubSub topics and their corresponding Cloud Run application environment variables"
  type        = map(string)
}

variable "image" {
  description = "The container image to deploy"
  type        = string
  default     = "https://hub.docker.com/r/deepthought42/page-builder"
}

variable "service_account_email" {
  description = "Email of the service account for the Cloud Run service"
  type        = string
}

###########################
# PubSub Topics
###########################

variable "url_topic_name" {
  description = "The name of the URL Pub/Sub topic"
  type        = string
}

variable "page_created_topic_name" {
  description = "The name of the PageCreated Pub/Sub topic"
  type        = string
}

variable "page_audit_topic_name" {
  description = "The name of the PageAudit Pub/Sub topic"
  type        = string
}

variable "journey_verified_topic_name" {
  description = "The name of the JourneyVerified Pub/Sub topic"
  type        = string
}