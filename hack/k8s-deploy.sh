#!/bin/sh

set -eu

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
	echo "usage: $0 <cluster> [tag]" >&2
	exit 2
fi

root=$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd)

"$root/hack/k8s-push.sh" "$@"
exec "$root/hack/k8s-reconcile.sh" "$@"
