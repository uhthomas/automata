package webhook

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
					name: "certs"
					secret: secretName: #Name
				}]
				containers: [{
					name:  "webhook"
					image: "ghcr.io/external-secrets/external-secrets:v0.9.5"
					args: [
						"webhook",
						"--port=10250",
						"--dns-name=\(#Name).\(#Namespace).svc",
						"--cert-dir=/var/webhook-certs",
						"--check-interval=5m",
						"--metrics-addr=:8080",
						"--healthz-addr=:8081",
						"--lookahead-interval=72h",
					]
					ports: [{
						name:          "http-metrics"
						containerPort: 8080
					}, {
						name:          "webhook"
						containerPort: 10250
					}]
					volumeMounts: [{
						name:      "certs"
						mountPath: "/var/webhook-certs"
						readOnly:  true
					}]
					readinessProbe: httpGet: {
						port: 8081
						path: "/readyz"
					}
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
