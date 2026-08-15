<!-- BEGINNING OF PRE-COMMIT-OPENTOFU DOCS HOOK -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 6.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_cloudwatch_event_bus.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_bus) | resource |
| [aws_cloudwatch_log_delivery.error](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_delivery) | resource |
| [aws_cloudwatch_log_delivery.info](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_delivery) | resource |
| [aws_cloudwatch_log_delivery.trace](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_delivery) | resource |
| [aws_cloudwatch_log_delivery_destination.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_delivery_destination) | resource |
| [aws_cloudwatch_log_delivery_source.error](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_delivery_source) | resource |
| [aws_cloudwatch_log_delivery_source.info](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_delivery_source) | resource |
| [aws_cloudwatch_log_delivery_source.trace](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_delivery_source) | resource |
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_resource_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_resource_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_event_bus_name"></a> [event\_bus\_name](#input\_event\_bus\_name) | The name for the Event Bus. | `string` | n/a | yes |
| <a name="input_label"></a> [label](#input\_label) | A prefix used for resource names. | `string` | n/a | yes |
| <a name="input_logging"></a> [logging](#input\_logging) | EventBridge logging configuration for the bus.<br/><br/>- include\_detail: Whether to include full event detail in logs, defaults to false.<br/>- level: The log level to emit. Allowed values are OFF, ERROR, INFO, and TRACE, defaults to ERROR.<br/>- log\_group\_name: Supply a custom log group name. If left undefined, a log group will be created named `/aws/vendedlogs/events/event-bus/${var.event_bus_name}`.<br/>- retention\_in\_days: Number of days to retain log events. If omitted, the AWS default retention is used. | <pre>object({<br/>    include_detail    = optional(bool, false),<br/>    level             = optional(string, "INFO")<br/>    log_group_name    = optional(string)<br/>    retention_in_days = optional(number)<br/>  })</pre> | <pre>{<br/>  "include_detail": false,<br/>  "level": "ERROR"<br/>}</pre> | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_event_bus_arn"></a> [event\_bus\_arn](#output\_event\_bus\_arn) | The ARN of the EventBridge event bus. |
| <a name="output_event_bus_name"></a> [event\_bus\_name](#output\_event\_bus\_name) | The name of the EventBridge event bus. |
<!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->
