package master

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
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				volumes: [{
					name: "conf"
					configMap: {
						name: #Name
						items: [{
							key:  "nfd-master.conf"
							path: "nfd-master.conf"
						}]
					}
				}]
				containers: [{
					name:  "master"
					image: "registry.k8s.io/nfd/node-feature-discovery:v\(#Version)"
					command: ["nfd-master"]
					ports: [{
						containerPort: 8080
						name:          "grpc"
					}, {
						containerPort: 8081
						name:          "http-metrics"
					}]
					env: [{
						name: "NODE_NAME"
						valueFrom: fieldRef: fieldPath: "spec.nodeName"
					}]
					volumeMounts: [{
						name:      "conf"
						mountPath: "/etc/kubernetes/node-feature-discovery"
						readOnly:  true
					}]

					let probe = {
						grpc: port: 8080
						periodSeconds: 10
					}

					livenessProbe: probe & {
						initialDelaySeconds: 10
					}
					readinessProbe: probe & {
						initialDelaySeconds: 5
						failureThreshold:    10
					}

					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				serviceAccountName: #Name
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
