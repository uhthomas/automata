package webhook

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
	spec: {
		dnsNames: [
			#Name,
			"\(#Name).\(#Namespace)",
			"\(#Name).\(#Namespace).svc",
		]
		issuerRef: {
			kind: certmanagerv1.#IssuerKind
			name: #Name
		}
		secretName: #Name
	}
}]
