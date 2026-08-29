output "context" {
  description = "The standard naming context for passing to other modules. It contains application, environment, component, and optional resource_purpose, which consumers use to derive deterministic resource names."

  value = {
    application      = var.application
    environment      = var.environment
    component        = var.component
    resource_purpose = var.resource_purpose
    repo_url         = var.repo_url
  }
}
