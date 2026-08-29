# Resource Naming

All modules use the label context to create deterministic resource names. The context has three identifiers:

- `application`: A stable application identifier.
- `environment`: A deployment environment identifier.
- `id`: A stable workload, component, or instance identifier.

Use hyphens for resource names by default:

```text
{application}-{environment}-{id}-{purpose}
```

Use forward slashes when hierarchy makes a name easier to understand or manage, including AWS Secrets Manager secrets and AWS Systems Manager Parameter Store parameters:

```text
/{application}/{environment}/{id}/{purpose}
```

## Examples

AWS Secrets Manager secret:

```text
/{application_name}/{environment_name}/{id}/master-credentials
```

IAM role:

```text
{application_name}-{environment_name}-{id}-task-execution-role
```

For example, an API workload for the `bart` application in `prod` becomes:

```text
/bart/prod/api/master-credentials
bart-prod-api-task-execution-role
```
