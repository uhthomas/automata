package rasmus

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
				"rasmus.6f.io",
			]
			secretName: "rasmus-tls"
		}]
		rules: [{
			host: "rasmus.6f.io"
			http: paths: [{
				pathType: "ImplementationSpecific"
				backend: service: {
					name: "rasmus"
					port: name: "http"
				}
			}]
		}]
	}
}]
