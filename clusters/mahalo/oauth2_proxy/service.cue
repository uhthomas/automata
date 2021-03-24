package oauth2_proxy

import "k8s.io/api/core/v1"

service: [...v1.#Service]

service: [{
	apiVersion: "v1"
	kind:       "Service"
	spec: {
		ports: [{
			name:       "http"
			port:       80
			targetPort: "http"
		}]
		selector: {
			"app.kubernetes.io/name":      "oauth2-proxy"
			"app.kubernetes.io/instance":  "oauth2-proxy"
			"app.kubernetes.io/component": "oauth2-proxy"
		}
	}
}]
