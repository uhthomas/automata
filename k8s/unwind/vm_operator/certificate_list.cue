package vm_operator

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
	metadata: name: "\(#Name)-webhook"
	spec: {
		dnsNames: [
			"\(#Name)-webhook.\(#Namespace).svc",
			"\(#Name)-webhook.\(#Namespace).svc.cluster.local",
		]
		issuerRef: {
			kind: certmanagerv1.#IssuerKind
			name: "\(#Name)-selfsigned-issuer"
		}
		secretName: "\(metadata.name)-certificate"
	}
}]
