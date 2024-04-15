daemonset: [{
	// Source: fluent-bit/templates/daemonset.yaml
	apiVersion: "apps/v1"
	kind:       "DaemonSet"
	metadata: {
		name:      "fluent-bit"
		namespace: "victoria-logs"
		labels: {
			"helm.sh/chart":                "fluent-bit-0.46.1"
			"app.kubernetes.io/name":       "fluent-bit"
			"app.kubernetes.io/instance":   "fluent-bit"
			"app.kubernetes.io/version":    "3.0.1"
			"app.kubernetes.io/managed-by": "Helm"
		}
	}
	spec: {
		selector: matchLabels: {
			"app.kubernetes.io/name":     "fluent-bit"
			"app.kubernetes.io/instance": "fluent-bit"
		}
		template: {
			metadata: {
				labels: {
					"app.kubernetes.io/name":     "fluent-bit"
					"app.kubernetes.io/instance": "fluent-bit"
				}
				annotations: "checksum/config": "7e47a879b1817d44823af9c9e4da3c3f0bc5cab4a97ecef7379f802fb0e997a0"
			}
			spec: {
				serviceAccountName: "fluent-bit"
				hostNetwork:        false
				dnsPolicy:          "ClusterFirst"
				containers: [{
					name:            "fluent-bit"
					image:           "cr.fluentbit.io/fluent/fluent-bit:3.0.1"
					imagePullPolicy: "IfNotPresent"
					command: ["/fluent-bit/bin/fluent-bit"]
					args: [
						"--workdir=/fluent-bit/etc",
						"--config=/fluent-bit/etc/conf/fluent-bit.conf",
					]
					ports: [{
						name:          "http"
						containerPort: 2020
						protocol:      "TCP"
					}]
					livenessProbe: httpGet: {
						path: "/"
						port: "http"
					}
					readinessProbe: httpGet: {
						path: "/api/v1/health"
						port: "http"
					}
					volumeMounts: [{
						name:      "config"
						mountPath: "/fluent-bit/etc/conf"
					}, {
						mountPath: "/var/log"
						name:      "varlog"
					}, {
						mountPath: "/var/lib/docker/containers"
						name:      "varlibdockercontainers"
						readOnly:  true
					}, {
						mountPath: "/etc/machine-id"
						name:      "etcmachineid"
						readOnly:  true
					}]
				}]
				volumes: [{
					name: "config"
					configMap: name: "fluent-bit"
				}, {
					hostPath: path: "/var/log"
					name: "varlog"
				}, {
					hostPath: path: "/var/lib/docker/containers"
					name: "varlibdockercontainers"
				}, {
					hostPath: {
						path: "/etc/machine-id"
						type: "File"
					}
					name: "etcmachineid"
				}]
			}
		}
	}
}]
