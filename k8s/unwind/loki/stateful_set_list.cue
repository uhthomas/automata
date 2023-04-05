package loki

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
	metadata: {
		name: "loki-read"
		labels: {
			"app.kubernetes.io/part-of":   "memberlist"
			"app.kubernetes.io/instance":  "loki"
			"app.kubernetes.io/component": "read"
		}
	}
	spec: {
		replicas:            3
		podManagementPolicy: "Parallel"
		updateStrategy: rollingUpdate: partition: 0
		serviceName:          "loki-read-headless"
		revisionHistoryLimit: 10

		persistentVolumeClaimRetentionPolicy: {
			whenDeleted: "Delete"
			whenScaled:  "Delete"
		}
		selector: matchLabels: {
			"app.kubernetes.io/name":      "loki"
			"app.kubernetes.io/instance":  "loki"
			"app.kubernetes.io/component": "read"
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/part-of":   "memberlist"
				"app.kubernetes.io/name":      "loki"
				"app.kubernetes.io/instance":  "loki"
				"app.kubernetes.io/component": "read"
			}
			spec: {
				serviceAccountName:           "loki"
				automountServiceAccountToken: true
				enableServiceLinks:           true

				securityContext: {
					fsGroup:      10001
					runAsGroup:   10001
					runAsNonRoot: true
					runAsUser:    10001
				}
				terminationGracePeriodSeconds: 30
				containers: [{
					name:            "loki"
					image:           "docker.io/grafana/loki:2.7.3"
					imagePullPolicy: "IfNotPresent"
					args: [
						"-config.expand-env=true",
						"-config.file=/etc/loki/config/config.yaml",
						"-target=read",
					]
					ports: [{
						name:          "http-metrics"
						containerPort: 3100
					}, {
						name:          "grpc"
						containerPort: 9095
					}, {
						name:          "http-memberlist"
						containerPort: 7946
					}]
					envFrom: [{
						configMapRef: name: "\(#Name)-bucket"
					}, {
						secretRef: name: "\(#Name)-bucket"
					}]
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
					}
					readinessProbe: {
						httpGet: {
							path: "/ready"
							port: "http-metrics"
						}
						initialDelaySeconds: 30
						timeoutSeconds:      1
					}
					volumeMounts: [{
						name:      "config"
						mountPath: "/etc/loki/config"
					}, {
						name:      "runtime-config"
						mountPath: "/etc/loki/runtime-config"
					}, {
						name:      "tmp"
						mountPath: "/tmp"
					}, {
						name:      "data"
						mountPath: "/var/loki"
					}]
					resources: {}
				}]

				affinity: podAntiAffinity: requiredDuringSchedulingIgnoredDuringExecution: [{
					labelSelector: matchLabels: {
						"app.kubernetes.io/name":      "loki"
						"app.kubernetes.io/instance":  "loki"
						"app.kubernetes.io/component": "read"
					}
					topologyKey: v1.#LabelHostname
				}]

				volumes: [{
					name: "tmp"
					emptyDir: {}
				}, {
					name: "config"
					configMap: name: "loki"
				}, {
					name: "runtime-config"
					configMap: name: "loki-runtime"
				}]
			}
		}
		volumeClaimTemplates: [{
			metadata: name: "data"
			spec: {
				accessModes: [v1.#ReadWriteOnce]
				resources: requests: storage: "10Gi"
			}
		}]
	}
}, {
	metadata: {
		name: "loki-write"
		labels: {
			"app.kubernetes.io/component": "write"
			"app.kubernetes.io/part-of":   "memberlist"
		}
	}
	spec: {
		replicas: 3

		podManagementPolicy: appsv1.#ParallelPodManagement
		updateStrategy: rollingUpdate: partition: 0
		serviceName:          "loki-write-headless"
		revisionHistoryLimit: 10
		selector: matchLabels: {
			"app.kubernetes.io/name":      "loki"
			"app.kubernetes.io/instance":  "loki"
			"app.kubernetes.io/component": "write"
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      "loki"
				"app.kubernetes.io/instance":  "loki"
				"app.kubernetes.io/component": "write"
				"app.kubernetes.io/part-of":   "memberlist"
			}
			spec: {
				serviceAccountName:           "loki"
				automountServiceAccountToken: true
				enableServiceLinks:           true

				securityContext: {
					fsGroup:      10001
					runAsGroup:   10001
					runAsNonRoot: true
					runAsUser:    10001
				}
				terminationGracePeriodSeconds: 300
				containers: [{
					name:            "loki"
					image:           "docker.io/grafana/loki:2.7.3"
					imagePullPolicy: "IfNotPresent"
					args: [
						"-config.expand-env=true",
						"-config.file=/etc/loki/config/config.yaml",
						"-target=write",
					]
					ports: [{
						name:          "http-metrics"
						containerPort: 3100
					}, {
						name:          "grpc"
						containerPort: 9095
					}, {
						name:          "http-memberlist"
						containerPort: 7946
					}]
					envFrom: [{
						configMapRef: name: "\(#Name)-bucket"
					}, {
						secretRef: name: "\(#Name)-bucket"
					}]
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
					}
					readinessProbe: {
						httpGet: {
							path: "/ready"
							port: "http-metrics"
						}
						initialDelaySeconds: 30
						timeoutSeconds:      1
					}
					volumeMounts: [{
						name:      "config"
						mountPath: "/etc/loki/config"
					}, {
						name:      "runtime-config"
						mountPath: "/etc/loki/runtime-config"
					}, {
						name:      "data"
						mountPath: "/var/loki"
					}]
					resources: {}
				}]

				affinity: podAntiAffinity: requiredDuringSchedulingIgnoredDuringExecution: [{
					labelSelector: matchLabels: {
						"app.kubernetes.io/name":      "loki"
						"app.kubernetes.io/instance":  "loki"
						"app.kubernetes.io/component": "write"
					}
					topologyKey: v1.#LabelHostname
				}]

				volumes: [{
					name: "config"
					configMap: name: "loki"
				}, {
					name: "runtime-config"
					configMap: name: "loki-runtime"
				}]
			}
		}
		volumeClaimTemplates: [{
			metadata: name: "data"
			spec: {
				accessModes: [v1.#ReadWriteOnce]
				resources: requests: storage: "10Gi"
			}
		}]
	}
}]
