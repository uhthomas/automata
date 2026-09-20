#!/bin/sh

set -eu

root=$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd)

"$root/hack/k8s-push.sh" "$@"
"$root/hack/k8s-reconcile.sh" "$@"
