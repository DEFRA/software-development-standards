variable "deployment_prefix" {
  type = string
  description = "The prefix identifier used when defining resource names"
}

variable "container_image" {
  type = string
}

variable "container_cpu_units" {
  type = number
  default = 256
}

variable "container_memory" {
  type = number
  default = 512
}

variable "tags" {
  type = map(string)
  default = {}
}