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
		replicas: 2
		selector: matchLabels: "app.kubernetes.io/name": #Name
		serviceName: #Name
		template: {
			metadata: labels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      #Name
				"app.kubernetes.io/version":   #Version
			}
			spec: {
				automountServiceAccountToken: true
				containers: [{
					name: #Name
					args: [
						"--pod=$(POD_NAME)",
						"--pod-namespace=$(POD_NAMESPACE)",
					]
					env: [{
						name: "POD_NAME"
						valueFrom: fieldRef: fieldPath: "metadata.name"
					}, {
						name: "POD_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}]
					image: "registry.k8s.io/kube-state-metrics/kube-state-metrics:v\(#Version)@sha256:ec5732e28f151de3847df60f48c5a570aacdb692ff1ce949d97105ae5e5a6722"
					livenessProbe: {
						httpGet: {
							path: "/healthz"
							port: 8080
						}
						initialDelaySeconds: 5
						timeoutSeconds:      5
					}
					ports: [{
						name:          "http-metrics"
						containerPort: 8080
					}, {
						name:          "telemetry"
						containerPort: 8081
					}]
					readinessProbe: {
						httpGet: {
							path: "/"
							port: 8081
						}
						initialDelaySeconds: 5
						timeoutSeconds:      5
					}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: [ "ALL"]
						readOnlyRootFilesystem: true
						runAsUser:              65534
					}
				}]
				nodeSelector: (v1.#LabelOSStable): v1.#Linux
				serviceAccountName: #Name
			}
		}
	}
}]
