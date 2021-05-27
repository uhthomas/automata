package kube_system

import (
	"k8s.io/api/core/v1"
	metrics_server "github.com/uhthomas/automata/k8s/pillowtalk/kube_system/metrics_server"
)

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{metadata: namespace: "kube-system"}]
}

list: items: metrics_server.items
