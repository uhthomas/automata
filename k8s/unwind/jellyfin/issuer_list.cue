package jellyfin

import "k8s.io/api/core/v1"

#IssuerList: v1.#List & {
	apiVersion: "cert-manager.io/v1"
	kind:       "IssuerList"
	items: [...{
		apiVersion: "cert-manager.io/v1"
		kind:       "Issuer"
	}]
}

#IssuerList: items: [{spec: selfSigned: {}}]
