# Automata

[![K8s](https://github.com/uhthomas/automata/actions/workflows/k8s.yaml/badge.svg)](https://github.com/uhthomas/automata/actions/workflows/k8s.yaml)

Monorepo and automation for owned infrastructure.

## Getting started

### Prerequisites

* [Bazel](https://build.bazel)

### Apply manifests

```sh
bazel run //k8s:objects.apply
```
