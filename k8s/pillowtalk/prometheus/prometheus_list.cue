package prometheus

import "k8s.io/api/core/v1"

prometheusList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "monitoring.coreos.com/v1"
		kind:       "Prometheus"
	}]
}

prometheusList: items: [{
	spec: additionalScrapeConfigs: {
		name: "prometheus"
		key:  "prometheus-additional.yaml"
	}
}]
