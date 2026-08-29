output "context" {
  description = "The standard naming context for passing to other modules. It contains application, environment, and id, which consumers use to derive deterministic resource names."

  value = {
    application = var.application
    environment = var.environment
    id          = var.id
  }
}
