variable "event_bus_name" {
  type = string
}

variable "label" {
  type        = string
  description = "A prefix used for resource names."
}

variable "primary_region" {
  type        = string
  description = "The primary region name, e.g. eu-west-1"
}

variable "secondary_region" {
  type        = string
  description = "The secondary region name, e.g. eu-central-1"
}
