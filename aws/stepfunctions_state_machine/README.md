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
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_sfn_state_machine.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sfn_state_machine) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_context"></a> [context](#input\_context) | Identifies the workload that owns this state machine and is used to derive resource names.<br/><br/>- application: Stable application identifier. Required.<br/>- environment: Deployment environment identifier, such as dev or prod. Required.<br/>- component: Workload or subsystem identifier. Required.<br/>- repo\_url: URL of the source repository that owns the workload. Required. | <pre>object({<br/>    application = string<br/>    environment = string<br/>    component   = string<br/>    repo_url    = string<br/>  })</pre> | n/a | yes |
| <a name="input_definition"></a> [definition](#input\_definition) | Amazon States Language definition for the state machine, expressed as JSON or YAML. | `string` | n/a | yes |
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | Optional CloudWatch log group name. When unset, the module uses the AWS-vended Step Functions log group name. | `string` | `null` | no |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | Number of days to retain state machine execution logs. Defaults to 365. | `number` | `365` | no |
| <a name="input_policy_documents"></a> [policy\_documents](#input\_policy\_documents) | Additional IAM policy documents, keyed by the inline policy name and expressed as JSON, to attach separately to the state machine execution role. Defaults to no additional permissions. | `map(string)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | Workflow type for the state machine. Valid values are STANDARD and EXPRESS. Defaults to STANDARD. | `string` | `"STANDARD"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_log_group_arn"></a> [log\_group\_arn](#output\_log\_group\_arn) | ARN of the CloudWatch log group receiving execution logs. |
| <a name="output_state_machine_arn"></a> [state\_machine\_arn](#output\_state\_machine\_arn) | ARN of the state machine for starting executions or granting access. |
| <a name="output_state_machine_name"></a> [state\_machine\_name](#output\_state\_machine\_name) | Name of the created state machine. |
<!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->