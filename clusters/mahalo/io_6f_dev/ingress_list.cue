package io_6f_dev

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
				"dev.6f.io",
				"io-6f-dev.mahalo.starjunk.net",
			]
			secretName: "io-6f-dev-tls"
		}]
		rules: [{
			host: "dev.6f.io"
			http: paths: [{
				pathType: "ImplementationSpecific"
				backend: service: {
					name: "io-6f-dev"
					port: name: "http"
				}
			}]
		}, {
			host: "io-6f-dev.mahalo.starjunk.net"
			http: paths: [{
				pathType: "ImplementationSpecific"
				backend: service: {
					name: "io-6f-dev"
					port: name: "http"
				}
			}]
		}]
	}
}]
