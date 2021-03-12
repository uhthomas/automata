package io_6f_dev

import networkingv1 "k8s.io/api/networking/v1"

ingress: [...networkingv1.#Ingress]

ingress: [{
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	metadata: {
		name: "io_6f"
		annotations: "cert-manager.io/cluster-issuer": "letsencrypt"
	}
	spec: {
		ingressClassName: "nginx"
		tls: [{
			hosts: [
				"dev.6f.io",
			]
			secretName: "io-6f-tls"
		}]
		rules: [{
			host: "dev.6f.io"
			http: paths: [{
				pathType: "ImplementationSpecific"
				backend: service: {
					name: "io_6f"
					port: name: "http"
				}
			}]
		}]
	}
}]
