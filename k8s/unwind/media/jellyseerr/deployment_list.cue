package jellyseerr

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
				volumes: [{
					name: "config"
					persistentVolumeClaim: claimName: "\(#Name)-config"
				}, {
					name: "tmp"
					emptyDir: {}
				}, {
					name: "yarn-cache"
					emptyDir: {}
				}, {
					name: "yarn"
					emptyDir: {}
				}]
				containers: [{
					name:  #Name
					image: "fallenbagel/jellyseerr:\(#Version)@sha256:eacfbd18c13036b5fea87fc8c44ea165c6339d75fe15d3f0c83bbf3e39a1560e"
					ports: [{
						name:          "http"
						containerPort: 5055
					}]
					env: [{
						name:  "TZ"
						value: "Europe/London"
					}]
					resources: {
						limits: {
							cpu:    "2"
							memory: "8Gi"
						}
						requests: {
							cpu:    "1"
							memory: "2Gi"
						}
					}
					volumeMounts: [{
						name:      "config"
						mountPath: "/app/config"
					}, {
						name:      "tmp"
						mountPath: "/tmp"
					}, {
						name:      "yarn-cache"
						mountPath: "/home/node/.cache/yarn"
					}, {
						name:      "yarn"
						mountPath: "/home/node/.yarn"
					}]
					livenessProbe: httpGet: {
						path: "/health"
						port: "http"
					}
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				securityContext: {
					runAsUser:    1000
					runAsGroup:   3000
					runAsNonRoot: true
					fsGroup:      2000
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
		strategy: type: appsv1.#RecreateDeploymentStrategyType
	}
}]
