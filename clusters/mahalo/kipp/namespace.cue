package kipp

import "k8s.io/api/core/v1"

namespaceList: v1.#NamespaceList & {
	apiVersion: "v1"
	kind:       "NamespaceList"
}

namespaceList: items: [{
	apiVersion: "v1"
	kind:       "Namespace"
}]
