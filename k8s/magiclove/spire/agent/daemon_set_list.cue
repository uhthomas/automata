package agent

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
)

#DaemonSetList: appsv1.#DaemonSetList & {
	apiVersion: "apps/v1"
	kind:       "DaemonSetList"
	items: [...{
		apiVersion: "apps/v1"
		kind:       "DaemonSet"
	}]
}

#DaemonSetList: items: [{
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata:
				labels: "app.kubernetes.io/name": #Name
			spec: {
				volumes: [{
					name: "spire-config"
					configMap: name: #Name
				}, {
					name: "spire-bundle"
					configMap: name: "spire-bundle"
				}, {
					name: "spire-agent-socket"
					hostPath: {
						path: "/run/spire/sockets"
						type: v1.#HostPathDirectoryOrCreate
					}
				}]
				containers: [{
					name:  "spire-agent"
					image: "ghcr.io/spiffe/spire-agent:\(#Version)"
					args: ["-config", "/run/spire/config/agent.conf"]
					ports: [{
						name:          "healthz"
						containerPort: 8080
					}]
					env: [{
						name: "MY_NODE_NAME"
						valueFrom: fieldRef: fieldPath: "status.hostIP"
					}]
					volumeMounts: [{
						name:      "spire-config"
						mountPath: "/run/spire/config"
						readOnly:  true
					}, {
						name:      "spire-bundle"
						mountPath: "/run/spire/bundle"
					}, {
						name:      "spire-agent-socket"
						mountPath: "/run/spire/sockets"
					}]
					livenessProbe: {
						httpGet: {
							path: "/live"
							port: "healthz"
						}
						failureThreshold:    2
						initialDelaySeconds: 15
						periodSeconds:       60
						timeoutSeconds:      3
					}
					readinessProbe: {
						httpGet: {
							path: "/ready"
							port: "healthz"
						}
						initialDelaySeconds: 5
						periodSeconds:       5
					}
					securityContext: privileged: true
				}]
				serviceAccountName: #Name
				hostPID:            true
			}
		}
	}
}]
