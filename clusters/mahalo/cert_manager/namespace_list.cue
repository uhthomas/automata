package cert_manager

import "k8s.io/api/core/v1"

namespaceList: v1.#NamespaceList & {
	apiVersion: "v1"
	kind:       "NamespaceList"
	items: [...{
		apiVersion: "v1"
		kind:       "Namespace"
	}]
}

namespaceList: items: [{
	metadata: {
		name: "cert-manager"
		labels: "certmanager.k8s.io/disable-validation": "true"
	}
}]
