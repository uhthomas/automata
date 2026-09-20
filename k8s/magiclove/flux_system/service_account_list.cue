package flux_system

import "k8s.io/api/core/v1"

#ServiceAccountList: v1.#ServiceAccountList & {
	apiVersion: "v1"
	kind:       "ServiceAccountList"
	items: [...{
		apiVersion: "v1"
		kind:       "ServiceAccount"
	}]
}

#ServiceAccountList: items: [{
	metadata: {
		name: "source-controller"
		labels: "app.kubernetes.io/component": "source-controller"
	}
}, {
	metadata: {
		name: "kustomize-controller"
		labels: "app.kubernetes.io/component": "kustomize-controller"
	}
}]
