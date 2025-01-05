package magiclove

import certmanagerv1 "github.com/cert-manager/cert-manager/pkg/apis/certmanager/v1"

#ClusterIssuerList: certmanagerv1.#ClusterIssuerList & {
	apiVersion: "cert-manager.io/v1"
	kind:       "ClusterIssuerList"
	items: [...{
		apiVersion: "cert-manager.io/v1"
		kind:       "ClusterIssuer"
	}]
}

#ClusterIssuerList: items: [{
	metadata: name: "self-signed"
	spec: selfSigned: {}
}, {
	metadata: name: "self-signed-ca"
	spec: ca: secretName: "self-signed-ca"
}, {
	metadata: name: "letsencrypt"
	spec: acme: {
		email:  "letsencrypt@hipparcos.net"
		server: "https://acme-v02.api.letsencrypt.org/directory"
		privateKeySecretRef: name: "letsencrypt"
		solvers: [{
			dns01: cloudflare: apiTokenSecretRef: {
				name: "cloudflare-api-token"
				key:  "api-token"
			}
		}]
	}
}]
