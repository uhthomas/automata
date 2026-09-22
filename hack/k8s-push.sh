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

revision=$(git -C "$root" rev-parse HEAD)
temporary_directory=$(mktemp -d /tmp/automata-k8s-push.XXXXXX)
rendered="$temporary_directory/rendered.json"
artifact="$temporary_directory/artifact.json"

cleanup() {
	rm -rf "$temporary_directory"
}
trap cleanup 0

cue export "$root/k8s/$cluster/list.cue" --expression '#List' --out json >"$rendered"

jq --exit-status --arg cluster "$cluster" --arg tag "$tag" '
	if (type != "object") or ((.items | type) != "array") or ((.items | length) == 0) then
		error("rendered #List must contain at least one item")
	elif ([.items[] | select(.kind == "OCIRepository" and .metadata.name == $cluster)] | length) != 1 then
		error("rendered #List must contain exactly one OCIRepository/\($cluster)")
	else
		(.items[] |
			select(.kind == "OCIRepository" and .metadata.name == $cluster) |
			.spec.ref.tag
		) = $tag
	end
' "$rendered" >"$artifact"

flux push artifact "oci://ghcr.io/uhthomas/automata/$cluster:$tag" \
	--path=- \
	--source=https://github.com/uhthomas/automata \
	--revision="$tag@sha1:$revision" \
	--reproducible <"$artifact"
