package volsync_system

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
	spec: {
		endpoints: [{
			port:   "https"
			scheme: "https"
			tlsConfig: insecureSkipVerify: true
		}]
		selector: matchLabels: "app.kubernetes.io/name": #Name
	}
}]
