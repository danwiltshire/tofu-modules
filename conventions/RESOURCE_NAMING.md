# Resource Naming

All resources should use the naming conventions outlined in this document.

Checkov rules in [checks/](../checks/) are used to enforce them where possible.

## OpenTofu Label Helper

All modules use the [label module](../utils/label/README.md) to provide the required
context to create compliant resource names. The context has these identifiers:

- `application`: A stable application identifier.
- `environment`: A deployment environment identifier.
- `component`: A stable workload or subsystem identifier.
- `resource_purpose`: An optional identifier describing the resource's purpose.

## Amazon Web Services (AWS)

| Service         | Resource  | Naming Convention                                                       |
| --------------- | --------- | ----------------------------------------------------------------------- |
| CloudWatch      | Log Group | `/{application_name}/{environment_name}/{component}/{resource_purpose}` |
| RDS             | Instance  | `{application_name}-{environment_name}-{component}-instance-{0-9}`      |
| Secrets Manager | Secret    | `/{application_name}/{environment_name}/{component}/{resource_purpose}` |
