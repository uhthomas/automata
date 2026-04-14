package kaniop

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
		revisionHistoryLimit: 3
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				serviceAccountName: #Name
				securityContext: {
					runAsUser:    65534
					runAsGroup:   65534
					runAsNonRoot: true
					fsGroup:      65534
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
				containers: [{
					name:            #Name
					image:           "ghcr.io/pando85/kaniop:\(#Version)"
					imagePullPolicy: v1.#PullIfNotPresent
					ports: [{
						name:          "metrics"
						containerPort: 8080
						protocol:      v1.#ProtocolTCP
					}]
					env: [{
						name:  "PORT"
						value: "8080"
					}, {
						name:  "LOG_FILTER"
						value: "info"
					}, {
						name:  "IDM_RECONCILE_INTERVAL_SECONDS"
						value: "60"
					}]
					readinessProbe: {
						httpGet: {
							path: "/healthz"
							port: "metrics"
						}
						periodSeconds:    10
						timeoutSeconds:   1
						successThreshold: 1
						failureThreshold: 3
					}
					livenessProbe: {
						httpGet: {
							path: "/healthz"
							port: "metrics"
						}
						periodSeconds:    10
						timeoutSeconds:   1
						successThreshold: 1
						failureThreshold: 3
					}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
					}
				}]
			}
		}
	}
}, {
	metadata: name: "\(#Name)-webhook"
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": "\(#Name)-webhook"
		template: {
			metadata: labels: "app.kubernetes.io/name": "\(#Name)-webhook"
			spec: {
				serviceAccountName: #Name
				securityContext: {
					runAsUser:    65534
					runAsGroup:   65534
					runAsNonRoot: true
					fsGroup:      65534
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
				volumes: [{
					name: "webhook-certs"
					secret: secretName: "\(#Name)-webhook-cert"
				}]
				containers: [{
					name:            "webhook"
					image:           "ghcr.io/pando85/kaniop-webhook:\(#Version)"
					imagePullPolicy: v1.#PullIfNotPresent
					command: ["kaniop-webhook"]
					ports: [{
						name:          "webhook"
						containerPort: 8443
						protocol:      v1.#ProtocolTCP
					}]
					env: [{
						name:  "PORT"
						value: "8443"
					}, {
						name:  "LOG_FILTER"
						value: "info"
					}, {
						name:  "TLS_CERT"
						value: "/etc/webhook/certs/tls.crt"
					}, {
						name:  "TLS_KEY"
						value: "/etc/webhook/certs/tls.key"
					}]
					readinessProbe: {
						httpGet: {
							path:   "/readyz"
							port:   "webhook"
							scheme: v1.#URISchemeHTTPS
						}
						periodSeconds:    2
						timeoutSeconds:   1
						successThreshold: 1
						failureThreshold: 2
					}
					livenessProbe: {
						httpGet: {
							path:   "/livez"
							port:   "webhook"
							scheme: v1.#URISchemeHTTPS
						}
						periodSeconds:    10
						timeoutSeconds:   1
						successThreshold: 1
						failureThreshold: 3
					}
					volumeMounts: [{
						name:      "webhook-certs"
						mountPath: "/etc/webhook/certs"
						readOnly:  true
					}]
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
					}
				}]
			}
		}
	}
}]
