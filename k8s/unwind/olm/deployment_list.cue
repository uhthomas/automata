package olm

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
	metadata: {
		name:      "olm-operator"
		namespace: "olm"
		labels: app: "olm-operator"
	}
	spec: {
		strategy: type: "RollingUpdate"
		replicas: 1
		selector: matchLabels: app: "olm-operator"
		template: {
			metadata: labels: app: "olm-operator"
			spec: {
				securityContext: {
					runAsNonRoot: true
					seccompProfile: type: "RuntimeDefault"
				}
				serviceAccountName: "olm-operator-serviceaccount"
				containers: [{
					name: "olm-operator"
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
					}
					command: [
						"/bin/olm",
					]
					args: [
						"--namespace",
						"$(OPERATOR_NAMESPACE)",
						"--writeStatusName",
						"",
					]
					image:           "quay.io/operator-framework/olm@sha256:f9ea8cef95ac9b31021401d4863711a5eec904536b449724e0f00357548a31e7"
					imagePullPolicy: v1.#PullIfNotPresent
					ports: [{
						containerPort: 8080
						name:          "metrics"
					}]
					livenessProbe: httpGet: {
						path:   "/healthz"
						port:   8080
						scheme: "HTTP"
					}
					readinessProbe: httpGet: {
						path:   "/healthz"
						port:   8080
						scheme: "HTTP"
					}
					terminationMessagePolicy: "FallbackToLogsOnError"
					env: [{
						name: "OPERATOR_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}, {
						name:  "OPERATOR_NAME"
						value: "olm-operator"
					}]
					resources: requests: {
						cpu:    "10m"
						memory: "160Mi"
					}
				}]
				nodeSelector: "kubernetes.io/os": "linux"
			}
		}
	}
}, {
	metadata: {
		name:      "catalog-operator"
		namespace: "olm"
		labels: app: "catalog-operator"
	}
	spec: {
		strategy: type: "RollingUpdate"
		replicas: 1
		selector: matchLabels: app: "catalog-operator"
		template: {
			metadata: labels: app: "catalog-operator"
			spec: {
				securityContext: {
					runAsNonRoot: true
					seccompProfile: type: "RuntimeDefault"
				}
				serviceAccountName: "olm-operator-serviceaccount"
				containers: [{
					name: "catalog-operator"
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
					}
					command: [
						"/bin/catalog",
					]
					args: [
						"--namespace",
						"olm",
						"--configmapServerImage=quay.io/operator-framework/configmap-operator-registry:latest",
						"--util-image",
						"quay.io/operator-framework/olm@sha256:f9ea8cef95ac9b31021401d4863711a5eec904536b449724e0f00357548a31e7",
						"--set-workload-user-id=true",
					]
					image:           "quay.io/operator-framework/olm@sha256:f9ea8cef95ac9b31021401d4863711a5eec904536b449724e0f00357548a31e7"
					imagePullPolicy: v1.#PullIfNotPresent
					ports: [{
						containerPort: 8080
						name:          "metrics"
					}]
					livenessProbe: httpGet: {
						path:   "/healthz"
						port:   8080
						scheme: "HTTP"
					}
					readinessProbe: httpGet: {
						path:   "/healthz"
						port:   8080
						scheme: "HTTP"
					}
					terminationMessagePolicy: "FallbackToLogsOnError"
					resources: requests: {
						cpu:    "10m"
						memory: "80Mi"
					}
				}]
				nodeSelector: "kubernetes.io/os": "linux"
			}
		}
	}
}]
