package cert_manager

import (
	victoriametricsv1beta1 "github.com/VictoriaMetrics/operator/api/victoriametrics/v1beta1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

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
		endpoints: [{port: "http-metrics"}]
		selector: matchExpressions: [{
			key:      "app.kubernetes.io/name"
			operator: metav1.#LabelSelectorOpIn
			values: [
				#Name,
				"cainjector",
				"webhook",
			]
		}]
	}
}]
