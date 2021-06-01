package pillowtalk

import "k8s.io/api/core/v1"

clusterIssuerList: v1.#List & {
	apiVersion: "cert-manager.io/v1"
	kind:       "ClusterIssuerList"
	items: [...{
		apiVersion: "cert-manager.io/v1"
		kind:       "ClusterIssuer"
	}]
}

clusterIssuerList: items: [{
	metadata: name: "letsencrypt"
	spec: acme: {
		email:  "pillowtalk@starjunk.net"
		server: "https://acme-v02.api.letsencrypt.org/directory"
		privateKeySecretRef: name: "letsencrypt"
		solvers: [{http01: ingress: class: "nginx"}]
	}
}]
