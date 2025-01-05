package cilium

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
	metadata: name: "cilium-operator"
	spec: {
		podMetricsEndpoints: [{port: "prometheus"}]
		selector: matchLabels: "app.kubernetes.io/name": "cilium-operator"
	}
}]
