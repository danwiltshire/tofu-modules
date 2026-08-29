variable "application" {
  type        = string
  description = "The stable application identifier used as the first segment of organisation-wide resource names, for example payment-processor."
}

variable "environment" {
  type        = string
  description = "The deployment environment identifier used as the second segment of organisation-wide resource names, for example prod or staging."
}

variable "id" {
  type        = string
  description = "The stable workload, component, or instance identifier used as the third segment of organisation-wide resource names, for example api."
}
