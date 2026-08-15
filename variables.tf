variable "label" {
  type        = string
  description = "A prefix used for the schedule and IAM role names."
}

variable "lambda_arn" {
  type        = string
  description = "The ARN of the Lambda function to invoke."
}

variable "interval_minutes" {
  type        = number
  default     = 1
  description = "The interval in minutes between invocations. Minimum 1."

  validation {
    condition     = var.interval_minutes >= 1
    error_message = "interval_minutes must be at least 1."
  }
}

variable "schedule_name" {
  type        = string
  description = "The name of the schedule."
}

variable "payload" {
  type        = string
  default     = "{}"
  description = "Optional JSON payload to pass to the Lambda function."
}
