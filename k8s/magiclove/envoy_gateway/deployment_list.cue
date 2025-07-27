package envoy_gateway

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
				volumes: [{
					name: "config"
					configMap: {
						name:        #Name
						defaultMode: 420
					}
				}, {
					name: "certs"
					secret: secretName: #Name
				}]
				containers: [{
					name:  "envoy-gateway"
					image: "docker.io/envoyproxy/gateway:v\(#Version)"
					args: [
						"server",
						"--config-path=/etc/envoy-gateway/config.yaml",
					]
					ports: [{
						name:          "health"
						containerPort: 8081
					}, {
						name:          "webhook"
						containerPort: 9443
					}, {
						name:          "grpc"
						containerPort: 18000
					}, {
						name:          "ratelimit"
						containerPort: 18001
					}, {
						name:          "wasm"
						containerPort: 18002
					}, {
						name:          "metrics"
						containerPort: 19001
					}]
					env: [{
						name: "ENVOY_GATEWAY_NAMESPACE"
						valueFrom: fieldRef: {
							apiVersion: "v1"
							fieldPath:  "metadata.namespace"
						}
					}, {
						name:  "KUBERNETES_CLUSTER_DOMAIN"
						value: "cluster.local"
					}]
					resources: limits: {
						cpu:    "100m"
						memory: "256Mi"
					}
					volumeMounts: [{
						name:      "config"
						mountPath: "/etc/envoy-gateway"
						readOnly:  true
					}, {
						name:      "certs"
						mountPath: "/certs"
						readOnly:  true
					}]

					let probe = {httpGet: port: "health"}

					livenessProbe: probe & {httpGet: path: "/healthz"}
					readinessProbe: probe & {httpGet: path: "/readyz"}

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
