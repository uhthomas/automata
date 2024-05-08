package grafana

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
)

#StatefulSetList: appsv1.#StatefulSetList & {
	apiVersion: "apps/v1"
	kind:       "StatefulSetList"
	items: [...{
		apiVersion: "apps/v1"
		kind:       "StatefulSet"
	}]
}

let downloadVictoriaLogsPluginScript = """
	set -ex
	mkdir -p /var/lib/grafana/plugins/
	ver=$(curl -s https://api.github.com/repos/VictoriaMetrics/victorialogs-datasource/releases/latest | grep -oE 'v[0-9]+\\.[0-9]+\\.[0-9]+' | head -1)
	curl -L https://github.com/VictoriaMetrics/victorialogs-datasource/releases/download/$ver/victorialogs-datasource-$ver.tar.gz -o /var/lib/grafana/plugins/plugin.tar.gz
	tar -xf /var/lib/grafana/plugins/plugin.tar.gz -C /var/lib/grafana/plugins/
	rm /var/lib/grafana/plugins/plugin.tar.gz
	"""

let downloadVictoriaMetricsPluginScript = """
	set -ex
	mkdir -p /var/lib/grafana/plugins/
	ver=$(curl -s https://api.github.com/repos/VictoriaMetrics/grafana-datasource/releases/latest | grep -oE 'v[0-9]+\\.[0-9]+\\.[0-9]+' | head -1)
	curl -L https://github.com/VictoriaMetrics/grafana-datasource/releases/download/$ver/victoriametrics-datasource-$ver.tar.gz -o /var/lib/grafana/plugins/plugin.tar.gz
	tar -xf /var/lib/grafana/plugins/plugin.tar.gz -C /var/lib/grafana/plugins/
	rm /var/lib/grafana/plugins/plugin.tar.gz
	"""

#StatefulSetList: items: [{
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				volumes: [{
					name: "config"
					configMap: name: "grafana"
				}, {
					name: "tmp"
					emptyDir: {}
				}]
				initContainers: [{
					// https://github.com/VictoriaMetrics/victorialogs-datasource/blob/058bd8d81a8119511abdc35398459a1094381b5c/README.md
					name:  "download-victoria-logs-plugin"
					image: "curlimages/curl:8.7.1"
					command: ["/bin/sh"]
					args: ["-c", downloadVictoriaLogsPluginScript]
					workingDir: "/var/lib/grafana"
					resources: limits: {
						(v1.#ResourceCPU):    "1"
						(v1.#ResourceMemory): "1Gi"
					}
					volumeMounts: [{
						name:      "data"
						mountPath: "/var/lib/grafana"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}, {
					// https://github.com/VictoriaMetrics/grafana-datasource/blob/5b8a0ba190e116bdebfdb51d11b4e0d03d86d766/README.md
					name:  "download-victoria-metrics-plugin"
					image: "curlimages/curl:8.7.1"
					command: ["/bin/sh"]
					args: ["-c", downloadVictoriaMetricsPluginScript]
					workingDir: "/var/lib/grafana"
					resources: limits: {
						(v1.#ResourceCPU):    "1"
						(v1.#ResourceMemory): "1Gi"
					}
					volumeMounts: [{
						name:      "data"
						mountPath: "/var/lib/grafana"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				containers: [{
					name:  "grafana"
					image: "grafana/grafana:\(#Version)"
					ports: [{
						name:          "http"
						containerPort: 3000
					}]
					env: [{
						name: "GF_SECURITY_ADMIN_USER"
						valueFrom: secretKeyRef: {
							name: "grafana"
							key:  "username"
						}
					}, {
						name: "GF_SECURITY_ADMIN_PASSWORD"
						valueFrom: secretKeyRef: {
							name: "grafana"
							key:  "password"
						}
					}]
					volumeMounts: [{
						name:      "config"
						mountPath: "/etc/grafana/grafana.ini"
						subPath:   "grafana.ini"
					}, {
						name:      "config"
						mountPath: "/etc/grafana/provisioning/datasources/datasources.yaml"
						subPath:   "datasources.yaml"
					}, {
						name:      "data"
						mountPath: "/var/lib/grafana"
					}, {
						name:      "tmp"
						mountPath: "/tmp"
					}]

					let probe = {
						httpGet: {
							path: "/api/health"
							port: "http"
						}
					}

					livenessProbe: probe
					readinessProbe: probe & {
						initialDelaySeconds: 30
						failureThreshold:    5
					}

					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				securityContext: {
					runAsUser:           1000
					runAsGroup:          3000
					runAsNonRoot:        true
					fsGroup:             2000
					fsGroupChangePolicy: v1.#FSGroupChangeOnRootMismatch
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
		volumeClaimTemplates: [{
			metadata: name: "data"
			spec: {
				accessModes: [v1.#ReadWriteOnce]
				storageClassName: "rook-ceph-nvme"
				resources: requests: (v1.#ResourceStorage): "1Gi"
			}
		}]
		serviceName: #Name
	}
}]
