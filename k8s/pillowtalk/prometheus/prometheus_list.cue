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
		serviceMonitorNamespaceSelector: {}
		podMonitorSelector: {}
		podMonitorNamespaceSelector: {}
		additionalScrapeConfigs: {
			name: "additional-scrape-configs"
			key:  "prometheus-additional.yaml"
		}
		replicaExternalLabelName: "replica"
		externalLabels: cluster: "pillowtalk"
		thanos: {
			image:                   "quay.io/thanos/thanos:v0.21.0@sha256:04908034d76eaf5bb90f916ade8995a5c74413c86e3c01ef141c10110830654c"
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
		storage: volumeClaimTemplate: spec: {
			accessModes: [v1.#ReadWriteOnce]
			storageClassName: "rook-ceph-replica-retain-block"
			resources: requests: storage: "10Gi"
		}
	}
}]
