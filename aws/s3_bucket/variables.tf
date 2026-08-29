# Defined by the consuming root module.
variable "context" {
  type = object({
    application      = string
    environment      = string
    component        = string
    resource_purpose = string
    repo_url         = string
  })

  description = <<-EOT
    The standard naming context used to derive deterministic resource names.

    - application: The stable application identifier.
    - environment: The deployment environment identifier.
    - component: The stable workload or subsystem identifier.
    - resource_purpose: The required identifier describing the resource's purpose for this module.
    - repo_url: The full repository URL.
  EOT
}
