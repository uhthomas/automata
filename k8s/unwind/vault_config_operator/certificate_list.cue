package vault_config_operator

import "k8s.io/api/core/v1"

#CertificateList: v1.#List & {
	apiVersion: "cert-manager.io/v1"
	kind:       "CertificateList"
	items: [...{
		apiVersion: "cert-manager.io/v1"
		kind:       "Certificate"
	}]
}

#CertificateList: items: [{
	metadata: name: "serving-cert"
	spec: {
		dnsNames: [
			"vault-config-operator-webhook-service.\(#Namespace).svc",
			"vault-config-operator-webhook-service.\(#Namespace).svc.cluster.local",
		]
		issuerRef: {
			kind: "Issuer"
			name: "selfsigned-issuer"
		}
		secretName: "webhook-server-cert"
	}
}, {
	metadata: name: "metrics-serving-cert"
	spec: {
		dnsNames: [
			"vault-config-operator-controller-manager-metrics-service.\(#Namespace).svc",
			"vault-config-operator-controller-manager-metrics-service.\(#Namespace).svc.cluster.local",
		]
		issuerRef: {
			kind: "Issuer"
			name: "selfsigned-issuer"
		}
		secretName: "vault-config-operator-certs"
	}
}]
