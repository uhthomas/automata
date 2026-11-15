package livesync

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
	metadata: annotations: "reloader.stakater.com/auto": "true"
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				volumes: [{
					name: "config"
					configMap: name: #Name
				}, {
					// The image entrypoint writes credentials here; CouchDB hashes them.
					name: "runtime-config"
					emptyDir: {}
				}, {
					name: "tmp"
					emptyDir: {}
				}, {
					name: "data"
					persistentVolumeClaim: claimName: #Name
				}]
				containers: [{
					name:  #Name
					image: _image.reference
					ports: [{
						name:          "http"
						containerPort: 5984
					}]
					env: [{
						name: "COUCHDB_USER"
						valueFrom: secretKeyRef: {
							name: #Name
							key:  "username"
						}
					}, {
						name: "COUCHDB_PASSWORD"
						valueFrom: secretKeyRef: {
							name: #Name
							key:  "password"
						}
					}]
					resources: {
						limits: (v1.#ResourceMemory): "512Mi"
						requests: (v1.#ResourceCPU):  "100m"
					}
					volumeMounts: [{
						name:      "config"
						readOnly:  true
						mountPath: "/opt/couchdb/etc/local.ini"
						subPath:   "local.ini"
					}, {
						name:      "runtime-config"
						mountPath: "/opt/couchdb/etc/local.d"
					}, {
						name:      "tmp"
						mountPath: "/tmp"
					}, {
						name:      "data"
						mountPath: "/opt/couchdb/data"
					}]

					let probe = {
						httpGet: {
							path: "/_up"
							port: "http"
						}
					}

					livenessProbe:  probe
					readinessProbe: probe
					startupProbe: probe & {
						periodSeconds:    2
						failureThreshold: 30
					}
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				automountServiceAccountToken: false
				securityContext: {
					runAsUser:           1000
					runAsGroup:          3000
					runAsNonRoot:        true
					fsGroup:             2000
					fsGroupChangePolicy: v1.#FSGroupChangeOnRootMismatch
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
		strategy: type: appsv1.#RecreateDeploymentStrategyType
	}
}]
