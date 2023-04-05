package mimir

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
	metadata: {
		name: "mimir-distributor"
		labels: {
			"app.kubernetes.io/component": "distributor"
			"app.kubernetes.io/part-of":   "memberlist"
		}
	}
	spec: {
		replicas: 1
		selector: matchLabels: {
			"app.kubernetes.io/name":      #Name
			"app.kubernetes.io/instance":  #Name
			"app.kubernetes.io/component": "distributor"
		}
		strategy: type: "RollingUpdate"
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      #Name
				"app.kubernetes.io/instance":  #Name
				"app.kubernetes.io/component": "distributor"
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
				containers: [{
					name:            "distributor"
					image:           "grafana/mimir:2.7.1"
					imagePullPolicy: v1.#PullIfNotPresent
					args: [
						"-target=distributor",
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
						initialDelaySeconds: 45
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
				topologySpreadConstraints: [{
					maxSkew:           1
					topologyKey:       "kubernetes.io/hostname"
					whenUnsatisfiable: "ScheduleAnyway"
					labelSelector: matchLabels: {
						"app.kubernetes.io/name":      #Name
						"app.kubernetes.io/instance":  #Name
						"app.kubernetes.io/component": "distributor"
					}
				}]
				terminationGracePeriodSeconds: 60
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
					name: "storage"
					emptyDir: {}
				}, {
					name: "active-queries"
					emptyDir: {}
				}]
			}
		}
	}
}, {
	metadata: {
		name: "mimir-nginx"
		labels: "app.kubernetes.io/component": "nginx"
	}
	spec: {
		replicas: 1
		strategy: type: "RollingUpdate"
		selector: matchLabels: {
			"app.kubernetes.io/name":      #Name
			"app.kubernetes.io/instance":  #Name
			"app.kubernetes.io/component": "nginx"
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      #Name
				"app.kubernetes.io/instance":  #Name
				"app.kubernetes.io/component": "nginx"
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
				terminationGracePeriodSeconds: 30
				containers: [{
					name:            "nginx"
					image:           "docker.io/nginxinc/nginx-unprivileged:1.22-alpine"
					imagePullPolicy: v1.#PullIfNotPresent
					ports: [{
						name:          "http-metric"
						containerPort: 8080
					}]
					readinessProbe: {
						httpGet: {
							path: "/"
							port: "http-metric"
						}
						initialDelaySeconds: 15
						timeoutSeconds:      1
					}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
					}
					volumeMounts: [{
						name:      "config"
						mountPath: "/etc/nginx"
					}, {
						name:      "tmp"
						mountPath: "/tmp"
					}, {
						name:      "docker-entrypoint-d-override"
						mountPath: "/docker-entrypoint.d"
					}]
				}]
				topologySpreadConstraints: [{
					maxSkew:           1
					topologyKey:       "kubernetes.io/hostname"
					whenUnsatisfiable: "ScheduleAnyway"
					labelSelector: matchLabels: {
						"app.kubernetes.io/name":      #Name
						"app.kubernetes.io/instance":  #Name
						"app.kubernetes.io/component": "nginx"
					}
				}]
				volumes: [{
					name: "config"
					configMap: name: "mimir-nginx"
				}, {
					name: "tmp"
					emptyDir: {}
				}, {
					name: "docker-entrypoint-d-override"
					emptyDir: {}
				}]
			}
		}
	}
}, {
	metadata: {
		name: "mimir-overrides-exporter"
		labels: "app.kubernetes.io/component": "overrides-exporter"
	}
	spec: {
		replicas: 1
		selector: matchLabels: {
			"app.kubernetes.io/name":      #Name
			"app.kubernetes.io/instance":  #Name
			"app.kubernetes.io/component": "overrides-exporter"
		}
		strategy: type: "RollingUpdate"
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      #Name
				"app.kubernetes.io/instance":  #Name
				"app.kubernetes.io/component": "overrides-exporter"
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
				containers: [{
					name:            "overrides-exporter"
					image:           "grafana/mimir:2.7.1"
					imagePullPolicy: v1.#PullIfNotPresent
					args: [
						"-target=overrides-exporter",
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
					}]
					env: _#BucketEnvironmentVariables
					livenessProbe: {
						httpGet: {
							path: "/ready"
							port: "http-metrics"
						}
						initialDelaySeconds: 45
					}
					readinessProbe: {
						httpGet: {
							path: "/ready"
							port: "http-metrics"
						}
						initialDelaySeconds: 45
					}
					resources: requests: {
						cpu:    "100m"
						memory: "128Mi"
					}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
					}
				}]
				terminationGracePeriodSeconds: 60
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
					name: "storage"
					emptyDir: {}
				}, {
					name: "active-queries"
					emptyDir: {}
				}]
			}
		}
	}
}, {
	metadata: {
		name: "mimir-querier"
		labels: {
			"app.kubernetes.io/component": "querier"
			"app.kubernetes.io/part-of":   "memberlist"
		}
	}
	spec: {
		replicas: 2
		selector: matchLabels: {
			"app.kubernetes.io/name":      #Name
			"app.kubernetes.io/instance":  #Name
			"app.kubernetes.io/component": "querier"
		}
		strategy: type: "RollingUpdate"
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      #Name
				"app.kubernetes.io/instance":  #Name
				"app.kubernetes.io/component": "querier"
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
				containers: [{
					name:            "querier"
					image:           "grafana/mimir:2.7.1"
					imagePullPolicy: v1.#PullIfNotPresent
					args: [
						"-target=querier",
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
						initialDelaySeconds: 45
					}
					resources: requests: {
						cpu:    "100m"
						memory: "128Mi"
					}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
					}
				}]
				topologySpreadConstraints: [{
					maxSkew:           1
					topologyKey:       "kubernetes.io/hostname"
					whenUnsatisfiable: "ScheduleAnyway"
					labelSelector: matchLabels: {
						"app.kubernetes.io/name":      #Name
						"app.kubernetes.io/instance":  #Name
						"app.kubernetes.io/component": "querier"
					}
				}]
				terminationGracePeriodSeconds: 180
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
					name: "storage"
					emptyDir: {}
				}, {
					name: "active-queries"
					emptyDir: {}
				}]
			}
		}
	}
}, {
	metadata: {
		name: "mimir-query-frontend"
		labels: "app.kubernetes.io/component": "query-frontend"
	}
	spec: {
		replicas: 1
		selector: matchLabels: {
			"app.kubernetes.io/name":      #Name
			"app.kubernetes.io/instance":  #Name
			"app.kubernetes.io/component": "query-frontend"
		}
		strategy: type: "RollingUpdate"
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      #Name
				"app.kubernetes.io/instance":  #Name
				"app.kubernetes.io/component": "query-frontend"
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
				containers: [{
					name:            "query-frontend"
					image:           "grafana/mimir:2.7.1"
					imagePullPolicy: v1.#PullIfNotPresent
					args: [
						"-target=query-frontend",
						"-config.expand-env=true",
						"-config.file=/etc/mimir/mimir.yaml",
					]
					volumeMounts: [{
						name:      "runtime-config"
						mountPath: "/var/mimir"
					}, {
						name:      "config"
						mountPath: "/etc/mimir"
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
					}]
					env: _#BucketEnvironmentVariables
					readinessProbe: {
						httpGet: {
							path: "/ready"
							port: "http-metrics"
						}
						initialDelaySeconds: 45
					}
					resources: requests: {
						cpu:    "100m"
						memory: "128Mi"
					}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
					}
				}]
				topologySpreadConstraints: [{
					maxSkew:           1
					topologyKey:       "kubernetes.io/hostname"
					whenUnsatisfiable: "ScheduleAnyway"
					labelSelector: matchLabels: {
						"app.kubernetes.io/name":      #Name
						"app.kubernetes.io/instance":  #Name
						"app.kubernetes.io/component": "query-frontend"
					}
				}]
				terminationGracePeriodSeconds: 180
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
					name: "storage"
					emptyDir: {}
				}, {
					name: "active-queries"
					emptyDir: {}
				}]
			}
		}
	}
}, {
	metadata: {
		name: "mimir-query-scheduler"
		labels: "app.kubernetes.io/component": "query-scheduler"
	}
	spec: {
		replicas: 2
		selector: matchLabels: {
			"app.kubernetes.io/name":      #Name
			"app.kubernetes.io/instance":  #Name
			"app.kubernetes.io/component": "query-scheduler"
		}
		strategy: {
			rollingUpdate: {
				maxSurge:       0
				maxUnavailable: 1
			}
			type: "RollingUpdate"
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      #Name
				"app.kubernetes.io/instance":  #Name
				"app.kubernetes.io/component": "query-scheduler"
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
				containers: [{
					name:            "query-scheduler"
					image:           "grafana/mimir:2.7.1"
					imagePullPolicy: v1.#PullIfNotPresent
					args: [
						"-target=query-scheduler",
						"-config.expand-env=true",
						"-config.file=/etc/mimir/mimir.yaml",
						// 100000 days, effectively infinity
						// 100000 days, effectively infinity
						"-server.grpc.keepalive.max-connection-age=2562047h",
						"-server.grpc.keepalive.max-connection-age-grace=2562047h",
					]
					volumeMounts: [{
						name:      "runtime-config"
						mountPath: "/var/mimir"
					}, {
						name:      "config"
						mountPath: "/etc/mimir"
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
					}]
					env: _#BucketEnvironmentVariables
					readinessProbe: {
						httpGet: {
							path: "/ready"
							port: "http-metrics"
						}
						initialDelaySeconds: 45
					}
					resources: requests: {
						cpu:    "100m"
						memory: "128Mi"
					}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
					}
				}]
				topologySpreadConstraints: [{
					maxSkew:           1
					topologyKey:       "kubernetes.io/hostname"
					whenUnsatisfiable: "ScheduleAnyway"
					labelSelector: matchLabels: {
						"app.kubernetes.io/name":      #Name
						"app.kubernetes.io/instance":  #Name
						"app.kubernetes.io/component": "query-scheduler"
					}
				}]
				terminationGracePeriodSeconds: 180
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
					name: "storage"
					emptyDir: {}
				}, {
					name: "active-queries"
					emptyDir: {}
				}]
			}
		}
	}
}, {
	metadata: {
		name: "mimir-ruler"
		labels: {
			"app.kubernetes.io/component": "ruler"
			"app.kubernetes.io/part-of":   "memberlist"
		}
	}
	spec: {
		replicas: 1
		selector: matchLabels: {
			"app.kubernetes.io/name":      #Name
			"app.kubernetes.io/instance":  #Name
			"app.kubernetes.io/component": "ruler"
		}
		strategy: {
			rollingUpdate: {
				maxSurge:       "50%"
				maxUnavailable: 0
			}
			type: "RollingUpdate"
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      #Name
				"app.kubernetes.io/instance":  #Name
				"app.kubernetes.io/component": "ruler"
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
				containers: [{
					name:            "ruler"
					image:           "grafana/mimir:2.7.1"
					imagePullPolicy: v1.#PullIfNotPresent
					args: [
						"-target=ruler",
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
						initialDelaySeconds: 45
					}
					resources: requests: {
						cpu:    "100m"
						memory: "128Mi"
					}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
					}
				}]
				topologySpreadConstraints: [{
					maxSkew:           1
					topologyKey:       "kubernetes.io/hostname"
					whenUnsatisfiable: "ScheduleAnyway"
					labelSelector: matchLabels: {
						"app.kubernetes.io/name":      #Name
						"app.kubernetes.io/instance":  #Name
						"app.kubernetes.io/component": "ruler"
					}
				}]
				terminationGracePeriodSeconds: 180
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
					name: "storage"
					emptyDir: {}
				}, {
					name: "active-queries"
					emptyDir: {}
				}]
			}
		}
	}
}]
