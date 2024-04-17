package hubble_ui

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
		name: "hubble-ui"
		labels: {
			"k8s-app":                   "hubble-ui"
			"app.kubernetes.io/name":    "hubble-ui"
			"app.kubernetes.io/part-of": "cilium"
		}
	}
	spec: {
		selector: matchLabels: "k8s-app": "hubble-ui"
		template: {
			metadata: labels: {
				"k8s-app":                   "hubble-ui"
				"app.kubernetes.io/name":    "hubble-ui"
				"app.kubernetes.io/part-of": "cilium"
			}
			spec: {
				volumes: [{
					name: "hubble-ui-nginx-conf"
					configMap: {
						name:        "hubble-ui-nginx"
						defaultMode: 420
					}
				}, {
					name: "tmp-dir"
					emptyDir: {}
				}, {
					name: "hubble-ui-client-certs"
					projected: {
						sources: [{
							secret: {
								name: "hubble-ui-client-certs"
								items: [{
									key:  "tls.crt"
									path: "client.crt"
								}, {
									key:  "tls.key"
									path: "client.key"
								}, {
									key:  "ca.crt"
									path: "hubble-relay-ca.crt"
								}]
							}
						}]
						defaultMode: 0o400
					}
				}]
				containers: [{
					name:  "frontend"
					image: "quay.io/cilium/hubble-ui:v\(#Version)"
					ports: [{
						name:          "http"
						containerPort: 8081
					}]
					volumeMounts: [{
						name:      "hubble-ui-nginx-conf"
						mountPath: "/etc/nginx/conf.d/default.conf"
						subPath:   "nginx.conf"
					}, {
						name:      "tmp-dir"
						mountPath: "/tmp"
					}]
					terminationMessagePolicy: v1.#TerminationMessageFallbackToLogsOnError
					imagePullPolicy:          v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}, {
					name:  "backend"
					image: "quay.io/cilium/hubble-ui-backend:v0.12.0@sha256:8a79a1aad4fc9c2aa2b3e4379af0af872a89fcec9d99e117188190671c66fc2e"
					env: [{
						name:  "EVENTS_SERVER_PORT"
						value: "8090"
					}, {
						name:  "FLOWS_API_ADDR"
						value: "hubble-relay:443"
					}, {
						name:  "TLS_TO_RELAY_ENABLED"
						value: "true"
					}, {
						name:  "TLS_RELAY_SERVER_NAME"
						value: "ui.hubble-relay.cilium.io"
					}, {
						name:  "TLS_RELAY_CA_CERT_FILES"
						value: "/var/lib/hubble-ui/certs/hubble-relay-ca.crt"
					}, {
						name:  "TLS_RELAY_CLIENT_CERT_FILE"
						value: "/var/lib/hubble-ui/certs/client.crt"
					}, {
						name:  "TLS_RELAY_CLIENT_KEY_FILE"
						value: "/var/lib/hubble-ui/certs/client.key"
					}]
					ports: [{
						name:          "grpc"
						containerPort: 8090
					}]
					volumeMounts: [{
						name:      "hubble-ui-client-certs"
						mountPath: "/var/lib/hubble-ui/certs"
						readOnly:  true
					}]
					terminationMessagePolicy: v1.#TerminationMessageFallbackToLogsOnError
					imagePullPolicy:          v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				nodeSelector: (v1.#LabelOSStable): v1.#Linux
				serviceAccountName: "hubble-ui"
				securityContext: {
					runAsUser:    1000
					runAsGroup:   3000
					runAsNonRoot: true
					fsGroup:             2000
					fsGroupChangePolicy: v1.#FSGroupChangeOnRootMismatch
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
		strategy: rollingUpdate: maxUnavailable: 1
	}
}]
