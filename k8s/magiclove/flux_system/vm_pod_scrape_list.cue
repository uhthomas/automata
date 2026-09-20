package flux_system

import operatorv1beta1 "github.com/VictoriaMetrics/operator/api/operator/v1beta1"

#VMPodScrapeList: operatorv1beta1.#VMPodScrapeList & {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMPodScrapeList"
	items: [...{
		apiVersion: "operator.victoriametrics.com/v1beta1"
		kind:       "VMPodScrape"
	}]
}

#VMPodScrapeList: items: [{
	spec: {
		jobLabel: "app.kubernetes.io/component"
		podMetricsEndpoints: [{port: "http-prom"}]
		selector: matchLabels: "app.kubernetes.io/part-of": #Name
	}
}]
