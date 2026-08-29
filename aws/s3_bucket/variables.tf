# Used by the utils/label module.
variable "context" {
  type = object({
    application = string
    environment = string
    id          = string
    purpose     = optional(string)
  })

  description = <<-EOT
    The standard naming context used to derive deterministic resource names.

    - application: The stable application identifier.
    - environment: The deployment environment identifier.
    - id: The stable workload, component, or instance identifier.
    - purpose: The optional resource purpose identifier.
  EOT
}
