package promlens

import networkingv1 "k8s.io/api/networking/v1"

ingress: networkingv1.#Ingress & {
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	metadata: {
		name: "promlens"
		annotations: {
			"cert-manager.io/cluster-issuer":          "letsencrypt"
			"nginx.ingress.kubernetes.io/auth-url":    "https://sso.6f.io/oauth2/auth"
			"nginx.ingress.kubernetes.io/auth-signin": "https://sso.6f.io/oauth2/start?rd=https://$host$request_uri"
		}
	}
	spec: {
		ingressClassName: "nginx"
		tls: [{
			hosts: [
				"promlens.6f.io",
			]
			secretName: "promlens-tls"
		}]
		rules: [{
			host: "promlens.6f.io"
			http: paths: [{
				pathType: "ImplementationSpecific"
				backend: service: {
					name: "promlens"
					port: name: "http"
				}
			}]
		}]
	}
}
