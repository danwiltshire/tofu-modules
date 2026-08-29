# Used by the utils/label module.
variable "context" {
  type = object({
    application = string
    environment = string
    id          = string
    purpose     = string
    repo_url    = string
  })

  description = <<-EOT
    The standard naming context used to derive deterministic resource names.

    - application: The stable application identifier.
    - environment: The deployment environment identifier.
    - id: The stable workload, component, or instance identifier.
    - purpose: The required resource purpose identifier for this module.
    - repo_url: The full repository URL.
  EOT
}
