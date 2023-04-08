package cockroach_operator_system

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
		name: "cockroach-operator-sa"
		labels: app: "cockroach-operator"
	}
}]
