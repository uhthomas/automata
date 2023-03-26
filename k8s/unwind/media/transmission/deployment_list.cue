package transmission

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
					name: "downloads"
					persistentVolumeClaim: claimName: "media-downloads"
				}]
				containers: [{
					name:  #Name
					image: "linuxserver/transmission:\(#Version)@sha256:96dc383c0451c63185d21713c4f248d8b856e67627301dc21137612e6bb967e2"
					ports: [{
						name:          "http"
						containerPort: 9091
					}, {
						name:          "torrent"
						containerPort: 51413
					}]
					env: [{
						name:  "PUID"
						value: "2000"
					}, {
						name:  "PGID"
						value: "2000"
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
					fsGroup:      2000
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
		strategy: type: appsv1.#RecreateDeploymentStrategyType
	}
}]
