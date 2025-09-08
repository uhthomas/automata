package hubble_relay

import certmanagerv1 "github.com/cert-manager/cert-manager/pkg/apis/certmanager/v1"

#CertificateList: certmanagerv1.#CertificateList & {
	apiVersion: "cert-manager.io/v1"
	kind:       "CertificateList"
	items: [...{
		apiVersion: "cert-manager.io/v1"
		kind:       "Certificate"
	}]
}

#CertificateList: items: [{
	metadata: name: "hubble-relay-client-certs"
	spec: {
		dnsNames: ["*.hubble-relay.cilium.io"]
		secretName: "hubble-relay-client-certs"
		issuerRef: {
			kind: certmanagerv1.#IssuerKind
			name: "cilium-ca"
		}
		isCA: false
		usages: [
			certmanagerv1.#UsageSigning,
			certmanagerv1.#UsageKeyEncipherment,
			certmanagerv1.#UsageClientAuth,
		]
	}
}, {
	metadata: name: "hubble-relay-server-certs"
	spec: {
		dnsNames: ["*.hubble-relay.cilium.io"]
		secretName: "hubble-relay-server-certs"
		issuerRef: {
			kind: certmanagerv1.#IssuerKind
			name: "cilium-ca"
		}
		isCA: false
		usages: [
			certmanagerv1.#UsageSigning,
			certmanagerv1.#UsageKeyEncipherment,
			certmanagerv1.#UsageServerAuth,
			certmanagerv1.#UsageClientAuth,
		]
	}
}]
