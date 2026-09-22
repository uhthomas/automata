# Automata

[![K8s](https://github.com/uhthomas/automata/actions/workflows/k8s-publish.yaml/badge.svg)](https://github.com/uhthomas/automata/actions/workflows/k8s-publish.yaml)

Monorepo and automation for owned infrastructure.

## Getting started

### Deploy manifests

```sh
./hack/k8s-deploy.sh magiclove
```

The optional second argument selects the OCI tag and defaults to `main`.
