package envoy_gateway

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
	metadata: name: "\(#Name)-ca"
	spec: {
		commonName: #Name
		secretName: "\(#Name)-ca"
		issuerRef: {
			kind: certmanagerv1.#IssuerKind
			name: "\(#Name)-selfsigned-issuer"
		}
		isCA: true
		privateKey: {
			algorithm: certmanagerv1.#RSAKeyAlgorithm
			size:      2048
		}
	}
}, {
	spec: {
		commonName: #Name
		dnsNames: [
			"\(#Name)",
			"\(#Name).\(#Namespace)",
			"\(#Name).\(#Namespace).svc",
			"\(#Name).\(#Namespace).svc.cluster.local",
		]
		secretName: #Name
		issuerRef: {
			kind: certmanagerv1.#IssuerKind
			name: "\(#Name)-issuer"
		}
		usages: [
			certmanagerv1.#UsageDigitalSignature,
			certmanagerv1.#UsageDataEncipherment,
			certmanagerv1.#UsageKeyEncipherment,
			certmanagerv1.#UsageContentCommitment,
		]
	}
}, {
	metadata: name: "envoy"
	spec: {
		commonName: "*"
		dnsNames: ["*.\(#Namespace)"]
		secretName: "envoy"
		issuerRef: {
			kind: certmanagerv1.#IssuerKind
			name: "\(#Name)-issuer"
		}
		usages: [
			certmanagerv1.#UsageDigitalSignature,
			certmanagerv1.#UsageDataEncipherment,
			certmanagerv1.#UsageKeyEncipherment,
			certmanagerv1.#UsageContentCommitment,
		]
	}
}, {
	metadata: name: "envoy-rate-limit"
	spec: {
		commonName: "*"
		dnsNames: ["*.\(#Namespace)"]
		secretName: "envoy-rate-limit"
		issuerRef: {
			kind: certmanagerv1.#IssuerKind
			name: "\(#Name)-issuer"
		}
		usages: [
			certmanagerv1.#UsageDigitalSignature,
			certmanagerv1.#UsageDataEncipherment,
			certmanagerv1.#UsageKeyEncipherment,
			certmanagerv1.#UsageContentCommitment,
		]
	}
}]
