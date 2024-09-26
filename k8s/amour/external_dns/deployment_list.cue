package external_dns

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
		// replicas: 0
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				containers: [{
					name:  "external-dns"
					image: "registry.k8s.io/external-dns/external-dns:v\(#Version)"
					args: [
						"--source=service",
						"--source=ingress",
						"--source=gateway-httproute",
						"--source=gateway-tlsroute",
						"--source=gateway-tcproute",
						"--source=gateway-udproute",
						"--registry=txt",
						"--provider=cloudflare",
					]
					ports: [{
						name:          "http-metrics"
						containerPort: 7979
					}]
					env: [{
						name: "CF_API_TOKEN"
						valueFrom: secretKeyRef: {
							name: #Name
							key:  "cloudflare-api-token"
						}
					}]
					resources: requests: {
						(v1.#ResourceCPU):    "50m"
						(v1.#ResourceMemory): "128Mi"
					}

					let probe = {
						httpGet: {
							path: "/healthz"
							port: "http-metrics"
						}
					}

					livenessProbe:  probe
					readinessProbe: probe

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
		strategy: type: appsv1.#RecreateDeploymentStrategyType
	}
}]
