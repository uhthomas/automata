package kipp

import networkingv1 "k8s.io/api/networking/v1"

ingress: [...networkingv1.#Ingress]

ingress: [{
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	metadata: annotations: {
		"cert-manager.io/cluster-issuer":                      "letsencrypt"
		"nginx.ingress.kubernetes.io/proxy-body-size":         "150m"
		"nginx.ingress.kubernetes.io/proxy-request-buffering": "off"
	}
	spec: {
		ingressClassName: "nginx"
		tls: [{
			hosts: [
				"kipp.6f.io",
			]
			secretName: "kipp-tls"
		}]
		rules: [{
			host: "kipp.6f.io"
			http: paths: [{
				pathType: "ImplementationSpecific"
				backend: service: {
					name: "kipp"
					port: name: "http"
				}
			}]
		}]
	}
}]
