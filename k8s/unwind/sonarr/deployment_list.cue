package sonarr

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
				containers: [{
					name:  #Name
					image: "linuxserver/sonarr:\(#Version)@sha256:86e607185c4b07cac135f351e2635acf4d1ea8b32fc0cadf46b5fb596f6c1db6"
					ports: [{
						name:          "http"
						containerPort: 8989
					}]
					resources: {
						limits: {
							cpu:    "1"
							memory: "2Gi"
						}
						requests: {
							cpu:    "1"
							memory: "1Gi"
						}
					}
					volumeMounts: [{
						name:      "config"
						mountPath: "/config"
					}, {
						name:      "tv"
						mountPath: "/tv"
					}, {
						name:      "downloads"
						mountPath: "/downloads"
					}]
					livenessProbe: httpGet: {
						path: "/health"
						port: "http"
					}
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
					runAsUser:    0
					runAsGroup:   0
					runAsNonRoot: false
					fsGroup:      0
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
				volumes: [{
					name: "config"
					persistentVolumeClaim: claimName: "\(#Name)-config"
				}, {
					name: "tv"
					persistentVolumeClaim: claimName: "\(#Name)-tv"
				}, {
					name: "downloads"
					persistentVolumeClaim: claimName: "\(#Name)-downloads"
				}]
			}
		}
		strategy: type: appsv1.#RecreateDeploymentStrategyType
	}
}]
