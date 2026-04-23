package kube_state_metrics

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
			port:        "http-metrics"
			honorLabels: true
			metricRelabelConfigs: [{
				action: "labeldrop"
				regex:  "(uid|container_id|image_id)"
			}]
		}]
		selector: matchLabels: "app.kubernetes.io/name": #Name
	}
}]
