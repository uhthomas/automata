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
	spec: {
		serviceAccountName: "prometheus"
		serviceMonitorSelector: {}
		podMonitorSelector: {}
		additionalScrapeConfigs: {
			name: "additional-scrape-configs"
			key:  "prometheus-additional.yaml"
		}
		thanos: {
			image: "quay.io/thanos/thanos:v0.18.0@sha256:b94171aed499b2f1f81b6d3d385e0eeeca885044c59cef28ce6a9a9e8a827217"
			objectStorageConfig: {
				name: "thanos"
				key:  "objstore.yaml"
			}
		}
		containers: [{
			name: "thanos-sidecar"
			envFrom: [{
				configMapRef: name: "thanos-bucket"
			}, {
				secretRef: name: "thanos-bucket"
			}]
		}]
	}
}]
