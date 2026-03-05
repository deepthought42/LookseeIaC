variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "Optional shared credentials profile"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}

variable "neo4j_ami_id" {
  description = "AMI used by Neo4j EC2 instance"
  type        = string
}

variable "neo4j_instance_type" {
  description = "EC2 type for Neo4j"
  type        = string
  default     = "t3.medium"
}

variable "neo4j_key_name" {
  description = "Optional key pair name for Neo4j host"
  type        = string
  default     = null
}

variable "neo4j_password" {
  description = "Neo4j database password"
  type        = string
  sensitive   = true
}

variable "neo4j_username" {
  description = "Neo4j database username"
  type        = string
  default     = "neo4j"
}

variable "neo4j_db_name" {
  description = "Neo4j database name"
  type        = string
  default     = "neo4j"
}

variable "smtp_password" {
  description = "SMTP password"
  type        = string
  sensitive   = true
}

variable "smtp_username" {
  description = "SMTP username"
  type        = string
  sensitive   = true
}

variable "pusher_key" {
  description = "Pusher key"
  type        = string
  sensitive   = true
}

variable "pusher_app_id" {
  description = "Pusher app id"
  type        = string
}

variable "pusher_cluster" {
  description = "Pusher cluster"
  type        = string
}

variable "pusher_secret" {
  description = "Pusher secret"
  type        = string
  sensitive   = true
}

variable "auth0_client_id" {
  description = "Auth0 client id"
  type        = string
  sensitive   = true
}

variable "auth0_client_secret" {
  description = "Auth0 client secret"
  type        = string
  sensitive   = true
}

variable "auth0_domain" {
  description = "Auth0 domain"
  type        = string
  sensitive   = true
}

variable "auth0_audience" {
  description = "Auth0 audience"
  type        = string
  sensitive   = true
}

variable "api_image" {
  description = "API container image"
  type        = string
  default     = "docker.io/deepthought42/crawler-api:latest"
}

variable "page_builder_image" {
  description = "Page builder container image"
  type        = string
  default     = "docker.io/deepthought42/page-builder:latest"
}

variable "audit_manager_image" {
  description = "Audit manager container image"
  type        = string
  default     = "docker.io/deepthought42/audit-manager:latest"
}
