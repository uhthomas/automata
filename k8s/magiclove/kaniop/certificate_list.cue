package kaniop

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
	metadata: name: "\(#Name)-webhook-root-cert"
	spec: {
		secretName: "\(#Name)-webhook-root-cert"
		duration:   "43800h0m0s"
		issuerRef: {
			kind: certmanagerv1.#IssuerKind
			name: "\(#Name)-self-signed-issuer"
		}
		commonName: "ca.webhook.\(#Name)"
		isCA:       true
		subject: organizations: [#Name]
	}
}, {
	metadata: name: "\(#Name)-webhook-cert"
	spec: {
		secretName: "\(#Name)-webhook-cert"
		duration:   "8760h0m0s"
		issuerRef: {
			kind: certmanagerv1.#IssuerKind
			name: "\(#Name)-root-issuer"
		}
		dnsNames: [
			"\(#Name)-webhook",
			"\(#Name)-webhook.\(#Namespace)",
			"\(#Name)-webhook.\(#Namespace).svc",
			"\(#Name)-webhook.\(#Namespace).svc.cluster.local",
		]
		subject: organizations: [#Name]
	}
}]
