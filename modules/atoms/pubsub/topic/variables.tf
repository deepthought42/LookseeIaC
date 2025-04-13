variable "project_id" {
  description = "The project ID where the topic will be created"
  type        = string
}

variable "topic_name" {
  description = "Name of the PubSub topic"
  type        = string
}

variable "access_policy_id" {
  description = "The ID of the access policy to use for VPC Service Controls"
  type        = string
}

variable "vpc_access_level" {
  description = "The resource name of the access level for the VPC"
  type        = string
}

variable "labels" {
  description = "A map of labels to apply to the service perimeter"
  type        = map(string)
  default     = {}
}

variable "service_account_email" {
  description = "The email of the service account that will be used to publish to this topic"
  type        = string
} 

variable "environment" {
  description = "The environment"
  type        = string
}

variable "service_name" {
  description = "The name of the service"
  type        = string
}
