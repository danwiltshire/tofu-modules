variable "context" {
  type = object({
    application = string
    environment = string
    component   = string
    repo_url    = string
  })

  description = <<-EOT
    Identifies the workload that owns this state machine and is used to derive resource names.

    - application: Stable application identifier. Required.
    - environment: Deployment environment identifier, such as dev or prod. Required.
    - component: Workload or subsystem identifier. Required.
    - repo_url: URL of the source repository that owns the workload. Required.
  EOT
}

variable "definition" {
  type        = string
  description = "Amazon States Language definition for the state machine, expressed as JSON or YAML."
}

variable "policy_documents" {
  type        = map(string)
  default     = {}
  description = "Additional IAM policy documents, keyed by the inline policy name and expressed as JSON, to attach separately to the state machine execution role. Defaults to no additional permissions."
}

variable "type" {
  type        = string
  default     = "STANDARD"
  description = "Workflow type for the state machine. Valid values are STANDARD and EXPRESS. Defaults to STANDARD."

  validation {
    condition     = contains(["STANDARD", "EXPRESS"], var.type)
    error_message = "type must be either STANDARD or EXPRESS."
  }
}

variable "log_group_name" {
  type        = string
  default     = null
  description = "Optional CloudWatch log group name. When unset, the module uses the AWS-vended Step Functions log group name."
}

variable "log_retention_in_days" {
  type        = number
  default     = 365
  description = "Number of days to retain state machine execution logs. Defaults to 365."

  validation {
    condition     = var.log_retention_in_days >= 1
    error_message = "log_retention_in_days must be at least 1."
  }
}