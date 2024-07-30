package web

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

#StatefulSetList: items: [{
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				containers: [{
					name:  "web"
					image: "ghcr.io/analogj/scrutiny:v\(#Version)-web"
					ports: [{
						name:          "http"
						containerPort: 8080
					}]
					env: [{
						name:  "SCRUTINY_WEB_INFLUXDB_HOST"
						value: "scrutiny-influxdb"
					}, {
						name: "SCRUTINY_WEB_INFLUXDB_TOKEN"
						valueFrom: secretKeyRef: {
							name: #Name
							key:  "token"
						}
					}, {
						name: "GOMAXPROCS"
						valueFrom: resourceFieldRef: {
							containerName: "web"
							resource:      "limits.cpu"
						}
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "100m"
						(v1.#ResourceMemory): "32Mi"
					}
					volumeMounts: [{
						name:      "data"
						mountPath: "/opt/scrutiny/config"
					}]

					let probe = {
						httpGet: {
							path: "/health"
							port: "http"
						}
					}

					livenessProbe:  probe
					readinessProbe: probe

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
				resources: requests: (v1.#ResourceStorage): "256Mi"
			}
		}]
		serviceName: #Name
	}
}]
