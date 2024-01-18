package cilium

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
		name: "cilium-operator"
		labels: {
			"io.cilium/app":             "operator"
			name:                        "cilium-operator"
			"app.kubernetes.io/part-of": "cilium"
			"app.kubernetes.io/name":    "cilium-operator"
		}
	}
	spec: {
		selector: matchLabels: {
			"io.cilium/app": "operator"
			name:            "cilium-operator"
		}
		template: {
			metadata: labels: {
				"io.cilium/app":             "operator"
				name:                        "cilium-operator"
				"app.kubernetes.io/part-of": "cilium"
				"app.kubernetes.io/name":    "cilium-operator"
			}
			spec: {
				volumes: [{
					name: "cilium-config-path"
					configMap: name: "cilium-config"
				}]
				containers: [{
					name:  "cilium-operator"
					image: "quay.io/cilium/operator-generic:v1.14.6@sha256:2f0bf8fb8362c7379f3bf95036b90ad5b67378ed05cd8eb0410c1afc13423848"
					command: ["cilium-operator-generic"]
					args: ["--config-dir=/tmp/cilium/config-map", "--debug=$(CILIUM_DEBUG)"]
					env: [{
						name: "K8S_NODE_NAME"
						valueFrom: fieldRef: fieldPath: "spec.nodeName"
					}, {
						name: "CILIUM_K8S_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}, {
						name: "CILIUM_DEBUG"
						valueFrom: configMapKeyRef: {
							name:     "cilium-config"
							key:      "debug"
							optional: true
						}
					}, {
						name:  "KUBERNETES_SERVICE_HOST"
						value: "localhost"
					}, {
						name:  "KUBERNETES_SERVICE_PORT"
						value: "7445"
					}]
					volumeMounts: [{
						name:      "cilium-config-path"
						mountPath: "/tmp/cilium/config-map"
						readOnly:  true
					}]

					let probe = {
						httpGet: {
							host:   "127.0.0.1"
							path:   "/healthz"
							port:   9234
							scheme: "HTTP"
						}
						timeoutSeconds: 3
					}

					livenessProbe: probe & {
						initialDelaySeconds: 60
						periodSeconds:       10
					}
					readinessProbe: probe & {
						periodSeconds:    5
						failureThreshold: 5
					}

					terminationMessagePolicy: v1.#TerminationMessageFallbackToLogsOnError
					imagePullPolicy:          v1.#PullIfNotPresent
				}]
				nodeSelector: (v1.#LabelOSStable): v1.#Linux
				serviceAccountName: "cilium-operator"
				hostNetwork:        true
				affinity: podAntiAffinity: requiredDuringSchedulingIgnoredDuringExecution: [{
					labelSelector: matchLabels: "io.cilium/app": "operator"
					topologyKey: v1.#LabelHostname
				}]
				tolerations: [{operator: v1.#TolerationOpExists}]
				priorityClassName: "system-cluster-critical"
			}
		}
		strategy: rollingUpdate: maxUnavailable: "100%"
	}
}]
