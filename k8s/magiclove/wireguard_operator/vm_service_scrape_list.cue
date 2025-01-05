package wireguard_operator

import victoriametricsv1beta1 "github.com/VictoriaMetrics/operator/api/victoriametrics/v1beta1"

#VMServiceScrapeList: victoriametricsv1beta1.#VMServiceScrapeList & {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMServiceScrapeList"
	items: [...{
		apiVersion: "operator.victoriametrics.com/v1beta1"
		kind:       "VMServiceScrape"
	}]
}

#VMServiceScrapeList: items: [{
	spec: {
		endpoints: [{
			port:   "https-metrics"
			scheme: "https"
			tlsConfig: insecureSkipVerify: true
			bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
		}]
		selector: matchLabels: "app.kubernetes.io/name": #Name
	}
}]
