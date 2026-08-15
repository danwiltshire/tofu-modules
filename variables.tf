variable "event_bus_name" {
  type        = string
  description = "The name for the Event Bus."
}

variable "label" {
  type        = string
  description = "A prefix used for resource names."
}

variable "logging" {
  description = <<-EOT
    EventBridge logging configuration for the bus.

    - include_detail: Whether to include full event detail in logs, defaults to false.
    - level: The log level to emit. Allowed values are OFF, ERROR, INFO, and TRACE, defaults to ERROR.
    - log_group_name: Supply a custom log group name. If left undefined, a log group will be created named `/aws/vendedlogs/events/event-bus/$${var.event_bus_name}`.
    - retention_in_days: Number of days to retain log events. If omitted, the AWS default retention is used.
  EOT

  type = object({
    include_detail    = optional(bool, false),
    level             = optional(string, "INFO")
    log_group_name    = optional(string)
    retention_in_days = optional(number)
  })

  default = {
    include_detail = false,
    level          = "ERROR"
  }

  validation {
    condition = contains([
      "OFF",
      "ERROR",
      "INFO",
      "TRACE"
    ], var.logging.level)
    error_message = "logging.level must be one of: OFF, ERROR, INFO, TRACE."
  }

  validation {
    condition     = var.logging.retention_in_days == null || try(var.logging.retention_in_days >= 1, false)
    error_message = "logging.retention_in_days must be null or a value of at least 1."
  }
}
