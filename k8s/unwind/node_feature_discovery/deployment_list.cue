package node_feature_discovery

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
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
		name: "nfd-master"
		labels: app: "nfd"
	}
	spec: {
		replicas: 1
		selector: matchLabels: app: "nfd-master"
		template: {
			metadata: labels: app: "nfd-master"
			spec: {

				containers: [{
					name:  "nfd-master"
					image: "registry.k8s.io/nfd/node-feature-discovery:v\(#Version)"
					command: ["nfd-master"]
					env: [{
						name: "NODE_NAME"
						valueFrom: fieldRef: fieldPath: "spec.nodeName"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					livenessProbe: {
						exec: command: [
							"/usr/bin/grpc_health_probe",
							"-addr=:8080",
						]
						initialDelaySeconds: 10
						periodSeconds:       10
					}
					readinessProbe: {
						exec: command: [
							"/usr/bin/grpc_health_probe",
							"-addr=:8080",
						]
						failureThreshold:    10
						initialDelaySeconds: 5
						periodSeconds:       10
					}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
						runAsNonRoot:           true
					}
				}]
				serviceAccountName: "nfd-master"
				affinity: nodeAffinity: preferredDuringSchedulingIgnoredDuringExecution: [{
					preference: matchExpressions: [{
						key:      "node-role.kubernetes.io/master"
						operator: metav1.#LabelSelectorOpIn
						values: [""]
					}]
					weight: 1
				}, {
					preference: matchExpressions: [{
						key:      "node-role.kubernetes.io/control-plane"
						operator: metav1.#LabelSelectorOpIn
						values: [""]
					}]
					weight: 1
				}]
				tolerations: [{
					effect:   v1.#TaintEffectNoSchedule
					key:      "node-role.kubernetes.io/master"
					operator: v1.#TolerationOpEqual
					value:    ""
				}, {
					effect:   v1.#TaintEffectNoSchedule
					key:      "node-role.kubernetes.io/control-plane"
					operator: v1.#TolerationOpEqual
					value:    ""
				}]
			}
		}
	}
}]
