package envoy

import "k8s.io/api/core/v1"

// TODO: Use generated types.
//
// https://github.com/cue-lang/cue/issues/2466
#VMPodScrapeList: v1.#List & {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMPodScrapeList"
	items: [...{
		apiVersion: "operator.victoriametrics.com/v1beta1"
		kind:       "VMPodScrape"
	}]
}

#VMPodScrapeList: items: [{
	metadata: name: #Name
	spec: {
		podMetricsEndpoints: [{port: "envoy-metrics"}]
		selector: matchLabels: "app.kubernetes.io/name": #Name
	}
}]
