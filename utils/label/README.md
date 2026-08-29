# Label Context

This module creates the standard context object used by every module in this repository to derive deterministic, organisation-wide resource names.

## Usage

```hcl
module "label" {
  source = "../utils/label"

  application = "bart"
  environment = "prod"
  id          = "api"
  purpose     = "logs"
}

module "thing" {
  source = "../thing"

  context = module.label.context
}
```

`purpose` can be omitted from the label and set for a specific downstream module:

```hcl
module "label" {
  source = "../utils/label"

  application = "bart"
  environment = "prod"
  id          = "api"
}

module "s3_bucket" {
  source = "../aws/s3_bucket"

  context = merge(module.label.context, {
    purpose = "artifacts"
  })
}
```

Consumer modules must declare the standard context contract:

```hcl
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

locals {
  label = "${var.context.application}-${var.context.environment}-${var.context.id}"
}
```

For naming rules and resource-specific examples, see [Resource Naming](../../conventions/RESOURCE_NAMING.md).

<!-- BEGINNING OF PRE-COMMIT-OPENTOFU DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_application"></a> [application](#input\_application) | The stable application identifier used as the first segment of organisation-wide resource names, for example payment-processor. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The deployment environment identifier used as the second segment of organisation-wide resource names, for example prod or staging. | `string` | n/a | yes |
| <a name="input_id"></a> [id](#input\_id) | The stable workload, component, or instance identifier used as the third segment of organisation-wide resource names, for example api. | `string` | n/a | yes |
| <a name="input_purpose"></a> [purpose](#input\_purpose) | The optional resource purpose identifier, for example logs or artifacts. | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_context"></a> [context](#output\_context) | The standard naming context for passing to other modules. It contains application, environment, id, and optional purpose, which consumers use to derive deterministic resource names. |
<!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->
