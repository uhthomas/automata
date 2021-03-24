package oauth2_proxy

import networkingv1 "k8s.io/api/networking/v1"

ingress: [...networkingv1.#Ingress]

ingress: [{
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	metadata: annotations: "cert-manager.io/cluster-issuer": "letsencrypt"
	spec: {
		ingressClassName: "nginx"
		tls: [{
			hosts: [
				"oauth2-proxy.mahalo.6f.io",
			]
			secretName: "oauth2-proxy-tls"
		}]
		rules: [{
			host: "oauth2-proxy.mahalo.6f.io"
			http: paths: [{
				pathType: "ImplementationSpecific"
				backend: service: {
					name: "oauth2-proxy"
					port: name: "http"
				}
			}]
		}]
	}
}]
