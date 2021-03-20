package query_frontend

import networkingv1 "k8s.io/api/networking/v1"

ingress: [...networkingv1.#Ingress]

ingress: [{
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	metadata: annotations: {
		"cert-manager.io/cluster-issuer":          "letsencrypt"
		"nginx.ingress.kubernetes.io/auth-url":    "http://oauth2-proxy.oauth2-proxy.svc.cluster.local/oauth2/auth"
		"nginx.ingress.kubernetes.io/auth-signin": "https://oauth2-proxy.mahalo.6f.io/oauth2/start?rd=$escaped_request_uri"
		"nginx.ingress.kubernetes.io/enable-cors": "true"
	}
	spec: {
		ingressClassName: "nginx"
		tls: [{
			hosts: [
				"thanos.6f.io",
			]
			secretName: "query-frontend-tls"
		}]
		rules: [{
			host: "thanos.6f.io"
			http: paths: [{
				pathType: "ImplementationSpecific"
				backend: service: {
					name: "query-frontend"
					port: name: "http"
				}
			}]
		}]
	}
}]
