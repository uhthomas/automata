#!/bin/sh

set -eu

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
	echo "usage: $0 <cluster> [tag]" >&2
	exit 2
fi

cluster=$1
case "$cluster" in
	''|*[!a-z0-9-]*|-*|*-)
		echo "invalid cluster name: $cluster" >&2
		exit 2
		;;
esac

tag=${2-main}
case "$tag" in
	''|*[!A-Za-z0-9._-]*|[.-]*)
		echo "invalid OCI tag: $tag" >&2
		exit 2
		;;
esac

root=$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd)
if [ ! -f "$root/k8s/$cluster/list.cue" ]; then
	echo "unknown cluster: $cluster" >&2
	exit 2
fi

context="oidc@$cluster"

suspended=$(kubectl --context "$context" --namespace flux-system get "kustomization/$cluster" -o jsonpath='{.spec.suspend}')
if [ "$suspended" = "true" ]; then
	echo "kustomization/$cluster is already suspended; refusing to override operator state" >&2
	exit 1
fi

resume_on_exit=true
cleanup() {
	status=$?
	# A signal must not re-enter cleanup or run it again through the EXIT trap.
	trap - EXIT HUP INT TERM
	if [ "$resume_on_exit" = true ]; then
		# Only undo our suspension; deployment readiness must not block exit.
		if ! flux resume kustomization "$cluster" \
			--context "$context" --namespace flux-system --wait=false --timeout=10s; then
			echo "failed to resume kustomization/$cluster during cleanup; check its suspension state" >&2
		fi
	fi
	exit "$status"
}
trap cleanup EXIT
trap 'exit 129' HUP
trap 'exit 130' INT
trap 'exit 143' TERM

# The artifact contains the OCIRepository that supplies the artifact. A
# source switch must therefore be serialized: otherwise an in-flight apply of
# the old revision can restore its own tag while the new revision is applying,
# causing both revisions to alternate indefinitely. Arm cleanup first in case
# suspension succeeds but its response is lost or interrupted.
flux suspend kustomization "$cluster" \
	--context "$context" --namespace flux-system

kubectl --context "$context" --namespace flux-system wait "kustomization/$cluster" \
	--for=jsonpath='{.spec.suspend}'=true --timeout=30s
# Generation changes cancel any in-flight reconcile asynchronously. Give the
# controller a bounded moment to observe the suspension before changing the
# self-referential source.
sleep 2

kubectl --context "$context" --namespace flux-system patch "ocirepository/$cluster" \
	--type=merge -p "{\"spec\":{\"ref\":{\"tag\":\"$tag\"}}}"
flux reconcile source oci "$cluster" \
	--context "$context" --namespace flux-system

flux resume kustomization "$cluster" \
	--context "$context" --namespace flux-system --wait=true --timeout=10m
resume_on_exit=false
trap - EXIT HUP INT TERM
