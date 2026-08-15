# Lambda function image

This module creates an image-based Lambda function with a dedicated execution role, CloudWatch log group, and optional IAM-authorized function URL.

<!-- BEGINNING OF PRE-COMMIT-OPENTOFU DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.lambda_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function_url.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_url) | resource |
| [aws_iam_policy_document.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_kms_key.aws_lambda_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_additional_policy_documents"></a> [additional\_policy\_documents](#input\_additional\_policy\_documents) | Additional IAM policy documents to merge into the Lambda execution role. | `list(string)` | `[]` | no |
| <a name="input_architecture"></a> [architecture](#input\_architecture) | CPU architecture for the Lambda runtime. Supported values are arm64 and x86\_64. | `string` | `"arm64"` | no |
| <a name="input_description"></a> [description](#input\_description) | Human-readable description for the Lambda function. | `string` | n/a | yes |
| <a name="input_enable_iam_function_url"></a> [enable\_iam\_function\_url](#input\_enable\_iam\_function\_url) | Whether to create a Lambda function URL with IAM authorization enabled. | `bool` | `false` | no |
| <a name="input_environment_name"></a> [environment\_name](#input\_environment\_name) | Environment identifier used by callers to distinguish deployments, for example dev or prod. | `string` | n/a | yes |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | Environment variables injected into the Lambda function at runtime. | `map(string)` | `{}` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | Name of the Lambda function as it will appear in AWS. | `string` | n/a | yes |
| <a name="input_image"></a> [image](#input\_image) | Container image configuration for the Lambda function.<br/><br/>- uri: The ECR or registry image URI used for the Lambda package.<br/>- command: The optional command list passed to the container image. Defaults to []. | <pre>object({<br/>    uri     = string<br/>    command = list(string)<br/>  })</pre> | n/a | yes |
| <a name="input_label"></a> [label](#input\_label) | Short, reusable label used as the prefix for IAM resource names and other stable identifiers in this module. | `string` | n/a | yes |
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | Optional override for the CloudWatch log group name. When unset, AWS's default Lambda log group name is used. | `string` | `null` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | Memory allocation for the Lambda function, in MB. | `number` | n/a | yes |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Maximum execution time, in seconds, before the Lambda function times out. | `number` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_function_arn"></a> [function\_arn](#output\_function\_arn) | ARN of the Lambda function. |
| <a name="output_function_url"></a> [function\_url](#output\_function\_url) | Function URL for the Lambda, when IAM auth is enabled. |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | ARN of the IAM role used by the Lambda function. |
<!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->
