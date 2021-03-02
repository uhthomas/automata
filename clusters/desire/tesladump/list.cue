package tesladump

import corev1 "k8s.io/api/core/v1"

corev1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: namespace: "tesladump"
	}]
}

items: [namespace, sealed_secret, deployment, service, cron_job]
