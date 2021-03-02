package root_dev

import networkingv1 "k8s.io/api/networking/v1"

ingress: networkingv1.#Ingress & {
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	metadata: {
		name: "root"
		annotations: "cert-manager.io/cluster-issuer": "letsencrypt"
	}
	spec: {
		ingressClassName: "nginx"
		tls: [{
			hosts: [
				"dev.6f.io",
			]
			secretName: "root-tls"
		}]
		rules: [{
			host: "dev.6f.io"
			http: paths: [{
				pathType: "ImplementationSpecific"
				backend: service: {
					name: "root"
					port: name: "http"
				}
			}]
		}]
	}
}
