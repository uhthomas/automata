package kube_state_metrics

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
)

#StatefulSetList: appsv1.#StatefulSetList & {
	apiVersion: "apps/v1"
	kind:       "StatefulSetList"
	items: [...{
		apiVersion: "apps/v1"
		kind:       "StatefulSet"
	}]
}

#StatefulSetList: items: [{
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				containers: [{
					name:  #Name
					image: "registry.k8s.io/kube-state-metrics/kube-state-metrics:v\(#Version)"
					args: [
						"--pod=$(POD_NAME)",
						"--pod-namespace=$(POD_NAMESPACE)",
					]
					ports: [{
						name:          "http-metrics"
						containerPort: 8080
					}, {
						name:          "telemetry"
						containerPort: 8081
					}]
					env: [{
						name: "POD_NAME"
						valueFrom: fieldRef: fieldPath: "metadata.name"
					}, {
						name: "POD_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "50m"
						(v1.#ResourceMemory): "64Mi"
					}
					livenessProbe: {
						httpGet: {
							path: "/healthz"
							port: 8080
						}
						initialDelaySeconds: 5
						timeoutSeconds:      5
					}
					readinessProbe: {
						httpGet: {
							path: "/"
							port: 8081
						}
						initialDelaySeconds: 5
						timeoutSeconds:      5
					}
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				nodeSelector: (v1.#LabelOSStable): v1.#Linux
				serviceAccountName:           #Name
				automountServiceAccountToken: true
				securityContext: {
					runAsUser:    1000
					runAsGroup:   3000
					runAsNonRoot: true
					fsGroup:      2000
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
		serviceName: #Name
	}
}]
