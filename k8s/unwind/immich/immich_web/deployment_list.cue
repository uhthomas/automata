package immich_web

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
				containers: [{
					name:  #Name
					image: "ghcr.io/immich-app/immich-web:v\(#Version)"
					command: ["/bin/sh"]
					args: ["./entrypoint.sh"]
					env: [{
						name:  "ENABLE_MAPBOX"
						value: "false"
					}, {
						name:  "JWT_SECRET"
						value: "randomstringthatissolongandpowerfulthatnoonecanguess"
					}, {
						name:  "MAPBOX_KEY"
						value: ""
					}, {
						name:  "NODE_ENV"
						value: "production"
					}, {
						name:  "REDIS_HOSTNAME"
						value: "rfs-redis"
					}]
					ports: [{
						name:          "http"
						containerPort: 3000
					}]

					// _probe: httpGet: {
					//  path: "/"
					//  port: "http"
					// }

					// livenessProbe:  _probe
					// readinessProbe: _probe

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
