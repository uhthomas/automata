package node_exporter

import "k8s.io/api/core/v1"

// TODO: Use generated types.
//
// https://github.com/cue-lang/cue/issues/2466
#VMServiceScrapeList: v1.#List & {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMServiceScrapeList"
	items: [...{
		apiVersion: "operator.victoriametrics.com/v1beta1"
		kind:       "VMServiceScrape"
	}]
}

#VMServiceScrapeList: items: [{
	spec: {
		jobLabel: "app.kubernetes.io/name"
		endpoints: [{
			port: "http-metrics"
			metricRelabelConfigs: [{
				source_labels: ["mountpoint"]
				regex:  "/var/lib/kubelet/pods.+"
				action: "drop"
			}]
		}]
		selector: matchLabels: "app.kubernetes.io/name": #Name
	}
}]
