package zigbee2mqtt

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
				volumes: [{
					name: "config"
					configMap: name: #Name
				}]
				initContainers: [{
					name:  "copy-config"
					image: "alpine:3.17.2@sha256:e2e16842c9b54d985bf1ef9242a313f36b856181f188de21313820e177002501"
					command: ["cp"]
					args: ["/etc/zigbee2mqtt/configuration.yaml", "/app/data/configuration.yaml"]
					resources: limits: {
						(v1.#ResourceCPU):    "50m"
						(v1.#ResourceMemory): "8Mi"
					}
					volumeMounts: [{
						name:      "config"
						mountPath: "/etc/zigbee2mqtt/configuration.yaml"
						subPath:   "configuration.yaml"
					}, {
						name:      "data"
						mountPath: "/app/data"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				containers: [{
					name:  #Name
					image: "koenkk/zigbee2mqtt:\(#Version)"
					ports: [{
						name:          "http"
						containerPort: 8080
					}]
					env: [{
						name: "ZIGBEE2MQTT_CONFIG_MQTT_PASSWORD"
						valueFrom: secretKeyRef: {
							name: #Name
							key:  "mqtt-password"
						}
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "500m"
						(v1.#ResourceMemory): "128Mi"
					}
					volumeMounts: [{
						name:      "data"
						mountPath: "/app/data"
					}]

					let probe = {
						httpGet: {
							path: "/"
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
				resources: requests: (v1.#ResourceStorage): "32Mi"
			}
		}]
		serviceName: #Name
	}
}]
