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
| [aws_iam_role.scheduler_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.scheduler_invoke_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_scheduler_schedule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/scheduler_schedule) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.invoke_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_interval_minutes"></a> [interval\_minutes](#input\_interval\_minutes) | The interval in minutes between invocations. Minimum 1. | `number` | `1` | no |
| <a name="input_label"></a> [label](#input\_label) | A prefix used for the schedule and IAM role names. | `string` | n/a | yes |
| <a name="input_lambda_arn"></a> [lambda\_arn](#input\_lambda\_arn) | The ARN of the Lambda function to invoke. | `string` | n/a | yes |
| <a name="input_payload"></a> [payload](#input\_payload) | Optional JSON payload to pass to the Lambda function. | `string` | `"{}"` | no |
| <a name="input_schedule_name"></a> [schedule\_name](#input\_schedule\_name) | The name of the schedule. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | The ARN of the IAM role used by the EventBridge schedule. |
| <a name="output_schedule_arn"></a> [schedule\_arn](#output\_schedule\_arn) | The ARN of the EventBridge schedule. |
| <a name="output_schedule_name"></a> [schedule\_name](#output\_schedule\_name) | The name of the EventBridge schedule. |
<!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->
