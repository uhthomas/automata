package tailscale

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

// renovate: datasource=docker depName=tailscale/tailscale versioning=docker
let _tailscaleVersion = "v1.56.0"

#DeploymentList: items: [{
	metadata: name: "operator"
	spec: {
		strategy: type: appsv1.#RecreateDeploymentStrategyType
		selector: matchLabels: "app.kubernetes.io/name": "operator"
		template: {
			metadata: labels: "app.kubernetes.io/name": "operator"
			spec: {
				volumes: [{
					name: "config"
					emptyDir: {}
				}, {
					name: "oauth"
					secret: secretName: "tailscale-oauth"
				}]
				containers: [{
					name:  "operator"
					image: "tailscale/k8s-operator:unstable-v\(#Version)"
					env: [{
						name:  "OPERATOR_HOSTNAME"
						value: "tailscale-operator-amour"
					}, {
						name:  "OPERATOR_SECRET"
						value: "operator"
					}, {
						name:  "OPERATOR_LOGGING"
						value: "debug"
					}, {
						name: "OPERATOR_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}, {
						name:  "CLIENT_ID_FILE"
						value: "/oauth/client-id"
					}, {
						name:  "CLIENT_SECRET_FILE"
						value: "/oauth/client-secret"
					}, {
						name:  "PROXY_IMAGE"
						value: "tailscale/tailscale:\(_tailscaleVersion)"
					}, {
						name:  "PROXY_TAGS"
						value: "tag:k8s,tag:amour"
					}, {
						name:  "AUTH_PROXY"
						value: "true"
					}]
					resources: requests: {
						(v1.#ResourceCPU):    "100m"
						(v1.#ResourceMemory): "100Mi"
					}
					volumeMounts: [{
						name:      "config"
						mountPath: "/.config"
					}, {
						name:      "oauth"
						readOnly:  true
						mountPath: "/oauth"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				serviceAccountName: "operator"
				securityContext: {
					runAsUser:    1000
					runAsGroup:   3000
					runAsNonRoot: true
					fsGroup:      2000
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
	}
}]
