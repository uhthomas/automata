package vault_config_operator

import "k8s.io/api/core/v1"

#ServiceList: v1.#ServiceList & {
	apiVersion: "v1"
	kind:       "ServiceList"
	items: [...{
		apiVersion: "v1"
		kind:       "Service"
	}]
}

#ServiceList: items: [{
	metadata: {
		name: "vault-config-operator-controller-manager-metrics-service"
		annotations: "service.alpha.openshift.io/serving-cert-secret-name": "vault-config-operator-certs"
		labels: "control-plane":                                            "vault-config-operator"
	}
	spec: {
		ports: [{
			name:       "https"
			port:       8443
			targetPort: "https"
		}]
		selector: "control-plane": "vault-config-operator"
	}
}, {
	metadata: {
		annotations: "service.alpha.openshift.io/serving-cert-secret-name": "webhook-server-cert"
		name: "vault-config-operator-webhook-service"
	}
	spec: {
		ports: [{
			port:       443
			targetPort: 9443
		}]
		selector: "control-plane": "vault-config-operator"
	}
}]
