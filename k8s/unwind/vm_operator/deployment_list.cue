package vm_operator

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
				volumes: [{
					name: "certificate"
					secret: {
						secretName:  "\(#Name)-webhook-certificate"
						defaultMode: 0o420
					}
				}]
				containers: [{
					name:  "manager"
					image: "victoriametrics/operator:v\(#Version)"
					command: ["manager"]
					args: ["--enable-leader-election", "--webhook.enable"]
					ports: [{
						name:          "https"
						containerPort: 9443
					}]
					env: [{
						name:  "WATCH_NAMESPACE"
						value: ""
					}]
					resources: {
						limits: {
							cpu:    "120m"
							memory: "520Mi"
						}
						requests: {
							cpu:    "80m"
							memory: "120Mi"
						}
					}
					volumeMounts: [{
						name:      "certificate"
						mountPath: "/tmp/k8s-webhook-server/serving-certs"
						readOnly:  true
					}]
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
