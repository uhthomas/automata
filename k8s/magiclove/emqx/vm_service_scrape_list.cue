package emqx

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
	replacement: "emqx"
	targetLabel: "from"
}, {
	action: "replace"
	// fix value, don't modify
	sourceLabels: ["pod"]
	targetLabel: "instance"
}]

#VMServiceScrapeList: items: [{
	spec: {
		endpoints: [{
			port:           "http"
			path:           "/api/v5/prometheus/stats"
			relabelConfigs: sharedRelabelConfigs
		}, {
			port:           "http"
			path:           "/api/v5/prometheus/auth"
			relabelConfigs: sharedRelabelConfigs
		}, {
			port:           "http"
			path:           "/api/v5/prometheus/data_integration"
			relabelConfigs: sharedRelabelConfigs
		}]
		selector: matchLabels: "app.kubernetes.io/name": #Name
	}
}]
