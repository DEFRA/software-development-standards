variable "deployment_prefix" {
  type = string
  description = "The prefix identifier used when defining resource names"
}

variable "tags" {
  type = map(string)
  default = {}
}