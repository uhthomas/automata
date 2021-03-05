package kube_system

import (
	corev1 "k8s.io/api/core/v1"
	metrics_server "github.com/uhthomas/automata/clusters/desire/kube_system/metrics_server"
)

corev1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: namespace: "kube-system"
	}]
}

items: metrics_server.items
