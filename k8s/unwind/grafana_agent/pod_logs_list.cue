package grafana_agent

import "k8s.io/api/core/v1"

#PodLogsList: v1.#List & {
	apiVersion: "monitoring.grafana.com/v1alpha1"
	kind:       "PodLogsList"
	items: [...{
		apiVersion: "monitoring.grafana.com/v1alpha1"
		kind:       "PodLogs"
	}]
}

#PodLogsList: items: [{
	metadata: name: "\(#Name)-kubernetes-logs"
	spec: {
		namespaceSelector: any: true
		pipelineStages: [{cri: {}}]
		relabelings: [{
			sourceLabels: ["__meta_kubernetes_pod_node_name"]
			targetLabel: "__host__"
		}, {
			action: "labelmap"
			regex:  "__meta_kubernetes_pod_label_(.+)"
		}, {
			action: "replace"
			sourceLabels: ["__meta_kubernetes_namespace"]
			targetLabel: "namespace"
		}, {
			action: "replace"
			sourceLabels: ["__meta_kubernetes_pod_name"]
			targetLabel: "pod"
		}, {
			action: "replace"
			sourceLabels: ["__meta_kubernetes_container_name"]
			targetLabel: "container"
		}, {
			replacement: "/var/log/pods/*$1/*.log"
			separator:   "/"
			sourceLabels: [
				"__meta_kubernetes_pod_uid",
				"__meta_kubernetes_pod_container_name",
			]
			targetLabel: "__path__"
		}]
		selector: matchLabels: {}
	}
}]
