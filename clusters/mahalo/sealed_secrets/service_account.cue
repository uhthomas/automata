package sealed_secrets

import "k8s.io/api/core/v1"

service_account: [...v1.#ServiceAccount]

service_account: [{
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		labels: name: "sealed-secrets-controller"
		name: "sealed-secrets-controller"
	}
}]
