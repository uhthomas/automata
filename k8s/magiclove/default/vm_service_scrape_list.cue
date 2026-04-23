package default

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
	metadata: name: "kube-api-server"
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
