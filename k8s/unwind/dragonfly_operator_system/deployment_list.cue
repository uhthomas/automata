package dragonfly_operator_system

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
		name: "\(#Name)-controller-manager"
		labels: "app.kubernetes.io/component": "controller-manager"
	}
	spec: {
		selector: matchLabels: {
			"app.kubernetes.io/name":      #Name
			"app.kubernetes.io/component": "controller-manager"
		}
		template: {
			metadata: {
				annotations: "kubectl.kubernetes.io/default-container": "manager"
				labels: {
					"app.kubernetes.io/name":      #Name
					"app.kubernetes.io/component": "controller-manager"
				}
			}
			spec: {
				containers: [{
					name:  "kube-rbac-proxy"
					image: "gcr.io/kubebuilder/kube-rbac-proxy:v0.13.1"
					args: [
						"--secure-listen-address=0.0.0.0:8443",
						"--upstream=http://127.0.0.1:8080/",
						"--logtostderr=true",
						"--v=0",
					]
					ports: [{
						name:          "https"
						containerPort: 8443
					}]
					resources: {
						limits: {
							cpu:    "500m"
							memory: "128Mi"
						}
						requests: {
							cpu:    "5m"
							memory: "64Mi"
						}
					}
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}, {
					name:  "manager"
					image: "docker.dragonflydb.io/dragonflydb/operator:v0.0.5"
					command: ["/manager"]
					args: [
						"--health-probe-bind-address=:8081",
						"--metrics-bind-address=127.0.0.1:8080",
						"--leader-elect",
					]
					livenessProbe: {
						httpGet: {
							path: "/healthz"
							port: 8081
						}
						initialDelaySeconds: 15
						periodSeconds:       20
					}
					readinessProbe: {
						httpGet: {
							path: "/readyz"
							port: 8081
						}
						initialDelaySeconds: 5
						periodSeconds:       10
					}
					resources: {
						limits: {
							cpu:    "500m"
							memory: "128Mi"
						}
						requests: {
							cpu:    "10m"
							memory: "64Mi"
						}
					}
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				terminationGracePeriodSeconds: 10
				serviceAccountName:            "\(#Name)-controller-manager"
				securityContext: {
					runAsUser:    1000
					runAsGroup:   3000
					runAsNonRoot: true
					fsGroup:      2000
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
				affinity: nodeAffinity: requiredDuringSchedulingIgnoredDuringExecution: nodeSelectorTerms: [{
					matchExpressions: [{
						key:      v1.#LabelArchStable
						operator: v1.#NodeSelectorOpIn
						values: ["amd64", "arm64", "ppc64le", "s390x"]
					}, {
						key:      v1.#LabelOSStable
						operator: v1.#NodeSelectorOpIn
						values: [v1.#Linux]
					}]
				}]
			}
		}
	}
}]
