variable "project_id" {
  description = "The project ID where resources will be created"
  type        = string
}

variable "environment" {
  description = "Environment (prod, dev, etc)"
  default     = "dev"
  type        = string
}

variable "region" {
  description = "The region to deploy to"
  default     = "us-central1"
  type        = string
}