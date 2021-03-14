package sealed_secrets

import "k8s.io/api/core/v1"

service: [...v1.#Service]

service: [{
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: name: "sealed-secrets-controller"
		name:      "sealed-secrets-controller"
	}
	spec: {
		ports: [{
			port:       8080
			targetPort: 8080
		}]
		selector: name: "sealed-secrets-controller"
		type: "ClusterIP"
	}
}]
