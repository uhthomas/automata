package mimir

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
		name: "mimir-compactor"
		labels: {
			"app.kubernetes.io/component": "compactor"
			"app.kubernetes.io/part-of":   "memberlist"
		}
	}
	spec: {
		replicas: 1
		selector: matchLabels: {
			"app.kubernetes.io/name":      #Name
			"app.kubernetes.io/instance":  #Name
			"app.kubernetes.io/component": "compactor"
		}
		updateStrategy: type: "RollingUpdate"
		serviceName: "mimir-compactor"
		volumeClaimTemplates: [{
			metadata: name: "storage"
			spec: {
				accessModes: ["ReadWriteOnce"]
				resources: requests: storage: "2Gi"
			}
		}]
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      #Name
				"app.kubernetes.io/instance":  #Name
				"app.kubernetes.io/version":   #Version
				"app.kubernetes.io/component": "compactor"
				"app.kubernetes.io/part-of":   "memberlist"
			}
			spec: {
				serviceAccountName: #Name
				securityContext: {
					fsGroup:      10001
					runAsGroup:   10001
					runAsNonRoot: true
					runAsUser:    10001
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
				topologySpreadConstraints: [{
					maxSkew:           1
					topologyKey:       "kubernetes.io/hostname"
					whenUnsatisfiable: "ScheduleAnyway"
					labelSelector: matchLabels: {
						"app.kubernetes.io/name":      #Name
						"app.kubernetes.io/instance":  #Name
						"app.kubernetes.io/component": "compactor"
					}
				}]
				terminationGracePeriodSeconds: 240
				volumes: [{
					name: "config"
					configMap: {
						name: "mimir-config"
						items: [{
							key:  "mimir.yaml"
							path: "mimir.yaml"
						}]
					}
				}, {
					name: "runtime-config"
					configMap: name: "mimir-runtime"
				}, {
					name: "active-queries"
					emptyDir: {}
				}]
				containers: [{
					name:            "compactor"
					image:           "grafana/mimir:2.7.1"
					imagePullPolicy: "IfNotPresent"
					args: [
						"-target=compactor",
						"-config.expand-env=true",
						"-config.file=/etc/mimir/mimir.yaml",
					]
					volumeMounts: [{
						name:      "config"
						mountPath: "/etc/mimir"
					}, {
						name:      "runtime-config"
						mountPath: "/var/mimir"
					}, {
						name:      "storage"
						mountPath: "/data"
					}, {
						name:      "active-queries"
						mountPath: "/active-query-tracker"
					}]
					ports: [{
						name:          "http-metrics"
						containerPort: 8080
					}, {
						name:          "grpc"
						containerPort: 9095
					}, {
						name:          "memberlist"
						containerPort: 7946
					}]
					env: _#BucketEnvironmentVariables
					readinessProbe: {
						httpGet: {
							path: "/ready"
							port: "http-metrics"
						}
						initialDelaySeconds: 60
					}
					resources: requests: {
						cpu:    "100m"
						memory: "512Mi"
					}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
					}
				}]
			}
		}
	}
}, {
	metadata: {
		name: "mimir-ingester-zone-a"
		labels: {
			"app.kubernetes.io/component": "ingester"
			"app.kubernetes.io/part-of":   "memberlist"
			name:                          "ingester-zone-a"
			"rollout-group":               "ingester"
			zone:                          "zone-a"
		}
		annotations: "rollout-max-unavailable": "25"
	}
	spec: {
		podManagementPolicy: "Parallel"
		replicas:            1
		selector: matchLabels: {
			"app.kubernetes.io/name":      #Name
			"app.kubernetes.io/instance":  #Name
			"app.kubernetes.io/component": "ingester"
			"rollout-group":               "ingester"
			zone:                          "zone-a"
		}
		updateStrategy: type: "OnDelete"
		serviceName: "mimir-ingester-headless"
		volumeClaimTemplates: [{
			metadata: name: "storage"
			spec: {
				accessModes: ["ReadWriteOnce"]
				resources: requests: storage: "2Gi"
			}
		}]
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      #Name
				"app.kubernetes.io/instance":  #Name
				"app.kubernetes.io/version":   #Version
				"app.kubernetes.io/component": "ingester"
				"app.kubernetes.io/part-of":   "memberlist"
				name:                          "ingester-zone-a"
				"rollout-group":               "ingester"
				zone:                          "zone-a"
			}
			spec: {
				serviceAccountName: #Name
				securityContext: {
					fsGroup:      10001
					runAsGroup:   10001
					runAsNonRoot: true
					runAsUser:    10001
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
				topologySpreadConstraints: [{
					maxSkew:           1
					topologyKey:       "kubernetes.io/hostname"
					whenUnsatisfiable: "ScheduleAnyway"
					labelSelector: matchLabels: {
						"app.kubernetes.io/name":      #Name
						"app.kubernetes.io/instance":  #Name
						"app.kubernetes.io/component": "ingester"
					}
				}]
				terminationGracePeriodSeconds: 240
				volumes: [{
					name: "config"
					configMap: {
						name: "mimir-config"
						items: [{
							key:  "mimir.yaml"
							path: "mimir.yaml"
						}]
					}
				}, {
					name: "runtime-config"
					configMap: name: "mimir-runtime"
				}, {
					name: "active-queries"
					emptyDir: {}
				}]
				containers: [{
					name:            "ingester"
					image:           "grafana/mimir:2.7.1"
					imagePullPolicy: "IfNotPresent"
					args: [
						"-target=ingester",
						"-config.expand-env=true",
						"-config.file=/etc/mimir/mimir.yaml",
						"-ingester.ring.instance-availability-zone=zone-a",
					]
					volumeMounts: [{
						name:      "config"
						mountPath: "/etc/mimir"
					}, {
						name:      "runtime-config"
						mountPath: "/var/mimir"
					}, {
						name:      "storage"
						mountPath: "/data"
					}, {
						name:      "active-queries"
						mountPath: "/active-query-tracker"
					}]
					ports: [{
						name:          "http-metrics"
						containerPort: 8080
					}, {
						name:          "grpc"
						containerPort: 9095
					}, {
						name:          "memberlist"
						containerPort: 7946
					}]
					env: _#BucketEnvironmentVariables
					readinessProbe: {
						httpGet: {
							path: "/ready"
							port: "http-metrics"
						}
						initialDelaySeconds: 60
					}
					resources: requests: {
						cpu:    "100m"
						memory: "512Mi"
					}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: [
							"ALL",
						]
						readOnlyRootFilesystem: true
					}
				}]
			}
		}
	}
}, {
	metadata: {
		name: "mimir-ingester-zone-b"
		labels: {
			"app.kubernetes.io/component": "ingester"
			"app.kubernetes.io/part-of":   "memberlist"
			name:                          "ingester-zone-b"
			"rollout-group":               "ingester"
			zone:                          "zone-b"
		}
		annotations: "rollout-max-unavailable": "25"
	}
	spec: {
		podManagementPolicy: "Parallel"
		replicas:            1
		selector: matchLabels: {
			"app.kubernetes.io/name":      #Name
			"app.kubernetes.io/instance":  #Name
			"app.kubernetes.io/component": "ingester"
			"rollout-group":               "ingester"
			zone:                          "zone-b"
		}
		updateStrategy: type: "OnDelete"
		serviceName: "mimir-ingester-headless"
		volumeClaimTemplates: [{
			metadata: name: "storage"
			spec: {
				accessModes: ["ReadWriteOnce"]
				resources: requests: storage: "2Gi"
			}
		}]
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      #Name
				"app.kubernetes.io/instance":  #Name
				"app.kubernetes.io/version":   #Version
				"app.kubernetes.io/component": "ingester"
				"app.kubernetes.io/part-of":   "memberlist"
				name:                          "ingester-zone-b"
				"rollout-group":               "ingester"
				zone:                          "zone-b"
			}
			spec: {
				serviceAccountName: #Name
				securityContext: {
					fsGroup:      10001
					runAsGroup:   10001
					runAsNonRoot: true
					runAsUser:    10001
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
				topologySpreadConstraints: [{
					maxSkew:           1
					topologyKey:       "kubernetes.io/hostname"
					whenUnsatisfiable: "ScheduleAnyway"
					labelSelector: matchLabels: {
						"app.kubernetes.io/name":      #Name
						"app.kubernetes.io/instance":  #Name
						"app.kubernetes.io/component": "ingester"
					}
				}]
				terminationGracePeriodSeconds: 240
				volumes: [{
					name: "config"
					configMap: {
						name: "mimir-config"
						items: [{
							key:  "mimir.yaml"
							path: "mimir.yaml"
						}]
					}
				}, {
					name: "runtime-config"
					configMap: name: "mimir-runtime"
				}, {
					name: "active-queries"
					emptyDir: {}
				}]
				containers: [{
					name:            "ingester"
					image:           "grafana/mimir:2.7.1"
					imagePullPolicy: "IfNotPresent"
					args: [
						"-target=ingester",
						"-config.expand-env=true",
						"-config.file=/etc/mimir/mimir.yaml",
						"-ingester.ring.instance-availability-zone=zone-b",
					]
					volumeMounts: [{
						name:      "config"
						mountPath: "/etc/mimir"
					}, {
						name:      "runtime-config"
						mountPath: "/var/mimir"
					}, {
						name:      "storage"
						mountPath: "/data"
					}, {
						name:      "active-queries"
						mountPath: "/active-query-tracker"
					}]
					ports: [{
						name:          "http-metrics"
						containerPort: 8080
					}, {
						name:          "grpc"
						containerPort: 9095
					}, {
						name:          "memberlist"
						containerPort: 7946
					}]
					env: _#BucketEnvironmentVariables
					readinessProbe: {
						httpGet: {
							path: "/ready"
							port: "http-metrics"
						}
						initialDelaySeconds: 60
					}
					resources: requests: {
						cpu:    "100m"
						memory: "512Mi"
					}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
					}
				}]
			}
		}
	}
}, {
	metadata: {
		name: "mimir-ingester-zone-c"
		labels: {
			"app.kubernetes.io/component": "ingester"
			"app.kubernetes.io/part-of":   "memberlist"
			name:                          "ingester-zone-c"
			"rollout-group":               "ingester"
			zone:                          "zone-c"
		}
		annotations: "rollout-max-unavailable": "25"
	}
	spec: {
		podManagementPolicy: "Parallel"
		replicas:            1
		selector: matchLabels: {
			"app.kubernetes.io/name":      #Name
			"app.kubernetes.io/instance":  #Name
			"app.kubernetes.io/component": "ingester"
			"rollout-group":               "ingester"
			zone:                          "zone-c"
		}
		updateStrategy: type: "OnDelete"
		serviceName: "mimir-ingester-headless"
		volumeClaimTemplates: [{
			metadata: name: "storage"
			spec: {
				accessModes: ["ReadWriteOnce"]
				resources: requests: storage: "2Gi"
			}
		}]
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      #Name
				"app.kubernetes.io/instance":  #Name
				"app.kubernetes.io/version":   #Version
				"app.kubernetes.io/component": "ingester"
				"app.kubernetes.io/part-of":   "memberlist"
				name:                          "ingester-zone-c"
				"rollout-group":               "ingester"
				zone:                          "zone-c"
			}
			spec: {
				serviceAccountName: #Name
				securityContext: {
					fsGroup:      10001
					runAsGroup:   10001
					runAsNonRoot: true
					runAsUser:    10001
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
				topologySpreadConstraints: [{
					maxSkew:           1
					topologyKey:       "kubernetes.io/hostname"
					whenUnsatisfiable: "ScheduleAnyway"
					labelSelector: matchLabels: {
						"app.kubernetes.io/name":      #Name
						"app.kubernetes.io/instance":  #Name
						"app.kubernetes.io/component": "ingester"
					}
				}]
				terminationGracePeriodSeconds: 240
				volumes: [{
					name: "config"
					configMap: {
						name: "mimir-config"
						items: [{
							key:  "mimir.yaml"
							path: "mimir.yaml"
						}]
					}
				}, {
					name: "runtime-config"
					configMap: name: "mimir-runtime"
				}, {
					name: "active-queries"
					emptyDir: {}
				}]
				containers: [{
					name:            "ingester"
					image:           "grafana/mimir:2.7.1"
					imagePullPolicy: "IfNotPresent"
					args: [
						"-target=ingester",
						"-config.expand-env=true",
						"-config.file=/etc/mimir/mimir.yaml",
						"-ingester.ring.instance-availability-zone=zone-c",
					]
					volumeMounts: [{
						name:      "config"
						mountPath: "/etc/mimir"
					}, {
						name:      "runtime-config"
						mountPath: "/var/mimir"
					}, {
						name:      "storage"
						mountPath: "/data"
					}, {
						name:      "active-queries"
						mountPath: "/active-query-tracker"
					}]
					ports: [{
						name:          "http-metrics"
						containerPort: 8080
					}, {
						name:          "grpc"
						containerPort: 9095
					}, {
						name:          "memberlist"
						containerPort: 7946
					}]
					env: _#BucketEnvironmentVariables
					readinessProbe: {
						httpGet: {
							path: "/ready"
							port: "http-metrics"
						}
						initialDelaySeconds: 60
					}
					resources: requests: {
						cpu:    "100m"
						memory: "512Mi"
					}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
					}
				}]
			}
		}
	}
}, {
	metadata: {
		name: "mimir-store-gateway-zone-a"
		labels: {
			"app.kubernetes.io/component": "store-gateway"
			"app.kubernetes.io/part-of":   "memberlist"
			name:                          "store-gateway-zone-a"
			"rollout-group":               "store-gateway"
			zone:                          "zone-a"
		}
		annotations: "rollout-max-unavailable": "10"
	}
	spec: {
		replicas: 1
		selector: matchLabels: {
			"app.kubernetes.io/name":      #Name
			"app.kubernetes.io/instance":  #Name
			"app.kubernetes.io/component": "store-gateway"
			"rollout-group":               "store-gateway"
			zone:                          "zone-a"
		}
		updateStrategy: type: "OnDelete"
		serviceName: "mimir-store-gateway-headless"
		volumeClaimTemplates: [{
			metadata: name: "storage"
			spec: {
				accessModes: ["ReadWriteOnce"]
				resources: requests: storage: "2Gi"
			}
		}]
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      #Name
				"app.kubernetes.io/instance":  #Name
				"app.kubernetes.io/version":   #Version
				"app.kubernetes.io/component": "store-gateway"
				"app.kubernetes.io/part-of":   "memberlist"
				name:                          "store-gateway-zone-a"
				"rollout-group":               "store-gateway"
				zone:                          "zone-a"
			}
			spec: {
				serviceAccountName: #Name
				securityContext: {
					fsGroup:      10001
					runAsGroup:   10001
					runAsNonRoot: true
					runAsUser:    10001
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
				topologySpreadConstraints: [{
					maxSkew:           1
					topologyKey:       "kubernetes.io/hostname"
					whenUnsatisfiable: "ScheduleAnyway"
					labelSelector: matchLabels: {
						"app.kubernetes.io/name":      #Name
						"app.kubernetes.io/instance":  #Name
						"app.kubernetes.io/component": "store-gateway"
					}
				}]
				terminationGracePeriodSeconds: 240
				volumes: [{
					name: "config"
					configMap: {
						name: "mimir-config"
						items: [{
							key:  "mimir.yaml"
							path: "mimir.yaml"
						}]
					}
				}, {
					name: "runtime-config"
					configMap: name: "mimir-runtime"
				}, {
					name: "active-queries"
					emptyDir: {}
				}]
				containers: [{
					name:            "store-gateway"
					image:           "grafana/mimir:2.7.1"
					imagePullPolicy: "IfNotPresent"
					args: [
						"-target=store-gateway",
						"-config.expand-env=true",
						"-config.file=/etc/mimir/mimir.yaml",
						"-store-gateway.sharding-ring.instance-availability-zone=zone-a",
					]
					volumeMounts: [{
						name:      "config"
						mountPath: "/etc/mimir"
					}, {
						name:      "runtime-config"
						mountPath: "/var/mimir"
					}, {
						name:      "storage"
						mountPath: "/data"
					}, {
						name:      "active-queries"
						mountPath: "/active-query-tracker"
					}]
					ports: [{
						name:          "http-metrics"
						containerPort: 8080
					}, {
						name:          "grpc"
						containerPort: 9095
					}, {
						name:          "memberlist"
						containerPort: 7946
					}]
					env: _#BucketEnvironmentVariables
					readinessProbe: {
						httpGet: {
							path: "/ready"
							port: "http-metrics"
						}
						initialDelaySeconds: 60
					}
					resources: requests: {
						cpu:    "100m"
						memory: "512Mi"
					}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: [
							"ALL",
						]
						readOnlyRootFilesystem: true
					}
				}]
			}
		}
	}
}, {
	metadata: {
		name: "mimir-store-gateway-zone-b"
		labels: {
			"app.kubernetes.io/component": "store-gateway"
			"app.kubernetes.io/part-of":   "memberlist"
			name:                          "store-gateway-zone-b"
			"rollout-group":               "store-gateway"
			zone:                          "zone-b"
		}
		annotations: "rollout-max-unavailable": "10"
	}
	spec: {
		replicas: 1
		selector: matchLabels: {
			"app.kubernetes.io/name":      #Name
			"app.kubernetes.io/instance":  #Name
			"app.kubernetes.io/component": "store-gateway"
			"rollout-group":               "store-gateway"
			zone:                          "zone-b"
		}
		updateStrategy: type: "OnDelete"
		serviceName: "mimir-store-gateway-headless"
		volumeClaimTemplates: [{
			metadata: name: "storage"
			spec: {
				accessModes: ["ReadWriteOnce"]
				resources: requests: storage: "2Gi"
			}
		}]
		template: {
			metadata: {
				labels: {
					"app.kubernetes.io/name":      #Name
					"app.kubernetes.io/instance":  #Name
					"app.kubernetes.io/version":   #Version
					"app.kubernetes.io/component": "store-gateway"
					"app.kubernetes.io/part-of":   "memberlist"
					name:                          "store-gateway-zone-b"
					"rollout-group":               "store-gateway"
					zone:                          "zone-b"
				}
				annotations: "checksum/config": "40cf109426ea2dcf9692e98d6b98195bba0ed1e311958a8247d92389f6d84783"
				namespace: #Name
			}
			spec: {
				serviceAccountName: #Name
				securityContext: {
					fsGroup:      10001
					runAsGroup:   10001
					runAsNonRoot: true
					runAsUser:    10001
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
				topologySpreadConstraints: [{
					maxSkew:           1
					topologyKey:       "kubernetes.io/hostname"
					whenUnsatisfiable: "ScheduleAnyway"
					labelSelector: matchLabels: {
						"app.kubernetes.io/name":      #Name
						"app.kubernetes.io/instance":  #Name
						"app.kubernetes.io/component": "store-gateway"
					}
				}]
				terminationGracePeriodSeconds: 240
				volumes: [{
					name: "config"
					configMap: {
						name: "mimir-config"
						items: [{
							key:  "mimir.yaml"
							path: "mimir.yaml"
						}]
					}
				}, {
					name: "runtime-config"
					configMap: name: "mimir-runtime"
				}, {
					name: "active-queries"
					emptyDir: {}
				}]
				containers: [{
					name:            "store-gateway"
					image:           "grafana/mimir:2.7.1"
					imagePullPolicy: "IfNotPresent"
					args: [
						"-target=store-gateway",
						"-config.expand-env=true",
						"-config.file=/etc/mimir/mimir.yaml",
						"-store-gateway.sharding-ring.instance-availability-zone=zone-b",
					]
					volumeMounts: [{
						name:      "config"
						mountPath: "/etc/mimir"
					}, {
						name:      "runtime-config"
						mountPath: "/var/mimir"
					}, {
						name:      "storage"
						mountPath: "/data"
					}, {
						name:      "active-queries"
						mountPath: "/active-query-tracker"
					}]
					ports: [{
						name:          "http-metrics"
						containerPort: 8080
					}, {
						name:          "grpc"
						containerPort: 9095
					}, {
						name:          "memberlist"
						containerPort: 7946
					}]
					env: _#BucketEnvironmentVariables
					readinessProbe: {
						httpGet: {
							path: "/ready"
							port: "http-metrics"
						}
						initialDelaySeconds: 60
					}
					resources: requests: {
						cpu:    "100m"
						memory: "512Mi"
					}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
					}
				}]
			}
		}
	}
}, {
	metadata: {
		name: "mimir-store-gateway-zone-c"
		labels: {
			"app.kubernetes.io/component": "store-gateway"
			"app.kubernetes.io/part-of":   "memberlist"
			name:                          "store-gateway-zone-c"
			"rollout-group":               "store-gateway"
			zone:                          "zone-c"
		}
		annotations: "rollout-max-unavailable": "10"
	}
	spec: {
		replicas: 1
		selector: matchLabels: {
			"app.kubernetes.io/name":      #Name
			"app.kubernetes.io/instance":  #Name
			"app.kubernetes.io/component": "store-gateway"
			"rollout-group":               "store-gateway"
			zone:                          "zone-c"
		}
		updateStrategy: type: "OnDelete"
		serviceName: "mimir-store-gateway-headless"
		volumeClaimTemplates: [{
			metadata: name: "storage"
			spec: {
				accessModes: ["ReadWriteOnce"]
				resources: requests: storage: "2Gi"
			}
		}]
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      #Name
				"app.kubernetes.io/instance":  #Name
				"app.kubernetes.io/version":   #Version
				"app.kubernetes.io/component": "store-gateway"
				"app.kubernetes.io/part-of":   "memberlist"
				name:                          "store-gateway-zone-c"
				"rollout-group":               "store-gateway"
				zone:                          "zone-c"
			}
			spec: {
				serviceAccountName: #Name
				securityContext: {
					fsGroup:      10001
					runAsGroup:   10001
					runAsNonRoot: true
					runAsUser:    10001
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
				topologySpreadConstraints: [{
					maxSkew:           1
					topologyKey:       "kubernetes.io/hostname"
					whenUnsatisfiable: "ScheduleAnyway"
					labelSelector: matchLabels: {
						"app.kubernetes.io/name":      #Name
						"app.kubernetes.io/instance":  #Name
						"app.kubernetes.io/component": "store-gateway"
					}
				}]
				terminationGracePeriodSeconds: 240
				volumes: [{
					name: "config"
					configMap: {
						name: "mimir-config"
						items: [{
							key:  "mimir.yaml"
							path: "mimir.yaml"
						}]
					}
				}, {
					name: "runtime-config"
					configMap: name: "mimir-runtime"
				}, {
					name: "active-queries"
					emptyDir: {}
				}]
				containers: [{
					name:            "store-gateway"
					image:           "grafana/mimir:2.7.1"
					imagePullPolicy: "IfNotPresent"
					args: [
						"-target=store-gateway",
						"-config.expand-env=true",
						"-config.file=/etc/mimir/mimir.yaml",
						"-store-gateway.sharding-ring.instance-availability-zone=zone-c",
					]
					volumeMounts: [{
						name:      "config"
						mountPath: "/etc/mimir"
					}, {
						name:      "runtime-config"
						mountPath: "/var/mimir"
					}, {
						name:      "storage"
						mountPath: "/data"
					}, {
						name:      "active-queries"
						mountPath: "/active-query-tracker"
					}]
					ports: [{
						name:          "http-metrics"
						containerPort: 8080
					}, {
						name:          "grpc"
						containerPort: 9095
					}, {
						name:          "memberlist"
						containerPort: 7946
					}]
					env: _#BucketEnvironmentVariables
					readinessProbe: {
						httpGet: {
							path: "/ready"
							port: "http-metrics"
						}
						initialDelaySeconds: 60
					}
					resources: requests: {
						cpu:    "100m"
						memory: "512Mi"
					}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
					}
				}]
			}
		}
	}
}]
