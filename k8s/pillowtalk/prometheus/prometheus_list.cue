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
		replicaExternalLabelName: "replica"
		externalLabels: cluster: "pillowtalk"
		thanos: image: "quay.io/thanos/thanos:v0.18.0@sha256:b94171aed499b2f1f81b6d3d385e0eeeca885044c59cef28ce6a9a9e8a827217"
		containers: [{
			name: "thanos-sidecar"
			envFrom: [{
				configMapRef: name: "thanos-bucket"
			}, {
				secretRef: name: "thanos-bucket"
			}]
			args: [
				"""
					--objstore.config=type: S3
					config:
						bucket: $(BUCKET_NAME)
						endpoint: $(BUCKET_HOST):$(BUCKET_PORT)
						region: $(BUCKET_REGION)
						access_key: $(AWS_ACCESS_KEY_ID)
						secret_key: $(AWS_SECRET_ACCESS_KEY)
						insecure: true
					""",
			]
		}]
	}
}]
