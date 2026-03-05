variable "environment" { type = string }
variable "tags" { type = map(string) default = {} }
variable "service_name" { type = string }
variable "image" { type = string }
variable "cluster_id" { type = string }
variable "subnet_ids" { type = list(string) }
variable "security_group_id" { type = string }
variable "execution_role_arn" { type = string }
variable "task_role_arn" { type = string }
variable "region" { type = string, default = "us-east-1" }
variable "port" { type = number, default = 8080 }
variable "cpu" { type = number, default = 512 }
variable "memory" { type = number, default = 1024 }
variable "desired_count" { type = number, default = 1 }
variable "assign_public_ip" { type = bool, default = false }
variable "environment_variables" { type = map(string), default = {} }
