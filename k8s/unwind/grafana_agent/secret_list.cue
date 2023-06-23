package grafana_agent

import (
	"encoding/yaml"

	"k8s.io/api/core/v1"
)

#SecretList: v1.#SecretList & {
	apiVersion: "v1"
	kind:       "SecretList"
	items: [...{
		apiVersion: "v1"
		kind:       "Secret"
	}]
}

#SecretList: items: [{
	metadata: name:    "\(#Name)-additional-scrape-configs"
	data: "jobs.yaml": '\(yaml.Marshal([{
		job_name: "kubernetes-pods"
		kubernetes_sd_configs: [{role: "pod"}]
		honor_labels: true
		relabel_configs: [{
			source_labels: ["__meta_kubernetes_service_annotation_prometheus_io_scrape"]
			action: "keep"
			regex:  true
		}]
	}, {
		job_name: "kubernetes-services"
		kubernetes_sd_configs: [{role: "service"}]
		honor_labels: true
	}]))'
}]
