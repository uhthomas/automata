# Automata

[![K8s](https://github.com/uhthomas/automata/actions/workflows/k8s.yaml/badge.svg)](https://github.com/uhthomas/automata/actions/workflows/k8s.yaml)

Monorepo for Starjunk and subsidiaries.

## Getting started

### Prerequisites

* [Bazel](https://build.bazel)

### Apply manifests

```sh
# the managed-by label is pre-applied, so pruning is safe
bazel run //clusters:objects.apply -- --prune
```
