# Resource Naming

All resources should use the naming conventions outlined in this document.

Checkov rules in [checks/](../checks/) are used to enforce them where possible.

## Root Module Context

Each root module defines the required context in its `variables.tf`. See [Root Module
Structure](ROOT_MODULE_STRUCTURE.md) for the standard root-module layout. The context
has these identifiers:

- `application`: A stable application identifier.
- `environment`: A deployment environment identifier.
- `component`: A stable workload or subsystem identifier.

Resource modules can require `resource_purpose`, an identifier describing the
resource's purpose. Add it to the downstream module's context with `merge()`.

## Amazon Web Services (AWS)

| Service         | Resource  | Naming Convention                                                       |
| --------------- | --------- | ----------------------------------------------------------------------- |
| CloudWatch      | Log Group | `/{application_name}/{environment_name}/{component}/{resource_purpose}` |
| RDS             | Instance  | `{application_name}-{environment_name}-{component}-instance-{0-9}`      |
| Secrets Manager | Secret    | `/{application_name}/{environment_name}/{component}/{resource_purpose}` |
