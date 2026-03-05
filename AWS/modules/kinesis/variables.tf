variable "environment" {
  type = string
}

variable "stream_names" {
  type = list(string)
}

variable "tags" {
  type    = map(string)
  default = {}
}
