package postgres_operator

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
	metadata: labels: "postgres-operator.crunchydata.com/control-plane": #Name
}, {
	metadata: {
		name: "\(#Name)-upgrade"
		labels: "postgres-operator.crunchydata.com/control-plane": "\(#Name)-upgrade"
	}
}]
