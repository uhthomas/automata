package io_6f

import networkingv1 "k8s.io/api/networking/v1"

ingressList: networkingv1.#IngressList & {
	apiVersion: "networking.k8s.io/v1"
	kind:       "IngressList"
	items: [...{
		apiVersion: "networking.k8s.io/v1"
		kind:       "Ingress"
	}]
}

ingressList: items: [{
	metadata: annotations: "cert-manager.io/cluster-issuer": "letsencrypt"
	spec: {
		ingressClassName: "nginx"
		tls: [{
			hosts: [
				"6f.io",
				"www.6f.io",
			]
			secretName: "io-6f-tls"
		}]
		rules: [{
			host: "6f.io"
			http: paths: [{
				pathType: "ImplementationSpecific"
				backend: service: {
					name: "io-6f"
					port: name: "http"
				}
			}]
		}, {
			host: "www.6f.io"
			http: paths: [{
				pathType: "ImplementationSpecific"
				backend: service: {
					name: "io-6f"
					port: name: "http"
				}
			}]
		}]
	}
}]
