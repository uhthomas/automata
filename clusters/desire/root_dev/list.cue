package root_dev

import corev1 "k8s.io/api/core/v1"

corev1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: namespace: "root-dev"
	}]
}

items: [namespace, deployment, hpa, service, ingress]
