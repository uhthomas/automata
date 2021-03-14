package oauth2_proxy

import corev1 "k8s.io/api/core/v1"

service: [...corev1.#Service]

service: [{
	apiVersion: "v1"
	kind:       "Service"
	metadata: name: "oauth2-proxy"
	spec: {
		ports: [{
			name:       "http"
			port:       80
			targetPort: "http"
		}]
		selector: app: "oauth2-proxy"
	}
}]
