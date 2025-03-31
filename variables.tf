variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "environment" {
  description = "The environment (dev, prod, etc)"
  type        = string
}

variable "pusher_key" {
  description = "Pusher API key"
  type        = string
  sensitive   = true
}

variable "pusher_app_id" {
  description = "Pusher application ID"
  type        = string
}

variable "pusher_cluster" {
  description = "Pusher cluster region"
  type        = string
}

variable "smtp_password" {
  description = "SMTP password for email service"
  type        = string
  sensitive   = true
}

variable "smtp_username" {
  description = "SMTP username for email service"
  type        = string
  sensitive   = true
}

variable "auth0_client_id" {
  description = "Auth0 client ID"
  type        = string
}

variable "auth0_client_secret" {
  description = "Auth0 client secret"
  type        = string
  sensitive   = true
}

variable "neo4j_password" {
  description = "Neo4j database password"
  type        = string
  sensitive   = true
}

variable "neo4j_username" {
  description = "Neo4j database username"
  type        = string
}

variable "neo4j_bolt_uri" {
  description = "Neo4j database bolt URI"
  type        = string
}

variable "neo4j_db_name" {
  description = "Neo4j database name"
  type        = string
}

variable "credentials_file" {
  description = "Path to GCP credentials JSON file"
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

variable "pubsub_topic_name" {
  description = "Name of the PubSub topic"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC network"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR range for the subnet"
  type        = string
}

variable "labels" {
  description = "Resource labels"
  type        = map(string)
  default = {
    environment = val.environment
  }
}