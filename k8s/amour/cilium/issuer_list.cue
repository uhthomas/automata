package cilium

import certmanagerv1 "github.com/cert-manager/cert-manager/pkg/apis/certmanager/v1"

#IssuerList: certmanagerv1.#IssuerList & {
	apiVersion: "cert-manager.io/v1"
	kind:       "IssuerList"
	items: [...{
		apiVersion: "cert-manager.io/v1"
		kind:       "Issuer"
	}]
}

#IssuerList: items: [{
	metadata: name: "cilium"
	spec: selfSigned: {}
}, {
	metadata: name: "cilium-ca"
	spec: ca: secretName: "cilium-ca"
}]
