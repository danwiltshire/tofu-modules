# Resource Naming

All resources should use the naming conventions outlined in this document.

Checkov rules in [checks/](../checks/) are used to enforce them where possible.

## OpenTofu Label Helper

All modules use the [label module](../utils/label/README.md) to provide the required
context to create compliant resource names. The context has three identifiers:

- `application`: A stable application identifier.
- `environment`: A deployment environment identifier.
- `id`: A stable workload, component, or instance identifier.

## Amazon Web Services (AWS)

| Service         | Resource  | Naming Convention                                           |
| --------------- | --------- | ----------------------------------------------------------- |
| CloudWatch      | Log Group | `/{application_name}/{environment_name}/{id}/{purpose}`     |
| RDS             | Instance  | `{application_name}-{environment_name}-{id}-instance-{0-9}` |
| Secrets Manager | Secret    | `/{application_name}/{environment_name}/{id}/{purpose}`     |
