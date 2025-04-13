variable "project_id" {
  description = "The project ID where the topic will be created"
  type        = string
}

variable "topic_name" {
  description = "Name of the PubSub topic"
  type        = string
}

variable "labels" {
  description = "A map of labels to apply to the topic"
  type        = map(string)
  default     = {}
}

variable "service_account_email" {
  description = "The email of the service account that will be used to publish to this topic"
  type        = string
} 

variable "perimeter_id" {
  description = "The ID of the VPC service perimeter to associate with this topic"
  type        = string
}
