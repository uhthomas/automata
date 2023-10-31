package onepassword_operator

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
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				containers: [{
					name:  "onepassword-operator"
					image: "1password/onepassword-operator:1.8.0@sha256:7ff622466ae375b5a35308b7cd96a9e26d14511666c540468c94e8e97102e7dd"
					env: [{
						name: "POD_NAME"
						valueFrom: fieldRef: fieldPath: "metadata.name"
					}, {
						name:  "OPERATOR_NAME"
						value: "onepassword-operator"
					}, {
						name:  "OP_CONNECT_HOST"
						value: "http://onepassword-connect.onepassword-connect:8080"
					}, {
						name:  "POLLING_INTERVAL"
						value: "600"
					}, {
						name: "OP_CONNECT_TOKEN"
						valueFrom: secretKeyRef: {
							name: "onepassword-connect-token"
							key:  "token"
						}
					}, {
						name:  "AUTO_RESTART"
						value: "false"
					}]
					ports: [{
						name:          "https"
						containerPort: 443
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				nodeSelector: (v1.#LabelOSStable): v1.#Linux
				serviceAccountName: #Name
				securityContext: {
					runAsUser:    1000
					runAsGroup:   3000
					runAsNonRoot: true
					fsGroup:      2000
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
	}
}]
