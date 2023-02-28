package grafana

import "k8s.io/api/core/v1"

namespaceList: v1.#NamespaceList & {
	apiVersion: "v1"
	kind:       "NamespaceList"
	items: [...{
		apiVersion: "v1"
		kind:       "Namespace"
	}]
}

namespaceList: items: [{metadata: labels: "pod-security.kubernetes.io/enforce": "privileged"}]
