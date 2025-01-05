package cert_manager

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
	metadata: name: "self-signed-ca"
	spec: {
		dnsNames: ["self-signed-ca"]
		secretName: "self-signed-ca"
		issuerRef: {
			kind: certmanagerv1.#ClusterIssuerKind
			name: "self-signed"
		}
		isCA: true
		privateKey: rotationPolicy: "Always"
	}
}]
