package onepassword_secrets_injector

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
				// TODO: Remove.
				//
				// https://github.com/1Password/kubernetes-secrets-injector/pull/46
				volumes: [{
					name: "tmp"
					emptyDir: {}
				}]
				containers: [{
					name:  #Name
					image: "1password/kubernetes-secrets-injector:1.0.2@sha256:5884757f787937e1fad1efa5514ecdafe8e0edcd3c72d0f3fd6e7fd52d196274"
					args: [
						"-service-name=\(#Name)",
						"-logtostderr",
						"-v=4",
					]
					env: [{
						name: "POD_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}]
					ports: [{
						name:          "https"
						containerPort: 8443
					}]
					volumeMounts: [{
						name:      "tmp"
						mountPath: "/tmp"
					}]
					lifecycle: preStop: exec: command: ["/bin/sh", "-c", "/prestop.sh"]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
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
