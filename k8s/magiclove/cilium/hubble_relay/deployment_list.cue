package hubble_relay

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
		name: "hubble-relay"
		labels: {
			"k8s-app":                   "hubble-relay"
			"app.kubernetes.io/name":    "hubble-relay"
			"app.kubernetes.io/part-of": "cilium"
		}
	}
	spec: {
		selector: matchLabels: "k8s-app": "hubble-relay"
		template: {
			metadata: {
				annotations: "kubectl.kubernetes.io/default-container": "cilium-agent"
				labels: {
					"k8s-app":                   "hubble-relay"
					"app.kubernetes.io/name":    "hubble-relay"
					"app.kubernetes.io/part-of": "cilium"
				}
			}
			spec: {
				volumes: [{
					name: "config"
					configMap: {
						name: "hubble-relay-config"
						items: [{
							key:  "config.yaml"
							path: "config.yaml"
						}]
					}
				}, {
					name: "tls"
					projected: {
						sources: [{
							secret: {
								name: "hubble-relay-client-certs"
								items: [{
									key:  "tls.crt"
									path: "client.crt"
								}, {
									key:  "tls.key"
									path: "client.key"
								}, {
									key:  "ca.crt"
									path: "hubble-server-ca.crt"
								}]
							}
						}, {
							secret: {
								name: "hubble-relay-server-certs"
								items: [{
									key:  "tls.crt"
									path: "server.crt"
								}, {
									key:  "tls.key"
									path: "server.key"
								}]
							}
						}]
						defaultMode: 0o400
					}
				}, {
					name: "config-tmp-dir"
					emptyDir: {}
				}]
				containers: [{
					name:  "hubble-relay"
					image: "quay.io/cilium/hubble-relay:v\(#Version)"
					command: ["hubble-relay"]
					args: ["serve"]
					ports: [{
						name:          "grpc"
						containerPort: 4245
					}]
					volumeMounts: [{
						name:      "config"
						mountPath: "/etc/hubble-relay"
						readOnly:  true
					}, {
						name:      "tls"
						mountPath: "/var/lib/hubble-relay/tls"
						readOnly:  true
					}, {
						name:      "config-tmp-dir"
						mountPath: "/.config"
					}]

					let probe = {grpc: port: 4222}

					readinessProbe: probe & {timeoutSeconds: 3}
					livenessProbe: probe & {
						timeoutSeconds:      10
						initialDelaySeconds: 10
						periodSeconds:       10
						failureThreshold:    12
					}
					startupProbe: probe & {
						initialDelaySeconds: 10
						failureThreshold:    20
						periodSeconds:       3
					}

					terminationMessagePolicy: v1.#TerminationMessageFallbackToLogsOnError
					imagePullPolicy:          v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						// readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				terminationGracePeriodSeconds: 1
				nodeSelector: (v1.#LabelOSStable): v1.#Linux
				serviceAccountName:           "hubble-relay"
				automountServiceAccountToken: false
				affinity: podAffinity: requiredDuringSchedulingIgnoredDuringExecution: [{
					labelSelector: matchLabels: "k8s-app": "cilium"
					topologyKey: v1.#LabelHostname
				}]
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
		strategy: rollingUpdate: maxUnavailable: 1
	}
}]
