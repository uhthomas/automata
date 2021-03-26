package io_6f_dev

import "k8s.io/api/core/v1"

namespaceList: v1.#NamespaceList & {
	apiVersion: "v1"
	kind:       "List"
}

namespaceList: items: [{
	apiVersion: "v1"
	kind:       "Namespace"
}]
