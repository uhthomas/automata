package node_problem_detector

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
		jobLabel: "component"
		endpoints: [{
			port: "exporter"
			path: "/metrics"
		}]
		selector: matchLabels: "app.kubernetes.io/name": #Name
	}
}]
