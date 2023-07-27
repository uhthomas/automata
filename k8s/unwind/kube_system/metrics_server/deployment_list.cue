package metrics_server

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
		strategy: rollingUpdate: maxUnavailable:         0
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				volumes: [{
					emptyDir: {}
					name: "tmp-dir"
				}]
				containers: [{
					name:  "metrics-server"
					image: "registry.k8s.io/metrics-server/metrics-server:v0.6.3"
					args: [
						"--cert-dir=/tmp",
						"--secure-port=4443",
						"--kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname",
						"--kubelet-use-node-status-port",
						"--metric-resolution=15s",
						"--kubelet-insecure-tls",
					]
					ports: [{
						name:          "https"
						containerPort: 4443
					}]
					resources: requests: {
						(v1.#ResourceCPU):   "100m"
						(v1.#ResourceMemory): "200Mi"
					}
					volumeMounts: [{
						mountPath: "/tmp"
						name:      "tmp-dir"
					}]
					livenessProbe: {
						failureThreshold: 3
						httpGet: {
							path:   "/livez"
							port:   "https"
							scheme: v1.#URISchemeHTTPS
						}
						periodSeconds: 10
					}
					readinessProbe: {
						failureThreshold: 3
						httpGet: {
							path:   "/readyz"
							port:   "https"
							scheme: v1.#URISchemeHTTPS
						}
						initialDelaySeconds: 20
						periodSeconds:       10
					}
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				nodeSelector: (v1.#LabelOSStable): v1.#Linux
				serviceAccountName: #Name
				securityContext: {
					runAsUser:    1000
					runAsGroup:   3000
					runAsNonRoot: true
					fsGroup:      2000
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
				priorityClassName: "system-cluster-critical"
			}
		}
	}
}]
