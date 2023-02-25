package tailscale

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
)

deploymentList: appsv1.#DeploymentList & {
	apiVersion: "apps/v1"
	kind:       "DeploymentList"
	items: [...{
		apiVersion: "apps/v1"
		kind:       "Deployment"
	}]
}

deploymentList: items: [{
	metadata: name: "operator"
	spec: {
		replicas: 1
		strategy: type: "Recreate"
		selector: matchLabels: app: "operator"
		template: {
			metadata: labels: app: "operator"
			spec: {
				serviceAccountName: "operator"
				volumes: [{
					name: "oauth"
					secret: secretName: "operator-oauth"
				}]
				containers: [{
					name:            "operator"
					image:           "tailscale/k8s-operator:unstable"
					imagePullPolicy: v1.#PullIfNotPresent
					resources: requests: {
						cpu:    "500m"
						memory: "100Mi"
					}
					env: [{
						name:  "OPERATOR_HOSTNAME"
						value: "tailscale-operator"
					}, {
						name:  "OPERATOR_SECRET"
						value: "operator"
					}, {
						name:  "OPERATOR_LOGGING"
						value: "info"
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
						value: "tailscale/tailscale:unstable"
					}, {
						name:  "PROXY_TAGS"
						value: "tag:k8s"
					}, {
						name:  "AUTH_PROXY"
						value: "true"
					}]
					volumeMounts: [{
						name:      "oauth"
						mountPath: "/oauth"
						readOnly:  true
					}]
				}]
			}
		}
	}
}]
