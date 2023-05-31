package grafana

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
)

#DeploymentList: appsv1.#DeploymentList & {
	apiVersion: "apps/v1"
	kind:       "DeploymentList"
	items: [...{
		apiVersion: "apps/v1"
		kind:       "Deployment"
	}]
}

#DeploymentList: items: [{
	spec: {
		replicas: 1
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				serviceAccountName:           #Name
				automountServiceAccountToken: true
				securityContext: {
					fsGroup:    472
					runAsGroup: 472
					runAsUser:  472
				}
				initContainers: [{
					name:            "init-chown-data"
					image:           "busybox:1.36.1"
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						runAsNonRoot: false
						runAsUser:    0
					}
					command: [
						"chown",
						"-R",
						"472:472",
						"/var/lib/grafana",
					]
					volumeMounts: [{
						name:      "storage"
						mountPath: "/var/lib/grafana"
					}]
				}]
				enableServiceLinks: true
				containers: [{
					name:            "grafana"
					image:           "grafana/grafana:\(#Version)"
					imagePullPolicy: v1.#PullIfNotPresent
					volumeMounts: [{
						name:      "config"
						mountPath: "/etc/grafana/grafana.ini"
						subPath:   "grafana.ini"
					}, {
						name:      "storage"
						mountPath: "/var/lib/grafana"
					}, {
						name:      "secrets-store-inline"
						readOnly:  true
						mountPath: "/mnt/secrets-store"
					}]
					ports: [{
						name:          "grafana"
						containerPort: 3000
						protocol:      "TCP"
					}, {
						name:          "gossip-tcp"
						containerPort: 9094
						protocol:      "TCP"
					}, {
						name:          "gossip-udp"
						containerPort: 9094
						protocol:      "UDP"
					}]
					env: [{
						name: "POD_IP"
						valueFrom: fieldRef: fieldPath: "status.podIP"
					}, {
						name: "GF_SECURITY_ADMIN_USER"
						valueFrom: secretKeyRef: {
							name: "grafana"
							key:  "admin-user"
						}
					}, {
						name: "GF_SECURITY_ADMIN_PASSWORD"
						valueFrom: secretKeyRef: {
							name: "grafana"
							key:  "admin-password"
						}
					}, {
						name:  "GF_PATHS_DATA"
						value: "/var/lib/grafana/"
					}, {
						name:  "GF_PATHS_LOGS"
						value: "/var/log/grafana"
					}, {
						name:  "GF_PATHS_PLUGINS"
						value: "/var/lib/grafana/plugins"
					}, {
						name:  "GF_PATHS_PROVISIONING"
						value: "/etc/grafana/provisioning"
					}]
					livenessProbe: {
						failureThreshold: 10
						httpGet: {
							path: "/api/health"
							port: 3000
						}
						initialDelaySeconds: 60
						timeoutSeconds:      30
					}
					readinessProbe: httpGet: {
						path: "/api/health"
						port: 3000
					}
				}]
				volumes: [{
					name: "config"
					configMap: name: "grafana"
				}, {
					name: "storage"
					persistentVolumeClaim: claimName: "grafana"
				}, {
					name: "secrets-store-inline"
					csi: {
						driver:   "secrets-store.csi.k8s.io"
						readOnly: true
						volumeAttributes: secretProviderClass: #Name
					}
				}]
			}
		}
	}
}]
