variable "environment" { type = string }
variable "region" { type = string }
variable "vpc_cidr" { type = string }
variable "tags" { type = map(string) default = {} }
