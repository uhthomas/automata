package default

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
	name: "kube-apiserver"
	spec: {
		jobLabel: "component"
		endpoints: [{
			port:   "https"
			scheme: "https"
			tlsConfig: {
				caFile:     "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
				serverName: "kubernetes"
			}
			bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
		}]
		selector: matchLabels: {
			component: "apiserver"
			provider:  "kubernetes"
		}
	}
}]
