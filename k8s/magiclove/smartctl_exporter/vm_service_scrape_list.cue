package smartctl_exporter

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
			port:          "http-metrics"
			interval:      "60s"
			scrapeTimeout: "30s"
		}]
		selector: matchLabels: "app.kubernetes.io/name": #Name
	}
}]
