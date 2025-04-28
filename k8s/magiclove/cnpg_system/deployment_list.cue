package cnpg_system

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
		name: "cnpg-controller-manager"
		labels: "app.kubernetes.io/name": #Name
	}
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				volumes: [{
					name: "scratch-data"
					emptyDir: {}
				}, {
					name: "webhook-certificates"
					secret: {
						defaultMode: 420
						optional:    true
						secretName:  "cnpg-webhook-cert"
					}
				}]
				containers: [{
					name:  "manager"
					image: "ghcr.io/cloudnative-pg/cloudnative-pg:1.25.1"
					command: ["/manager"]
					args: [
						"controller",
						"--leader-elect",
						"--max-concurrent-reconciles=10",
						"--config-map-name=cnpg-controller-manager-config",
						"--secret-name=cnpg-controller-manager-config",
						"--webhook-port=9443",
					]
					ports: [{
						name:          "metrics"
						containerPort: 8080
					}, {
						name:          "webhook-server"
						containerPort: 9443
					}]
					env: [{
						name:  "OPERATOR_IMAGE_NAME"
						value: "ghcr.io/cloudnative-pg/cloudnative-pg:1.25.1"
					}, {
						name: "OPERATOR_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}, {
						name:  "MONITORING_QUERIES_CONFIGMAP"
						value: "cnpg-default-monitoring"
					}]
					resources: limits: {
						cpu:    "100m"
						memory: "200Mi"
					}
					volumeMounts: [{
						mountPath: "/controller"
						name:      "scratch-data"
					}, {
						mountPath: "/run/secrets/cnpg.io/webhook"
						name:      "webhook-certificates"
					}]
					livenessProbe: httpGet: {
						path:   "/readyz"
						port:   9443
						scheme: "HTTPS"
					}
					readinessProbe: httpGet: {
						path:   "/readyz"
						port:   9443
						scheme: "HTTPS"
					}
					startupProbe: {
						failureThreshold: 6
						httpGet: {
							path:   "/readyz"
							port:   9443
							scheme: "HTTPS"
						}
						periodSeconds: 5
					}
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				securityContext: {
					runAsUser:           1000
					runAsGroup:          3000
					runAsNonRoot:        true
					fsGroup:             2000
					fsGroupChangePolicy: v1.#FSGroupChangeOnRootMismatch
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
				serviceAccountName:            "cnpg-manager"
				terminationGracePeriodSeconds: 10
			}
		}
	}
}]
