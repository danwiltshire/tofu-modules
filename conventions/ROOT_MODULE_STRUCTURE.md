# Root Module Structure

Each OpenTofu root module defines a shared `context` variable in `variables.tf`. The
context identifies the application, environment, component, and source repository.
Resource modules can require `resource_purpose` by extending the context passed to
them with `merge()`. Resource names are defined using the context object.

## `backend.tf`

```hcl
terraform {
  backend "s3" {
    bucket       = "dwlab-infra-prod-opentofu-state-storage"
    key          = "${var.context.application}/${var.context.environment}/${var.context.component}/terraform.tfstate"
    region       = "eu-west-2"
    profile      = "admin"
    use_lockfile = true
  }
}
```

## `main.tf`

```hcl
# Compose reusable modules from https://github.com/danwiltshire/tofu-modules/.
```

## `providers.tf`

```hcl
locals {
  default_tags = {
    app  = var.context.application
    env  = var.context.environment
    repo = var.context.repo_url
  }
}

provider "aws" {
  profile = "admin"
  region  = "eu-west-2"
  alias   = "prod_eu_west_2"

  default_tags {
    tags = local.default_tags
  }
}
```

## `variables.tf`

```hcl
variable "context" {
  type = object({
    application = string
    environment = string
    component   = string
    repo_url    = string
  })

  description = <<-EOT
    The standard naming context used to derive deterministic resource names.

    - application: The stable application identifier.
    - environment: The deployment environment identifier.
    - component: The stable workload or subsystem identifier.
    - repo_url: The full repository URL.
  EOT

  default = {
    application = "<application>"
    environment = "<environment>"
    component   = "<component>"
    repo_url    = "https://github.com/<organisation>/<repository>"
  }
}
```

## Resource-Specific Context

When a downstream module requires a resource purpose, add it only at that module
call site:

```hcl
module "s3_bucket" {
  source = "github.com/danwiltshire/tofu-modules//aws/s3_bucket"

  context = merge(var.context, {
    resource_purpose = "artifacts"
  })
}
```
