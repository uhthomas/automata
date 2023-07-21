package vm

import "k8s.io/api/core/v1"

// TODO: Use generated types.
//
// https://github.com/cue-lang/cue/issues/2466
#VMNodeScrapeList: v1.#List & {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMNodeScrapeList"
	items: [...{
		apiVersion: "operator.victoriametrics.com/v1beta1"
		kind:       "VMNodeScrape"
	}]
}

#VMNodeScrapeList: items: [{
	metadata: name: "cadvisor-metrics"
	spec: {
		scheme: "https"
		tlsConfig: {
			insecureSkipVerify: true
			caFile:             "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
		}
		bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
		relabelConfigs: [{
			action: "labelmap"
			regex:  "__meta_kubernetes_node_label_(.+)"
		}, {
			targetLabel: "__address__"
			replacement: "kubernetes.default.svc:443"
		}, {
			sourceLabels: ["__meta_kubernetes_node_name"]
			regex:       "(.+)"
			targetLabel: "__metrics_path__"
			replacement: "/api/v1/nodes/$1/proxy/metrics/cadvisor"
		}]
	}
}]
