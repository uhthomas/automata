#!/bin/sh

set -eu

if [ "$#" -ne 1 ]; then
	echo "usage: $0 <cluster>" >&2
	exit 2
fi

cluster=$1
case "$cluster" in
	''|*[!a-z0-9-]*|-*|*-)
		echo "invalid cluster name: $cluster" >&2
		exit 2
		;;
esac

context="oidc@$cluster"
temporary_directory=$(mktemp -d /tmp/automata-k8s-orphans.XXXXXX)
trap 'rm -rf "$temporary_directory"' 0
trap 'exit 130' INT
trap 'exit 143' TERM

kubectl --context "$context" --namespace flux-system \
	get "kustomizations.kustomize.toolkit.fluxcd.io/$cluster" -o json >"$temporary_directory/before.json"

kubectl --context "$context" api-resources --verbs=list -o name >"$temporary_directory/resources"
resources=$(paste -sd, "$temporary_directory/resources")
kubectl --context "$context" get "$resources" --all-namespaces \
	--selector "kustomize.toolkit.fluxcd.io/name=$cluster,kustomize.toolkit.fluxcd.io/namespace=flux-system" \
	--show-managed-fields -o json >"$temporary_directory/live.json"

kubectl --context "$context" --namespace flux-system \
	get "kustomizations.kustomize.toolkit.fluxcd.io/$cluster" -o json >"$temporary_directory/after.json"

jq --raw-output --arg cluster "$cluster" \
	--slurpfile before "$temporary_directory/before.json" \
	--slurpfile after "$temporary_directory/after.json" '
	def group: .apiVersion | split("/") | if length == 1 then "" else .[0] end;
	# Flux encodes colons in RBAC names as double underscores in inventory IDs.
	def id:
		(if group == "rbac.authorization.k8s.io" then .metadata.name | gsub(":"; "__") else .metadata.name end) as $name |
		[.metadata.namespace // "", $name, group, .kind] | join("_");

	$before[0] as $ks |
	if $ks.metadata.resourceVersion != $after[0].metadata.resourceVersion then
		error("Kustomization changed during the scan; retry")
	elif ($ks.status.inventory.entries | type) != "array"
		or $ks.status.observedGeneration != $ks.metadata.generation
		or (any($ks.status.conditions[]?; .type == "Ready" and .status == "True") | not)
		or any($ks.status.conditions[]?; .type == "Reconciling" and .status == "True") then
		error("Kustomization has no settled, ready inventory")
	else
		($ks.status.inventory.entries | map({key: .id, value: true}) | from_entries) as $inventory |
		[.items[] |
			select(.metadata.labels["kustomize.toolkit.fluxcd.io/name"] == $cluster) |
			select(.metadata.labels["kustomize.toolkit.fluxcd.io/namespace"] == "flux-system") |
			# Generated objects can inherit Flux labels without being applied by Flux.
			select(any(.metadata.managedFields[]?;
				.manager == "kustomize-controller" and .operation == "Apply"
				and (.subresource // "") == "")) |
			select($inventory[id] != true) |
			[.metadata.namespace // "-", (.kind + (if group == "" then "" else "." + group end)), .metadata.name]
		] | unique[] | @tsv
	end
' "$temporary_directory/live.json"
