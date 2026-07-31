package reloader

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
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				containers: [{
					name:  #Name
					image: _image.reference
					args: ["--log-level=info"]
					env: [{
						name: "GOMAXPROCS"
						valueFrom: resourceFieldRef: {
							resource: "limits.cpu"
							divisor:  1
						}
					}, {
						name: "GOMEMLIMIT"
						valueFrom: resourceFieldRef: {
							resource: "limits.memory"
							divisor:  1
						}
					}, {
						name: "RELOADER_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}, {
						name:  "RELOADER_DEPLOYMENT_NAME"
						value: #Name
					}]
					ports: [{
						name:          "http"
						containerPort: 9090
					}]
					resources: {
						limits: {
							(v1.#ResourceCPU):    "150m"
							(v1.#ResourceMemory): "512Mi"
						}
						requests: {
							(v1.#ResourceCPU):    "10m"
							(v1.#ResourceMemory): "128Mi"
						}
					}

					let probe = {
						httpGet: port: "http"
						timeoutSeconds:      5
						failureThreshold:    5
						periodSeconds:       10
						initialDelaySeconds: 10
					}

					livenessProbe: probe & {httpGet: path: "/live"}
					readinessProbe: probe & {httpGet: path: "/metrics"}

					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				serviceAccountName: #Name
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
	}
}]
