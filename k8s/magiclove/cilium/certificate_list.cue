package cilium

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
	metadata: name: "cilium-ca"
	spec: {
		dnsNames: ["cilium.io"]
		secretName: "cilium-ca"
		issuerRef: {
			kind: certmanagerv1.#IssuerKind
			name: "cilium"
		}
		isCA: true
		privateKey: rotationPolicy: "Always"
	}
}, {
	metadata: name: "hubble-server-certs"
	spec: {
		dnsNames: ["*.default.hubble-grpc.cilium.io"]
		secretName: "hubble-server-certs"
		issuerRef: {
			kind: certmanagerv1.#IssuerKind
			name: "cilium-ca"
		}
		privateKey: rotationPolicy: "Always"
	}
}]
