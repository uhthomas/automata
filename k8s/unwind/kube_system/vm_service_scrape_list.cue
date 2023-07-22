package kube_system

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
	metadata: name: "coredns"
	spec: {
		endpoints: [{
			port:            "metrics"
			bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
		}]
		selector: matchLabels: "kubernetes.io/name": "CoreDNS"
	}
}, {
	metadata: name: "kube-controller-manager"
	spec: {
		jobLabel: "app.kubernetes.io/name"
		endpoints: [{
			port:   "metrics"
			scheme: "https"
			tlsConfig: {
				caFile:     "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
				serverName: "kubernetes"
			}
			bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
		}]
		selector: matchLabels: "app.kubernetes.io/name": metadata.name
	}
}, {
	metadata: name: "kube-scheduler"
	spec: {
		jobLabel: "app.kubernetes.io/name"
		endpoints: [{
			port:   "metrics"
			scheme: "https"
			tlsConfig: caFile: "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
			bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
		}]
		selector: matchLabels: "app.kubernetes.io/name": metadata.name
	}
}]
