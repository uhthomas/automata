package influxdb

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
					name: "tmp"
					emptyDir: {}
				}]
				containers: [{
					name:  "influxdb"
					image: "influxdb:\(#Version)-alpine"
					ports: [{
						name:          "http"
						containerPort: 8086
					}]
					env: [{
						name:  "DOCKER_INFLUXDB_INIT_MODE"
						value: "setup"
					}, {
						name: "DOCKER_INFLUXDB_INIT_USERNAME"
						valueFrom: secretKeyRef: {
							name: #Name
							key:  "username"
						}
					}, {
						name: "DOCKER_INFLUXDB_INIT_PASSWORD"
						valueFrom: secretKeyRef: {
							name: #Name
							key:  "password"
						}
					}, {
						name:  "DOCKER_INFLUXDB_INIT_ORG"
						value: "scrutiny"
					}, {
						name:  "DOCKER_INFLUXDB_INIT_BUCKET"
						value: "default"
					}, {
						name:  "DOCKER_INFLUXDB_INIT_RETENTION"
						value: "0s"
					}, {
						name: "DOCKER_INFLUXDB_INIT_ADMIN_TOKEN"
						valueFrom: secretKeyRef: {
							name: #Name
							key:  "token"
						}
					}, {
						name:  "INFLUXD_BOLT_PATH"
						value: "/var/lib/influxdb2/influxd.bolt"
					}, {
						name:  "INFLUXD_ENGINE_PATH"
						value: "/var/lib/influxdb2"
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "500m"
						(v1.#ResourceMemory): "256Mi"
					}
					volumeMounts: [{
						name:      "tmp"
						mountPath: "/tmp"
					}, {
						name:      "data"
						mountPath: "/var/lib/influxdb2"
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
