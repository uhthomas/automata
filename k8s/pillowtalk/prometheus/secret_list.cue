package prometheus

import (
	"encoding/yaml"
	"k8s.io/api/core/v1"
)

secretList: v1.#SecretList & {
	apiVersion: "v1"
	kind:       "SecretList"
	items: [...{
		apiVersion: "v1"
		kind:       "Secret"
	}]
}

secretList: items: [{
	metadata: name: "additional-scrape-configs"
	data: "prometheus-additional.yaml": '\(yaml.Marshal([{
		job_name: "kubernetes-pods"
		kubernetes_sd_configs: [{
			role: "pod"
		}]
		relabel_configs: [{
			source_labels: ["__meta_kubernetes_pod_annotation_prometheus_io_scrape"]
			action: "keep"
			regex:  true
		}, {
			source_labels: ["__meta_kubernetes_pod_annotation_prometheus_io_path"]
			action:       "replace"
			target_label: "__metrics_path__"
			regex:        "(.+)"
		}, {
			source_labels: ["__address__", "__meta_kubernetes_pod_annotation_prometheus_io_port"]
			action:       "replace"
			regex:        "([^:]+)(?::\\d+)?;(\\d+)"
			replacement:  "$1:$2"
			target_label: "__address__"
		}, {
			action: "labelmap"
			regex:  "__meta_kubernetes_pod_label_(.+)"
		}, {
			source_labels: ["__meta_kubernetes_namespace"]
			action:       "replace"
			target_label: "kubernetes_namespace"
		}, {
			source_labels: ["__meta_kubernetes_pod_name"]
			action:       "replace"
			target_label: "kubernetes_pod_name"
		}]
	}, {
		job_name: "kubernetes-service"
		kubernetes_sd_configs: [{
			role: "service"
		}]
		relabel_configs: [{
			source_labels: ["__meta_kubernetes_service_annotation_prometheus_io_scrape"]
			action: "keep"
			regex:  true
		}, {
			source_labels: ["__meta_kubernetes_service_annotation_prometheus_io_path"]
			action:       "replace"
			target_label: "__metrics_path__"
			regex:        "(.+)"
		}, {
			source_labels: ["__address__", "__meta_kubernetes_service_annotation_prometheus_io_port"]
			action:       "replace"
			regex:        "([^:]+)(?::\\d+)?;(\\d+)"
			replacement:  "$1:$2"
			target_label: "__address__"
		}, {
			action: "labelmap"
			regex:  "__meta_kubernetes_service_label_(.+)"
		}, {
			source_labels: ["__meta_kubernetes_namespace"]
			action:       "replace"
			target_label: "kubernetes_namespace"
		}, {
			source_labels: ["__meta_kubernetes_service_name"]
			action:       "replace"
			target_label: "kubernetes_service_name"
		}]
	}]))'
}]
