package emqx

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
					name:  #Name
					image: "emqx/emqx:\(#Version)"
					ports: [{
						name:          "mqtt"
						containerPort: 1883
					}, {
						name:          "mqtt-ws"
						containerPort: 8083
					}, {
						name:          "mqtt-wss"
						containerPort: 8084
					}, {
						name:          "mqtt-tls"
						containerPort: 8883
					}, {
						name:          "http"
						containerPort: 18083
					}]
					env: [{
						name: "POD_NAME"
						valueFrom: fieldRef: fieldPath: "metadata.name"
					}, {
						name:  "EMQX_NODE__NAME"
						value: "emqx@$(POD_NAME).\(#Name)"
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "500m"
						(v1.#ResourceMemory): "512Mi"
					}
					volumeMounts: [{
						name:      "data"
						mountPath: "/opt/emqx/data"
					}]

					let probe = v1.#Probe & {
						httpGet: {
							path: "/status"
							port: "http"
						}
					}

					livenessProbe: probe & {
						initialDelaySeconds: 60
						periodSeconds:       30
					}
					readinessProbe: probe & {
						initialDelaySeconds: 10
						periodSeconds:       5
						failureThreshold:    12
					}

					lifecycle: preStop: exec: command: ["emqx", "ctl", "cluster", "leave"]
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
					runAsNonRoot:        false
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
				resources: requests: (v1.#ResourceStorage): "64Mi"
			}
		}]
		serviceName: #Name
	}
}]
