package immich_server

import (
	"encoding/base64"
	"encoding/json"

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
				}, {
					name: "secrets-store-inline"
					csi: {
						driver:   "secrets-store.csi.k8s.io"
						readOnly: true
						volumeAttributes: secretProviderClass: #Name
					}
				}]
				containers: [{
					name:            #Name
					image:           "ghcr.io/immich-app/immich-server:v\(#Version)"
					imagePullPolicy: v1.#PullIfNotPresent
					command: ["/bin/sh"]
					args: ["./start-server.sh"]
					env: [{
						name:  "NODE_ENV"
						value: "production"
					}, {
						name: "DB_URL"
						valueFrom: secretKeyRef: {
							name: "postgres-pguser-immich"
							key:  "uri"
						}
					}, {
						name:  "PGSSLMODE"
						value: "no-verify"
					}, {
						name:  "REDIS_URL"
						value: "ioredis://\(base64.Encode(null, json.Marshal({
							name: "mymaster"
							sentinels: [{
								host: "rfs-redis"
								port: 26379
							}]
						})))"
					}, {
						name:  "TYPESENSE_URL"
						value: "ha://\(base64.Encode(null, json.Marshal([{
							host:     "typesense-0.typesense.\(#Namespace).svc.cluster.local"
							port:     80
							protocol: "http"
						}])))"
					}, {
						name: "TYPESENSE_API_KEY"
						valueFrom: secretKeyRef: {
							name: #Name
							key:  "typesense-api-key"
						}
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
					}, {
						name:      "secrets-store-inline"
						readOnly:  true
						mountPath: "/mnt/secrets-store"
					}]

					let probe = {
						httpGet: {
							path: "/server-info/ping"
							port: "http"
						}
					}

					livenessProbe:  probe
					readinessProbe: probe
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				serviceAccountName: #Name
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
