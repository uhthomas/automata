package kubevirt

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
		name: "virt-operator"
		labels: "kubevirt.io": "virt-operator"
	}
	spec: {
		replicas: 2
		selector: matchLabels: "kubevirt.io": "virt-operator"
		template: {
			metadata: {
				name: "virt-operator"
				labels: {
					name:                     "virt-operator"
					"kubevirt.io":            "virt-operator"
					"prometheus.kubevirt.io": "true"
				}
			}
			spec: {
				volumes: [{
					name: "kubevirt-operator-certs"
					secret: {
						optional:   true
						secretName: "kubevirt-operator-certs"
					}
				}, {
					emptyDir: {}
					name: "profile-data"
				}]
				containers: [{
					name:  "virt-operator"
					image: "quay.io/kubevirt/virt-operator:v\(#Version)"
					command: ["virt-operator"]
					args: ["--port", "8443", "-v", "2"]
					ports: [{
						name:          "metrics"
						containerPort: 8443
					}, {
						name:          "webhooks"
						containerPort: 8444
					}]
					env: [{
						name:  "VIRT_OPERATOR_IMAGE"
						value: "quay.io/kubevirt/virt-operator:v0.59.0"
					}, {
						name: "WATCH_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.annotations['olm.targetNamespaces']"
					}, {
						name:  "KUBEVIRT_VERSION"
						value: "v\(#Version)"
					}]
					resources: requests: {
						cpu:    "10m"
						memory: "400Mi"
					}
					volumeMounts: [{
						name:      "kubevirt-operator-certs"
						mountPath: "/etc/virt-operator/certificates"
						readOnly:  true
					}, {
						name:      "profile-data"
						mountPath: "/profile-data"
					}]
					readinessProbe: {
						httpGet: {
							path:   "/metrics"
							port:   8443
							scheme: v1.#URISchemeHTTPS
						}
						initialDelaySeconds: 5
						timeoutSeconds:      10
					}
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				nodeSelector: (v1.#LabelOSStable): "linux"
				serviceAccountName: "kubevirt-operator"
				securityContext: {
					runAsUser:    1000
					runAsGroup:   3000
					runAsNonRoot: true
					fsGroup:      2000
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
				affinity: podAntiAffinity: preferredDuringSchedulingIgnoredDuringExecution: [{
					weight: 1
					podAffinityTerm: {
						labelSelector: matchExpressions: [{
							key:      "kubevirt.io"
							operator: v1.#NodeSelectorOpIn
							values: ["virt-operator"]
						}]
						topologyKey: v1.#LabelHostname
					}
				}]
				tolerations: [{
					key:      "CriticalAddonsOnly"
					operator: v1.#TolerationOpExists
				}]
				priorityClassName: "kubevirt-cluster-critical"
			}
		}
	}
}]
