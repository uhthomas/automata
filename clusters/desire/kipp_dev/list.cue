package kipp_dev

import corev1 "k8s.io/api/core/v1"

corev1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: namespace: "kipp-dev"
	}]
}

items: [namespace, sealed_secret, deployment, hpa, service, ingress]
