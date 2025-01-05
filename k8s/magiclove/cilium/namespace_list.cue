package cilium

import "k8s.io/api/core/v1"

#NamespaceList: v1.#NamespaceList & {
	apiVersion: "v1"
	kind:       "NamespaceList"
	items: [...{
		apiVersion: "v1"
		kind:       "Namespace"
	}]
}

#NamespaceList: items: [{
	metadata: {
		name: #Namespace
		labels: "pod-security.kubernetes.io/enforce": "privileged"
	}
}]
