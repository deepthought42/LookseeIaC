variable "environment" { type = string }
variable "tags" { type = map(string) default = {} }
variable "secrets" {
  type      = map(string)
  sensitive = true
}
