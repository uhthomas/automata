package node_exporter

import operatorv1beta1 "github.com/VictoriaMetrics/operator/api/operator/v1beta1"

#VMServiceScrapeList: operatorv1beta1.#VMServiceScrapeList & {
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
