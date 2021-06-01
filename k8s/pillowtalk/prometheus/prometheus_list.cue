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
		thanos: {
			image:                   "quay.io/thanos/thanos:v0.18.0@sha256:b94171aed499b2f1f81b6d3d385e0eeeca885044c59cef28ce6a9a9e8a827217"
			objectStorageConfigFile: "/etc/thanos/config/objstore.yaml"
		}
		containers: [{
			name: "thanos-sidecar"
			envFrom: [{
				secretRef: name: "thanos-bucket"
			}]
			volumeMounts: [{
				name:      "thanos-config"
				mountPath: "/etc/thanos/config"
				readOnly:  true
			}]
		}]
		initContainers: [{
			name:  "thanos-config"
			image: "alpine:3.13.5@sha256:69e70a79f2d41ab5d637de98c1e0b055206ba40a8145e7bddb55ccc04e13cf8f"
			args: [
				"sh",
				"-c",
				"""
					cat <<EOF > /etc/thanos/config/objstore.yaml
					type: S3
					config:
					 bucket: $(BUCKET_NAME)
					 endpoint: $(BUCKET_HOST):$(BUCKET_PORT)
					 region: $(BUCKET_REGION)
					 insecure: true
					EOF
					""",
			]
			envFrom: [{configMapRef: name: "thanos-bucket"}]
			volumeMounts: [{
				name:      "thanos-config"
				mountPath: "/etc/thanos/config"
			}]
		}]
		volumes: [{
			name: "thanos-config"
			emptyDir: {}
		}]
	}
}]
