package sealed_secrets

import "k8s.io/api/core/v1"

serviceAccountList: v1.#ServiceAccountList & {
	apiVersion: "v1"
	kind:       "ServiceAccountList"
	items: [...{
		apiVersion: "v1"
		kind:       "ServiceAccount"
	}]
}

serviceAccountList: items: [{
	metadata: {
		labels: name: "sealed-secrets-controller"
		name: "sealed-secrets-controller"
	}
}]
