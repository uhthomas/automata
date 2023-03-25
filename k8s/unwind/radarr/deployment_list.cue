package radarr

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
					image: "linuxserver/radarr:\(#Version)@sha256:d767785c8c7028e398d38520d0f547ffef60b18d5ebb0e5fa85f92564bd47dd3"
					ports: [{
						name:          "http"
						containerPort: 7878
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
						name:      "movies"
						mountPath: "/movies"
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
					name: "movies"
					persistentVolumeClaim: claimName: "\(#Name)-movies"
				}, {
					name: "downloads"
					persistentVolumeClaim: claimName: "\(#Name)-downloads"
				}]
			}
		}
		strategy: type: appsv1.#RecreateDeploymentStrategyType
	}
}]
