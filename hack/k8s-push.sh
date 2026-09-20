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

root=$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd)
revision=$(git -C "$root" rev-parse HEAD)
temporary_directory=$(mktemp -d /tmp/automata-k8s-push.XXXXXX)
rendered="$temporary_directory/rendered.json"
artifact="$temporary_directory/artifact.json"

cleanup() {
	rm -rf "$temporary_directory"
}
trap cleanup 0

cue export "$root/k8s/magiclove/list.cue" --expression '#List' --out json >"$rendered"

jq --exit-status --arg tag "$tag" '
	if (type != "object") or ((.items | type) != "array") or ((.items | length) == 0) then
		error("rendered #List must contain at least one item")
	elif ([.items[] | select(.kind == "OCIRepository" and .metadata.name == "magiclove")] | length) != 1 then
		error("rendered #List must contain exactly one OCIRepository/magiclove")
	else
		(.items[] |
			select(.kind == "OCIRepository" and .metadata.name == "magiclove") |
			.spec.ref.tag
		) = $tag
	end
' "$rendered" >"$artifact"

flux push artifact "oci://ghcr.io/uhthomas/automata/magiclove:$tag" \
	--path=- \
	--source=https://github.com/uhthomas/automata \
	--revision="$tag@sha1:$revision" \
	--reproducible <"$artifact"
