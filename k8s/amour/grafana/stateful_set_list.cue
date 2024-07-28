package grafana

import (
	"strings"

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

let plugins = [{
	name:   "victoriametrics-datasource"
	source: "https://github.com/VictoriaMetrics/victoriametrics-datasource/releases/download/v0.8.2/victoriametrics-datasource-v0.8.2.zip"
	signed: false
}, {
	name:   "victorialogs-datasource"
	source: "https://github.com/VictoriaMetrics/victorialogs-datasource/releases/download/v0.2.1/victorialogs-datasource-v0.2.1.zip;victorialogs-datasource"
	signed: false
}]

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
					}, {
						name: "GF_INSTALL_PLUGINS"
						value: strings.Join([for plugin in plugins {
							strings.Join([
								if plugin.source != _|_ {plugin.source},
								plugin.name,
							], ";")
						}], ",")
					}, {
						name: "GF_PLUGINS_ALLOW_LOADING_UNSIGNED_PLUGINS"
						value: strings.Join([for plugin in plugins if !plugin.signed != _|_ {plugin.name}], ",")
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

					let probe = v1.#Probe & {
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
