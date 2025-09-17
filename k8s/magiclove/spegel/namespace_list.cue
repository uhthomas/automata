package spegel

import "k8s.io/api/core/v1"

#NamespaceList: v1.#NamespaceList & {
	apiVersion: "v1"
	kind:       "NamespaceList"
	items: [...{
		apiVersion: "v1"
		kind:       "Namespace"
	}]
}

#NamespaceList: items: [{metadata: labels: "pod-security.kubernetes.io/enforce": "privileged"}]
