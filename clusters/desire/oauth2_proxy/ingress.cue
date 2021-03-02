package oauth2_proxy

import networkingv1 "k8s.io/api/networking/v1"

ingress: networkingv1.#Ingress & {
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	metadata: {
		name: "oauth2-proxy"
		annotations: "cert-manager.io/cluster-issuer": "letsencrypt"
	}
	spec: {
		ingressClassName: "nginx"
		tls: [{
			hosts: [
				"sso.6f.io",
			]
			secretName: "oauth2-proxy-tls"
		}]
		rules: [{
			host: "sso.6f.io"
			http: paths: [{
				pathType: "ImplementationSpecific"
				backend: service: {
					name: "oauth2-proxy"
					port: name: "http"
				}
			}]
		}]
	}
}
