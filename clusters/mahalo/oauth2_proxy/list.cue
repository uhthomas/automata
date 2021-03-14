package oauth2_proxy

import "k8s.io/api/core/v1"

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: namespace: "oauth2-proxy"
	}]
}

items: namespace +
	sealed_secret +
	service +
	deployment +
	horizontal_pod_autoscaler +
	ingress
