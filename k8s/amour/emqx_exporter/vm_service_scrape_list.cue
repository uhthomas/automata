package emqx_exporter

import victoriametricsv1beta1 "github.com/VictoriaMetrics/operator/api/victoriametrics/v1beta1"

#VMServiceScrapeList: victoriametricsv1beta1.#VMServiceScrapeList & {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMServiceScrapeList"
	items: [...{
		apiVersion: "operator.victoriametrics.com/v1beta1"
		kind:       "VMServiceScrape"
	}]
}

let sharedRelabelConfigs = [{
	action: "replace"
	// user-defined cluster name, requires unique
	replacement: "emqx"
	targetLabel: "cluster"
}, {
	action: "replace"
	// fix value, don't modify
	replacement: "exporter"
	targetLabel: "from"
}, {
	action: "replace"
	// fix value, don't modify
	sourceLabels: ["pod"]
	regex:       "(.*)-.*-.*"
	replacement: "$1"
	targetLabel: "instance"
}, {
	action: "labeldrop"
	// fix value, don't modify
	regex: "pod"
}]

#VMServiceScrapeList: items: [{
	spec: {
		endpoints: [{
			port:           "http-metrics"
			relabelConfigs: sharedRelabelConfigs
		}, {
			port:           "http-metrics"
			path:           "/probe"
			relabelConfigs: sharedRelabelConfigs
		}]
		selector: matchLabels: "app.kubernetes.io/name": #Name
	}
}]
