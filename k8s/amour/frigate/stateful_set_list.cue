package frigate

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
				containers: [{
					name:  #Name
					image: "ghcr.io/blakeblackshear/frigate:\(#Version)-tensorrt"
					ports: [{
						name:          "http"
						containerPort: 5000
					}, {
						name:          "rtmp"
						containerPort: 1935
					}, {
						name:          "rtsp"
						containerPort: 8554
					}]
					env: [{
						name:  "PUID"
						value: "1000"
					}, {
						name:  "PGID"
						value: "3000"
					}, {
						name:  "NVIDIA_DRIVER_CAPABILITIES"
						value: "all"
					}, {
						name:  "NVIDIA_VISIBLE_DEVICES"
						value: "all"
					}, {
						name: "FRIGATE_MQTT_PASSWORD"
						valueFrom: secretKeyRef: {
							name: #Name
							key:  "mqtt-password"
						}
					}, {
						name: "FRIGATE_DOORBELL_SECRET"
						valueFrom: secretKeyRef: {
							name: #Name
							key:  "doorbell-secret"
						}
					}, {
						name: "FRIGATE_WJBC516A003968_PASSWORD"
						valueFrom: secretKeyRef: {
							name: #Name
							key:  "wjbc516a003968-password"
						}
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "2"
						(v1.#ResourceMemory): "2Gi"
						"nvidia.com/gpu":     "1"
					}
					volumeMounts: [{
						name:      "config"
						mountPath: "/config/config.yaml"
						subPath:   "config.yaml"
					}, {
						name:      "config-dir"
						mountPath: "/config"
					}, {
						name:      "media"
						mountPath: "/media"
					}]

					let probe = v1.#Probe & {
						httpGet: {
							path: "/health"
							port: "http"
						}
					}

					livenessProbe:  probe
					readinessProbe: probe

					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						// capabilities: drop: ["ALL"]
						// readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				// The s6 overlay requires root... It may be
				// better to build our own image instead.
				//
				// https://github.com/linuxserver/docker-radarr/issues/203
				securityContext: {
					runAsUser:           0
					runAsGroup:          0
					runAsNonRoot:        false
					fsGroup:             2000
					fsGroupChangePolicy: v1.#FSGroupChangeOnRootMismatch
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
		volumeClaimTemplates: [{
			metadata: name: "config-dir"
			spec: {
				accessModes: [v1.#ReadWriteOnce]
				storageClassName: "rook-ceph-nvme"
				resources: requests: (v1.#ResourceStorage): "1Gi"
			}
		}, {
			metadata: name: "media"
			spec: {
				accessModes: [v1.#ReadWriteOnce]
				storageClassName: "rook-ceph-nvme"
				resources: requests: (v1.#ResourceStorage): "1Ti"
			}
		}]
		serviceName: #Name
	}
}]
