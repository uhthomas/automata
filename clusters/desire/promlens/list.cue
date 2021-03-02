package promlens

import corev1 "k8s.io/api/core/v1"

corev1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: namespace: "promlens"
	}]
}

items: [namespace, deployment, hpa, service, ingress]
