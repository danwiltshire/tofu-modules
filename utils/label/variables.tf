variable "application" {
  type        = string
  description = "The stable application identifier used as the first segment of organisation-wide resource names, for example payment-processor."
}

variable "environment" {
  type        = string
  description = "The deployment environment identifier used as the second segment of organisation-wide resource names, for example prod or staging."
}

variable "component" {
  type        = string
  description = "The stable workload or subsystem identifier used as the third segment of organisation-wide resource names, for example api."
}

variable "resource_purpose" {
  type        = string
  default     = null
  nullable    = true
  description = "The optional identifier describing the resource's purpose, for example logs or artifacts."
}

variable "repo_url" {
  type        = string
  description = "The repository URL, for example https://github.com/my-org/my-repo."
}
