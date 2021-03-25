package kipp_dev

import "k8s.io/api/core/v1"

namespace: v1.#NamespaceList & {
	apiVersion: "v1"
	kind:       "List"
}

namespace: items: [{
	apiVersion: "v1"
	kind:       "Namespace"
}]
