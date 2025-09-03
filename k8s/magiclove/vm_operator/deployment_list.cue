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
					name: "webhook-certs"
					secret: secretName: "\(#Name)-webhook-certificate"
				}]
				containers: [{
					name:  "manager"
					image: "victoriametrics/operator:v\(#Version)"
					args: [
						"--leader-elect",
						"--health-probe-bind-address=:8081",
						"--metrics-bind-address=:8080",
						"--webhook.enable",
						"--webhook.certDir=/tmp/k8s-webhook-server/serving-certs",
					]
					ports: [{
						name:          "http"
						containerPort: 8080
					}, {
						name:          "healthz"
						containerPort: 8081
					}, {
						name:          "https"
						containerPort: 9443
					}]
					env: [{
						name:  "WATCH_NAMESPACE"
						value: ""
					}, {
						name:  "VM_FILTERCHILDLABELPREFIXES"
						value: "applyset.kubernetes.io"
					}, {
						name:  "VM_ENABLEDPROMETHEUSCONVERTEROWNERREFERENCES"
						value: "true"
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "120m"
						(v1.#ResourceMemory): "520Mi"
					}

					let probe = {httpGet: port: "healthz"}

					livenessProbe: probe & {
						httpGet: path: "/health"
						initialDelaySeconds: 15
						periodSeconds:       20
					}
					readinessProbe: probe & {
						httpGet: path: "/ready"
						initialDelaySeconds: 5
						periodSeconds:       10
					}

					volumeMounts: [{
						name:      "webhook-certs"
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
