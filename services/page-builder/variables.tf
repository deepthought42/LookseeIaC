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

variable "vpc_perimeter_id" {
  description = "The ID of the VPC service perimeter to associate with this topic"
  type        = string
}
