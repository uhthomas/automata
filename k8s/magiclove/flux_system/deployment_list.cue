package flux_system

import appsv1 "k8s.io/api/apps/v1"

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
		name: "source-controller"
		labels: {
			"app.kubernetes.io/component": "source-controller"
			"control-plane":               "controller"
		}
	}
	spec: {
		selector: matchLabels: app: "source-controller"
		template: {
			metadata: {
				labels: {
					app:                           "source-controller"
					"app.kubernetes.io/component": "source-controller"
					"app.kubernetes.io/instance":  #Namespace
					"app.kubernetes.io/part-of":   #Name
					"app.kubernetes.io/version":   "v\(#Version)"
				}
				annotations: {
					"prometheus.io/port":   "8080"
					"prometheus.io/scrape": "true"
				}
			}
			spec: {
				volumes: [{
					name: "data"
					emptyDir: {}
				}, {
					name: "tmp"
					emptyDir: {}
				}]
				containers: [{
					name:  "manager"
					image: "ghcr.io/fluxcd/source-controller:v\(#SourceControllerVersion)"
					args: ["--events-addr=", "--watch-all-namespaces=true", "--log-level=info", "--log-encoding=json", "--enable-leader-election", "--storage-path=/data", "--storage-adv-addr=source-controller.$(RUNTIME_NAMESPACE).svc.cluster.local."]
					ports: [{
						name:          "http"
						containerPort: 9090
						protocol:      "TCP"
					}, {
						name:          "http-prom"
						containerPort: 8080
						protocol:      "TCP"
					}, {
						name:          "healthz"
						containerPort: 9440
						protocol:      "TCP"
					}]
					env: [{
						name: "RUNTIME_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}, {
						name:  "TUF_ROOT"
						value: "/tmp/.sigstore"
					}, {
						name: "GOMEMLIMIT"
						valueFrom: resourceFieldRef: {
							containerName: "manager"
							resource:      "limits.memory"
						}
					}]
					resources: {
						limits: {
							cpu:    "1000m"
							memory: "1Gi"
						}
						requests: {
							cpu:    "50m"
							memory: "64Mi"
						}
					}
					volumeMounts: [{
						name:      "data"
						mountPath: "/data"
					}, {
						name:      "tmp"
						mountPath: "/tmp"
					}]
					livenessProbe: httpGet: {
						path: "/healthz"
						port: "healthz"
					}
					readinessProbe: httpGet: {
						path: "/"
						port: "http"
					}
					imagePullPolicy: "IfNotPresent"
					securityContext: {
						capabilities: drop: ["ALL"]
						runAsNonRoot:             true
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
						seccompProfile: type: "RuntimeDefault"
					}
				}]
				terminationGracePeriodSeconds: 10
				nodeSelector: "kubernetes.io/os": "linux"
				serviceAccountName: "source-controller"
				securityContext: fsGroup: 1337
				priorityClassName: "system-cluster-critical"
			}
		}
		strategy: type: "Recreate"
	}
}, {
	metadata: {
		name: "kustomize-controller"
		labels: {
			"app.kubernetes.io/component": "kustomize-controller"
			"control-plane":               "controller"
		}
	}
	spec: {
		replicas: 1
		selector: matchLabels: app: "kustomize-controller"
		template: {
			metadata: {
				labels: {
					app:                           "kustomize-controller"
					"app.kubernetes.io/component": "kustomize-controller"
					"app.kubernetes.io/instance":  #Namespace
					"app.kubernetes.io/part-of":   #Name
					"app.kubernetes.io/version":   "v\(#Version)"
				}
				annotations: {
					"prometheus.io/port":   "8080"
					"prometheus.io/scrape": "true"
				}
			}
			spec: {
				volumes: [{
					name: "temp"
					emptyDir: {}
				}]
				containers: [{
					name:  "manager"
					image: "ghcr.io/fluxcd/kustomize-controller:v\(#KustomizeControllerVersion)"
					args: ["--events-addr=", "--watch-all-namespaces=true", "--log-level=info", "--log-encoding=json", "--enable-leader-election"]
					ports: [{
						name:          "http-prom"
						containerPort: 8080
						protocol:      "TCP"
					}, {
						name:          "healthz"
						containerPort: 9440
						protocol:      "TCP"
					}]
					env: [{
						name: "RUNTIME_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}, {
						name: "GOMEMLIMIT"
						valueFrom: resourceFieldRef: {
							containerName: "manager"
							resource:      "limits.memory"
						}
					}]
					resources: {
						limits: {
							cpu:    "1000m"
							memory: "1Gi"
						}
						requests: {
							cpu:    "100m"
							memory: "64Mi"
						}
					}
					volumeMounts: [{
						name:      "temp"
						mountPath: "/tmp"
					}]
					livenessProbe: httpGet: {
						path: "/healthz"
						port: "healthz"
					}
					readinessProbe: httpGet: {
						path: "/readyz"
						port: "healthz"
					}
					imagePullPolicy: "IfNotPresent"
					securityContext: {
						capabilities: drop: ["ALL"]
						runAsNonRoot:             true
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
						seccompProfile: type: "RuntimeDefault"
					}
				}]
				terminationGracePeriodSeconds: 60
				nodeSelector: "kubernetes.io/os": "linux"
				serviceAccountName: "kustomize-controller"
				securityContext: fsGroup: 1337
				priorityClassName: "system-cluster-critical"
			}
		}
	}
}]
