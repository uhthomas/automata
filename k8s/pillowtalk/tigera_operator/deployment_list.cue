package tigera_operator

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
	// Source: tigera-operator/templates/tigera-operator/02-tigera-operator.yaml
	metadata: labels: "k8s-app": "tigera-operator"
	spec: {
		replicas: 1
		selector: matchLabels: name: "tigera-operator"
		template: {
			metadata: labels: {
				name:      "tigera-operator"
				"k8s-app": "tigera-operator"
			}
			spec: {
				nodeSelector: "kubernetes.io/os": "linux"
				tolerations: [{
					effect:   v1.#TaintEffectNoSchedule
					operator: v1.#LabelSelectorOpExists
				}, {
					effect:   v1.#TaintEffectNoSchedule
					operator: v1.#LabelSelectorOpExists
				}]
				serviceAccountName: "tigera-operator"
				hostNetwork:        true
				// This must be set when hostNetwork is true or else the cluster services won't resolve
				dnsPolicy: v1.#DNSClusterFirstWithHostNet
				containers: [{
					name:            "tigera-operator"
					image:           "quay.io/tigera/operator:v1.17.2@sha256:c90489c91dd6c98669d6b35b02a54ab2bcf56caed19a9f5a011c4eec05f63788"
					imagePullPolicy: v1.#PullIfNotPresent
					command: [
						"operator",
					]
					volumeMounts: [{
						name:      "var-lib-calico"
						readOnly:  true
						mountPath: "/var/lib/calico"
					}]
					env: [{
						name:  "WATCH_NAMESPACE"
						value: ""
					}, {
						name: "POD_NAME"
						valueFrom: fieldRef: fieldPath: "metadata.name"
					}, {
						name:  "OPERATOR_NAME"
						value: "tigera-operator"
					}, {
						name:  "TIGERA_OPERATOR_INIT_IMAGE_VERSION"
						value: "v1.17.2"
					}]
					envFrom: [{
						configMapRef: {
							name:     "kubernetes-services-endpoint"
							optional: true
						}
					}]
				}]
				volumes: [{
					name: "var-lib-calico"
					hostPath: path: "/var/lib/calico"
				}]
			}
		}
	}
}]
