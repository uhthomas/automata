package immich_server

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
					name: "geocoding-dump"
					emptyDir: {}
				}, {
					name: "library"
					persistentVolumeClaim: claimName: "immich-library"
				}, {
					name: "transformers-cache"
					emptyDir: {}
				}]
				containers: [{
					name:            #Name
					image:           "ghcr.io/immich-app/immich-server:v\(#Version)"
					imagePullPolicy: v1.#PullIfNotPresent
					command: ["/bin/sh"]
					args: ["./start-server.sh"]
					env: [{
						name:  "DB_DATABASE_NAME"
						value: "immich"
					}, {
						name:  "DB_HOSTNAME"
						value: "immich-postgresql"
					}, {
						name:  "DB_PASSWORD"
						value: "thisshouldnotbeyourpassword"
					}, {
						name:  "DB_USERNAME"
						value: "immich"
					}, {
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
						containerPort: 3001
					}]
					volumeMounts: [{
						name:      "geocoding-dump"
						mountPath: "/usr/src/app/.reverse-geocoding-dump"
					}, {
						name:      "library"
						mountPath: "/usr/src/app/upload"
					}, {
						name:      "transformers-cache"
						mountPath: "/usr/src/app/.transformers_cache"
					}]

					_probe: httpGet: {
						path: "/server-info/ping"
						port: "http"
					}

					livenessProbe:  _probe
					readinessProbe: _probe
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
