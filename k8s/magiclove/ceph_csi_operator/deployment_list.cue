package ceph_csi_operator

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
	metadata: name: "ceph-csi-operator-controller-manager"
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": "ceph-csi-operator-controller-manager"
		template: {
			metadata: labels: "app.kubernetes.io/name": "ceph-csi-operator-controller-manager"
			spec: {
				containers: [{
					name:  "manager"
					image: "quay.io/cephcsi/ceph-csi-operator:v\(#Version)"
					args: [
						"--leader-elect",
						"--metrics-bind-address=:8080",
						"--metrics-secure=false",
					]
					env: [{
						name: "OPERATOR_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}, {
						name:  "CSI_SERVICE_ACCOUNT_PREFIX"
						value: "ceph-csi-operator-"
					}, {
						name:  "WATCH_NAMESPACE"
						value: ""
					}]
					ports: [{
						name:          "http-metrics"
						containerPort: 8080
					}, {
						name:          "http-probe"
						containerPort: 8081
					}]

					let probe = {httpGet: port: "http-probe"}

					livenessProbe: probe & {
						httpGet: path: "/healthz"
						initialDelaySeconds: 15
						periodSeconds:       20
					}
					readinessProbe: probe & {
						httpGet: path: "/readyz"
						initialDelaySeconds: 5
						periodSeconds:       10
					}

					resources: limits: {
						cpu:    "500m"
						memory: "128Mi"
					}
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				serviceAccountName: "ceph-csi-operator-controller-manager"
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
