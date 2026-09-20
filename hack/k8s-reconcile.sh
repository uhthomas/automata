#!/bin/sh

set -eu

if [ "$#" -ne 1 ]; then
	echo "usage: $0 <tag>" >&2
	exit 2
fi

tag=$1
case "$tag" in
	''|*[!A-Za-z0-9._-]*|[.-]*)
		echo "invalid OCI tag: $tag" >&2
		exit 2
		;;
esac

if [ "$(kubectl --context oidc@magiclove --namespace flux-system get kustomization/magiclove -o jsonpath='{.spec.suspend}')" = "true" ]; then
	echo "kustomization/magiclove is already suspended; refusing to override operator state" >&2
	exit 1
fi

# The magiclove artifact contains the OCIRepository that supplies the artifact.
# Serialize source switches so an in-flight apply cannot restore its own tag
# while the new revision is applying and make both revisions alternate.
flux suspend kustomization magiclove \
	--context oidc@magiclove --namespace flux-system

resume_on_exit=true
resume() {
	if [ "$resume_on_exit" = true ]; then
		flux resume kustomization magiclove \
			--context oidc@magiclove --namespace flux-system >/dev/null 2>&1 || true
	fi
}
trap resume EXIT HUP INT TERM

kubectl --context oidc@magiclove --namespace flux-system wait kustomization/magiclove \
	--for=jsonpath='{.spec.suspend}'=true --timeout=30s
# Generation changes cancel any in-flight reconcile asynchronously. Give the
# controller a bounded moment to observe the suspension before changing the
# self-referential source.
sleep 2

kubectl --context oidc@magiclove --namespace flux-system patch ocirepository/magiclove \
	--type=merge -p "{\"spec\":{\"ref\":{\"tag\":\"$tag\"}}}"
flux reconcile source oci magiclove \
	--context oidc@magiclove --namespace flux-system

flux resume kustomization magiclove \
	--context oidc@magiclove --namespace flux-system --timeout=10m
resume_on_exit=false
trap - EXIT HUP INT TERM
