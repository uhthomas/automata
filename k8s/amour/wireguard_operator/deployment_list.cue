package wireguard_operator

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
			metadata: {
				annotations: "kubectl.kubernetes.io/default-container": "manager"
				labels: "app.kubernetes.io/name":                       #Name
			}
			spec: {
				containers: [{
					name:  "kube-rbac-proxy"
					image: "gcr.io/kubebuilder/kube-rbac-proxy:v0.8.0"
					args: [
						"--secure-listen-address=0.0.0.0:8443",
						"--upstream=http://127.0.0.1:8080/",
						"--logtostderr=true",
						"--v=0",
					]
					ports: [{
						name:          "https-metrics"
						containerPort: 8443
					}]
					resources: limits: {
						cpu:    "150m"
						memory: "64Mi"
					}
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}, {
					name:  "manager"
					image: "ghcr.io/jodevsa/wireguard-operator/manager:v\(#Version)"
					command: ["/manager"]
					args: [
						"--health-probe-bind-address=:8081",
						"--metrics-bind-address=127.0.0.1:8080",
						"--leader-elect",
						// "--agent-image=ghcr.io/jodevsa/wireguard-operator/agent:\(#Version)",
						"--agent-image=ghcr.io/jodevsa/wireguard-operator/agent:dev-172",
					]
					ports: [{
						name:          "http-metrics"
						containerPort: 8080
					}, {
						name:          "healthz"
						containerPort: 8081
					}]
					resources: limits: {
						cpu:    "150m"
						memory: "64Mi"
					}
					livenessProbe: {
						httpGet: {
							path: "/healthz"
							port: "healthz"
						}
						initialDelaySeconds: 15
						periodSeconds:       20
					}
					readinessProbe: {
						httpGet: {
							path: "/readyz"
							port: "healthz"
						}
						initialDelaySeconds: 5
						periodSeconds:       10
					}
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
