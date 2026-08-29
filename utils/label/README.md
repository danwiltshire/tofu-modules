# Label Context

This module creates the standard context object used by every module in this repository to derive deterministic, organisation-wide resource names.

## Usage

```hcl
module "label" {
  source = "../utils/label"

  application = "bart"
  environment = "prod"
  component   = "api"
  resource_purpose = "logs"
  repo_url    = "https://github.com/my-org/my-repo"
}

module "thing" {
  source = "../thing"

  context = module.label.context
}
```

`resource_purpose` can be omitted from the label and set for a specific downstream module:

```hcl
module "label" {
  source = "../utils/label"

  application = "bart"
  environment = "prod"
  component   = "api"
  repo_url    = "https://github.com/my-org/my-repo"
}

module "s3_bucket" {
  source = "../aws/s3_bucket"

  context = merge(module.label.context, {
    resource_purpose = "artifacts"
  })
}
```

Consumer modules can make `resource_purpose` required when their resources depend on it:

```hcl
# Used by the utils/label module.
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

locals {
  label = "${var.context.application}-${var.context.environment}-${var.context.component}"
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
| <a name="input_component"></a> [component](#input\_component) | The stable workload or subsystem identifier used as the third segment of organisation-wide resource names, for example api. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The deployment environment identifier used as the second segment of organisation-wide resource names, for example prod or staging. | `string` | n/a | yes |
| <a name="input_repo_url"></a> [repo\_url](#input\_repo\_url) | The repository URL, for example https://github.com/my-org/my-repo. | `string` | n/a | yes |
| <a name="input_resource_purpose"></a> [resource\_purpose](#input\_resource\_purpose) | The optional identifier describing the resource's purpose, for example logs or artifacts. | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_context"></a> [context](#output\_context) | The standard naming context for passing to other modules. It contains application, environment, component, and optional resource\_purpose, which consumers use to derive deterministic resource names. |
<!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->
