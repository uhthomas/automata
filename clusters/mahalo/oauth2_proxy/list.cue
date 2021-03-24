package oauth2_proxy

import "k8s.io/api/core/v1"

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      "oauth2-proxy"
			namespace: "oauth2-proxy"
			labels: {
				"app.kubernetes.io/name":      "oauth2-proxy"
				"app.kubernetes.io/instance":  "oauth2-proxy"
				"app.kubernetes.io/version":   "7.0.1"
				"app.kubernetes.io/component": "oauth2-proxy"
			}
		}
	}]
}

items: namespace +
	sealed_secret +
	service +
	deployment +
	horizontal_pod_autoscaler +
	ingress
