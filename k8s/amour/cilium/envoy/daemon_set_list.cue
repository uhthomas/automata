package envoy

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
	metadata: {
		name: #Name
		labels: {
			"k8s-app":                   "cilium-envoy"
			"app.kubernetes.io/part-of": "cilium"
			"app.kubernetes.io/name":    "cilium-envoy"
			name:                        "cilium-envoy"
		}
	}
	spec: {
		selector: matchLabels: "k8s-app": "cilium-envoy"
		template: {
			metadata: {
				annotations: "container.apparmor.security.beta.kubernetes.io/cilium-envoy": "unconfined"
				labels: {
					"k8s-app":                   "cilium-envoy"
					name:                        "cilium-envoy"
					"app.kubernetes.io/name":    "cilium-envoy"
					"app.kubernetes.io/part-of": "cilium"
				}
			}
			spec: {
				volumes: [{
					name: "envoy-sockets"
					hostPath: {
						path: "/var/run/cilium/envoy/sockets"
						type: v1.#HostPathDirectoryOrCreate
					}
				}, {
					name: "envoy-artifacts"
					hostPath: {
						path: "/var/run/cilium/envoy/artifacts"
						type: v1.#HostPathDirectoryOrCreate
					}
				}, {
					name: "envoy-config"
					configMap: {
						name: "cilium-envoy-config"
						items: [{
							key: "bootstrap-config.json"
							// To keep state between restarts / upgrades
							// To keep state between restarts / upgrades for bpf maps
							path: "bootstrap-config.json"
						}]
						// note: the leading zero means this number is in octal representation: do not remove it
						defaultMode: 0o400
					}
				}, {
					name: "bpf-maps"
					hostPath: {
						path: "/sys/fs/bpf"
						type: v1.#HostPathDirectoryOrCreate
					}
				}]
				containers: [{
					name:  "cilium-envoy"
					image: "quay.io/cilium/cilium-envoy:v\(#Version)"
					command: ["/usr/bin/cilium-envoy-starter"]
					args: [
						"--",
						"-c /var/run/cilium/envoy/bootstrap-config.json",
						"--base-id 0",
						"--log-level info",
						"--log-format [%Y-%m-%d %T.%e][%t][%l][%n] [%g:%#] %v",
					]
					ports: [{
						name:          "envoy-metrics"
						containerPort: 9964
						hostPort:      9964
					}]
					env: [{
						name: "K8S_NODE_NAME"
						valueFrom: fieldRef: {
							apiVersion: "v1"
							fieldPath:  "spec.nodeName"
						}
					}, {
						name: "CILIUM_K8S_NAMESPACE"
						valueFrom: fieldRef: {
							apiVersion: "v1"
							fieldPath:  "metadata.namespace"
						}
					}, {
						name:  "KUBERNETES_SERVICE_HOST"
						value: "localhost"
					}, {
						name:  "KUBERNETES_SERVICE_PORT"
						value: "7445"
					}]
					volumeMounts: [{
						name:      "envoy-sockets"
						mountPath: "/var/run/cilium/envoy/sockets"
					}, {
						name:      "envoy-artifacts"
						mountPath: "/var/run/cilium/envoy/artifacts"
						readOnly:  true
					}, {
						name:      "envoy-config"
						mountPath: "/var/run/cilium/envoy/"
						readOnly:  true
					}, {
						name:             "bpf-maps"
						mountPath:        "/sys/fs/bpf"
						mountPropagation: v1.#MountPropagationHostToContainer
					}]

					let probe = {
						httpGet: {
							host: "127.0.0.1"
							path: "/healthz"
							port: 9878
						}
						successThreshold: 1
					}

					livenessProbe: probe & {
						periodSeconds:    30
						failureThreshold: 10
						timeoutSeconds:   5
					}
					readinessProbe: probe & {
						periodSeconds:    30
						failureThreshold: 3
						timeoutSeconds:   5
					}
					startupProbe: probe & {
						failureThreshold:    105
						periodSeconds:       2
						initialDelaySeconds: 5
					}

					terminationMessagePolicy: v1.#TerminationMessageFallbackToLogsOnError
					imagePullPolicy:          v1.#PullIfNotPresent
					securityContext: {
						seLinuxOptions: {
							type:  "spc_t"
							level: "s0"
						}
						capabilities: {
							add: ["NET_ADMIN", "SYS_ADMIN"]
							drop: ["ALL"]
						}
					}
				}]
				nodeSelector: (v1.#LabelOSStable): v1.#Linux
				serviceAccountName: #Name
				hostNetwork:        true
				affinity: {
					nodeAffinity: requiredDuringSchedulingIgnoredDuringExecution: nodeSelectorTerms: [{
						matchExpressions: [{
							key:      "cilium.io/no-schedule"
							operator: v1.#NodeSelectorOpNotIn
							values: ["true"]
						}]
					}]
					podAffinity: requiredDuringSchedulingIgnoredDuringExecution: [{
						labelSelector: matchLabels: "k8s-app": "cilium"
						topologyKey: v1.#LabelHostname
					}]
					podAntiAffinity: requiredDuringSchedulingIgnoredDuringExecution: [{
						labelSelector: matchLabels: "k8s-app": #Name
						topologyKey: v1.#LabelHostname
					}]
				}
				tolerations: [{operator: v1.#TolerationOpExists}]
				priorityClassName: "system-node-critical"
			}
		}
		updateStrategy: rollingUpdate: maxUnavailable: 2
	}
}]
