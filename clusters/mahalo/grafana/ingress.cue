package grafana

import networkingv1 "k8s.io/api/networking/v1"

ingress: [...networkingv1.#Ingress]

ingress: [{
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	metadata: {
		name: "grafana"
		annotations: {
			"cert-manager.io/cluster-issuer":          "letsencrypt"
			"nginx.ingress.kubernetes.io/auth-url":    "http://oauth2-proxy.oauth2-proxy.svc/oauth2/auth"
			"nginx.ingress.kubernetes.io/auth-signin": "https://oauth2-proxy.mahalo.6f.io/oauth2/start?rd=https://$host$request_uri"
		}
		labels: {
			"app.kubernetes.io/name":      "grafana"
			"app.kubernetes.io/instance":  "grafana"
			"app.kubernetes.io/version":   "7.4.3"
			"app.kubernetes.io/component": "grafana"
		}
	}
	spec: {
		ingressClassName: "nginx"
		tls: [{
			hosts: [
				"grafana.mahalo.6f.io",
			]
			secretName: "grafana-tls"
		}]
		rules: [{
			host: "grafana.mahalo.6f.io"
			http: paths: [{
				pathType: "ImplementationSpecific"
				backend: service: {
					name: "grafana"
					port: name: "http"
				}
			}]
		}]
	}
}]
