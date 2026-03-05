variable "environment" { type = string }
variable "tags" { type = map(string) default = {} }
variable "ami_id" { type = string }
variable "instance_type" { type = string }
variable "subnet_id" { type = string }
variable "vpc_security_group" { type = string }
variable "key_name" { type = string, default = null }
variable "neo4j_username" { type = string }
variable "neo4j_password" { type = string, sensitive = true }
variable "neo4j_db_name" { type = string }
