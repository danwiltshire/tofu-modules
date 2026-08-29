# OpenTofu Modules

This repository contains a small OpenTofu module library developed for my own projects. Others are welcome to use the modules, but I do not provide support, troubleshooting, or guaranteed compatibility beyond my own use.

## Modules

See the project wiki for module details and usage notes: https://github.com/danielwiltshire/tofu-modules/wiki

## Other Documentation

| Document                                                           | Purpose                         |
| ------------------------------------------------------------------ | ------------------------------- |
| [RESOURCE_NAMING.md](./conventions/RESOURCE_NAMING.md)             | Resource naming conventions.    |
| [ROOT_MODULE_STRUCTURE.md](./conventions/ROOT_MODULE_STRUCTURE.md) | Expected root module structure. |

## Development

This repository expects the following tooling:

- Python >= 3.14
- `uv`
- `pre-commit`

Set up a local development environment with:

```bash
uv sync
pre-commit install
```
