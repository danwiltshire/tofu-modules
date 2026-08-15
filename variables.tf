variable "label" {
  type        = string
  description = "Short, reusable label used as the prefix for IAM resource names and other stable identifiers in this module."
}

variable "function_name" {
  type        = string
  description = "Name of the Lambda function as it will appear in AWS."
}

variable "environment_name" {
  type        = string
  description = "Environment identifier used by callers to distinguish deployments, for example dev or prod."
}

variable "additional_policy_documents" {
  type        = list(string)
  default     = []
  description = "Additional IAM policy documents to merge into the Lambda execution role."
}

variable "environment_variables" {
  type        = map(string)
  default     = {}
  description = "Environment variables injected into the Lambda function at runtime."
}

variable "architecture" {
  type = string

  default = "arm64"

  description = "CPU architecture for the Lambda runtime. Supported values are arm64 and x86_64."

  validation {
    condition     = contains(["arm64", "x86_64"], var.architecture)
    error_message = "Valid values for var: architecture are (arm64, x86_64)."
  }
}

variable "memory_size" {
  type        = number
  description = "Memory allocation for the Lambda function, in MB."
}

variable "timeout" {
  type        = number
  description = "Maximum execution time, in seconds, before the Lambda function times out."
}

variable "image" {
  type = object({
    uri     = string
    command = list(string)
  })

  description = <<-EOT
    Container image configuration for the Lambda function.

    - uri: The ECR or registry image URI used for the Lambda package.
    - command: The optional command list passed to the container image. Defaults to [].
  EOT
}

variable "description" {
  type        = string
  description = "Human-readable description for the Lambda function."
}

variable "log_group_name" {
  type        = string
  default     = null
  description = "Optional override for the CloudWatch log group name. When unset, AWS's default Lambda log group name is used."
}

variable "enable_iam_function_url" {
  type        = bool
  default     = false
  description = "Whether to create a Lambda function URL with IAM authorization enabled."
}
