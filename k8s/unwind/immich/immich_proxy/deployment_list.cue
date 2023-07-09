package immich_proxy

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
		selector: matchLabels: template.metadata.labels
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      #Name
				"app.kubernetes.io/component": #Component
			}
			spec: {
				volumes: [{
					name: "tmp"
					emptyDir: {}
				}, {
					name: "nginx-conf"
					emptyDir: {}
				}]
				containers: [{
					name:  #Name
					image: "ghcr.io/immich-app/immich-proxy:v\(#Version)"
					ports: [{
						name:          "http"
						containerPort: 8080
					}]
					env: [{
						name:  "IMMICH_WEB_URL"
						value: "http://immich-web"
					}, {
						name:  "IMMICH_SERVER_URL"
						value: "http://immich-server"
					}]
					resources: limits: {
						cpu:    "600m"
						memory: "128Mi"
					}
					volumeMounts: [{
						name:      "tmp"
						mountPath: "/tmp"
					}, {
						name:      "nginx-conf"
						mountPath: "/etc/nginx/conf.d"
					}]

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
