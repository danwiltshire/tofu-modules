---
name: OpenTofu Module Guidelines
description: "Use when creating, reviewing, or modifying OpenTofu/Terraform modules, including AWS resources, variables, IAM policies, providers, module composition, Checkov findings, and resource naming."
applyTo: "**/*.tf, **/*.tofu, **/*.tfvars, **/README.md"
---

# OpenTofu Module Guidelines

- Treat this repository as an OpenTofu module library. Keep changes focused on reusable module patterns and follow existing repository conventions.
- Modules must create a pattern containing more than one resource. Do not add a module whose sole purpose is creating one resource, such as an S3 bucket.
- Modules must accept a `context` variable using the standard label contract and derive resource names from it. The contract is `object({ application = string, environment = string, component = string })`. Consumers pass it as `context = module.label.context`.
- Use `local.label = "${var.context.application}-${var.context.environment}-${var.context.component}"` as the base prefix for top-level resource names, including RDS clusters and IAM roles. Do not apply the prefix to names that do not need to be globally unique, such as IAM inline policy names.
- Follow `conventions/RESOURCE_NAMING.md` when forming resource names. Use hyphens by default, and forward-slash-delimited hierarchical names for resources such as Secrets Manager secrets, SSM parameters, and CloudWatch alarms.
- Use forward slashes in names for AWS Systems Manager Parameter Store parameters, Secrets Manager secrets, and CloudWatch alarms. Use hyphens in names for all other resources unless the service requires a different format.
- Keep slash-delimited names hierarchical and consistent, for example `/service/environment/setting` for SSM parameters and secrets, and `/service/environment/alarm` for CloudWatch alarms. Use hyphen-delimited names such as `label-resource-purpose` for other resources.
- Modules that create CloudWatch log groups should expose an optional `log_group_name` variable for callers that need to override the name. When it is not set, use the AWS-vended log-group format, such as `/aws/lambda/<function-name>`.
- All modules that create resoures with retention or lifecycle settings should expose a corresponding retention variable where applicable, such as CloudWatch log group retention, RDS snapshot retention, and other similar settings. Prefer clear names like `retention_in_days` or `snapshot_retention_limit` and document the default behavior.
- Do not nest modules without asking the user for permission first.
- Prefer the simplest implementation. Ask the user for permission before introducing `for_each`.
- Do not add Checkov ignore or skip rules automatically. Explain the finding and ask the user to accept the specific exception before adding an ignore.
- Keep IAM policies least-privilege: grant only the actions, resources, and conditions required by the module's behavior.
- Configure EC2 security group rules with least privilege by default. Limit each rule to the required protocol, port range, and source or destination, prefer security-group or specific CIDR sources over broad network ranges, and ask the user to approve any public `0.0.0.0/0` or `::/0` access.
- Do not define provider configurations in modules. Modules may declare `required_providers`, but provider configuration belongs to the calling root module.
- Do not run any OpenTofu commands in this repository. Do not use `tofu init`, `tofu validate`, or any other `tofu` CLI commands during development or review.
- Each module `README.md` must include these exact markers for the `tofu_docs` pre-commit hook:

  ```markdown
  <!-- BEGINNING OF PRE-COMMIT-OPENTOFU DOCS HOOK -->

  <!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->
  ```

- Give every module variable user-friendly documentation that explains what it does and why it exists. For object variables, use a HEREDOC description documenting every object key and its default, for example:
- Add a `description` to every output value in a module so the consumer can understand what is being exposed and how it should be used.

  ```hcl
  variable "image" {
    type = object({
      uri     = string
      command = list(string)
    })

    description = <<-EOT
      Configuration for the container image used by the function.

      - uri: The image URI. Required, with no default.
      - command: The optional command list passed to the image. Defaults to [].
    EOT
  }
  ```
