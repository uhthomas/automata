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

#DeploymentList: items: [{
	metadata: name: "operator"
	spec: {
		replicas: 1
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
					csi: {
						driver:   "secrets-store.csi.k8s.io"
						readOnly: true
						volumeAttributes: secretProviderClass: #Name
					}
				}]
				containers: [{
					name:  "operator"
					image: "tailscale/k8s-operator:unstable-v\(#Version)"
					env: [{
						name:  "OPERATOR_HOSTNAME"
						value: "tailscale-operator"
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
						value: "/oauth/client_id"
					}, {
						name:  "CLIENT_SECRET_FILE"
						value: "/oauth/client_secret"
					}, {
						name:  "PROXY_IMAGE"
						value: "tailscale/tailscale:v1.38.1"
					}, {
						name:  "PROXY_TAGS"
						value: "tag:k8s,tag:unwind"
					}, {
						name:  "AUTH_PROXY"
						value: "true"
					}]
					resources: requests: {
						cpu:    "500m"
						memory: "100Mi"
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
