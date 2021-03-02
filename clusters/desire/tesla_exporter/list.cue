package tesla_exporter

import corev1 "k8s.io/api/core/v1"

corev1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: namespace: "tesla-exporter"
	}]
}

items: [namespace, sealed_secret, deployment]
