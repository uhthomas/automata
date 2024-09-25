package cilium

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
		name: "cilium"
		labels: {
			"k8s-app":                   "cilium"
			"app.kubernetes.io/part-of": "cilium"
			"app.kubernetes.io/name":    "cilium-agent"
		}
	}
	spec: {
		selector: matchLabels: "k8s-app": "cilium"
		template: {
			metadata: {
				annotations: {
					"container.apparmor.security.beta.kubernetes.io/cilium-agent":       "unconfined"
					"container.apparmor.security.beta.kubernetes.io/clean-cilium-state": "unconfined"
				}
				labels: {
					"k8s-app":                   "cilium"
					"app.kubernetes.io/name":    "cilium-agent"
					"app.kubernetes.io/part-of": "cilium"
				}
			}
			spec: {
				volumes: [{
					// For sharing configuration between the "config" initContainer and the agent
					name: "tmp"
					emptyDir: {}
				}, {
					// To keep state between restarts / upgrades
					name: "cilium-run"
					hostPath: {
						path: "/var/run/cilium"
						type: v1.#HostPathDirectoryOrCreate
					}
				}, {
					// To keep state between restarts / upgrades for bpf maps
					name: "bpf-maps"
					hostPath: {
						path: "/sys/fs/bpf"
						type: v1.#HostPathDirectoryOrCreate
					}
				}, {
					// To mount cgroup2 filesystem on the host or apply sysctlfix
					name: "hostproc"
					hostPath: {
						path: "/proc"
						type: v1.#HostPathDirectory
					}
				}, {
					// To keep state between restarts / upgrades for cgroup2 filesystem
					name: "cilium-cgroup"
					hostPath: {
						path: "/sys/fs/cgroup"
						type: v1.#HostPathDirectoryOrCreate
					}
				}, {
					// To install cilium cni plugin in the host
					name: "cni-path"
					hostPath: {
						path: "/opt/cni/bin"
						type: v1.#HostPathDirectoryOrCreate
					}
				}, {
					// To install cilium cni configuration in the host
					name: "etc-cni-netd"
					hostPath: {
						path: "/etc/cni/net.d"
						type: v1.#HostPathDirectoryOrCreate
					}
				}, {
					// To be able to load kernel modules
					name: "lib-modules"
					hostPath: path: "/lib/modules"
				}, {
					// To access iptables concurrently with other processes (e.g. kube-proxy)
					name: "xtables-lock"
					hostPath: {
						path: "/run/xtables.lock"
						type: v1.#HostPathFileOrCreate
					}
				}, {
					// Sharing socket with Cilium Envoy on the same node by using a host path
					name: "envoy-sockets"
					hostPath: {
						path: "/var/run/cilium/envoy/sockets"
						// To read the clustermesh configuration
						type: v1.#HostPathDirectoryOrCreate
					}
				}, {
					// To read the clustermesh configuration
					name: "clustermesh-secrets"
					projected: {
						sources: [{
							secret: {
								name:     "cilium-clustermesh"
								optional: true
							}
						}, {
							// note: items are not explicitly listed here, since the entries of this secret
							// depend on the peers configured, and that would cause a restart of all agents
							// at every addition/removal. Leaving the field empty makes each secret entry
							// to be automatically projected into the volume as a file whose name is the key.
							secret: {
								name: "clustermesh-apiserver-remote-cert"
								items: [{
									key:  "tls.key"
									path: "common-etcd-client.key"
								}, {
									key:  "tls.crt"
									path: "common-etcd-client.crt"
								}, {
									key:  "ca.crt"
									path: "common-etcd-client-ca.crt"
								}]
								optional: true
							}
						}, {
							// note: we configure the volume for the kvstoremesh-specific certificate
							// regardless of whether KVStoreMesh is enabled or not, so that it can be
							// automatically mounted in case KVStoreMesh gets subsequently enabled,
							// without requiring an agent restart.
							secret: {
								name: "clustermesh-apiserver-local-cert"
								items: [{
									key:  "tls.key"
									path: "local-etcd-client.key"
								}, {
									key:  "tls.crt"
									path: "local-etcd-client.crt"
								}, {
									key:  "ca.crt"
									path: "local-etcd-client-ca.crt"
								}]
								optional: true
							}
						}]
						defaultMode: 0o400
					}
				}, {
					name: "host-proc-sys-net"
					hostPath: {
						path: "/proc/sys/net"
						type: v1.#HostPathDirectory
					}
				}, {
					name: "host-proc-sys-kernel"
					hostPath: {
						path: "/proc/sys/kernel"
						type: v1.#HostPathDirectory
					}
				}, {
					name: "hubble-tls"
					projected: {
						sources: [{
							secret: {
								name:     "hubble-server-certs"
								optional: true
								items: [{
									key:  "tls.crt"
									path: "server.crt"
								}, {
									key:  "tls.key"
									path: "server.key"
								}, {
									key:  "ca.crt"
									path: "client-ca.crt"
								}]
							}
						}]
						defaultMode: 0o400
					}
				}]
				containers: [{
					name:  "cilium-agent"
					image: "quay.io/cilium/cilium:v\(#Version)"
					command: ["cilium-agent"]
					args: ["--config-dir=/tmp/cilium/config-map"]
					env: [{
						name: "K8S_NODE_NAME"
						valueFrom: fieldRef: fieldPath: "spec.nodeName"
					}, {
						name: "CILIUM_K8S_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}, {
						name:  "CILIUM_CLUSTERMESH_CONFIG"
						value: "/var/lib/cilium/clustermesh/"
					}, {
						name: "GOMEMLIMIT"
						valueFrom: resourceFieldRef: resource: "limits.memory"
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
						name:      "host-proc-sys-net"
						mountPath: "/host/proc/sys/net"
					}, {
						mountPath: "/host/proc/sys/kernel"
						name:      "host-proc-sys-kernel"
					}, {
						name:             "bpf-maps"
						mountPath:        "/sys/fs/bpf"
						mountPropagation: v1.#MountPropagationHostToContainer
					}, {
						name:      "cilium-cgroup"
						mountPath: "/sys/fs/cgroup"
					}, {
						name:      "cilium-run"
						mountPath: "/var/run/cilium"
					}, {
						name:      "etc-cni-netd"
						mountPath: "/host/etc/cni/net.d"
					}, {
						name:      "clustermesh-secrets"
						mountPath: "/var/lib/cilium/clustermesh"
						readOnly:  true
					}, {
						name:      "lib-modules"
						mountPath: "/lib/modules"
						readOnly:  true
					}, {
						name:      "xtables-lock"
						mountPath: "/run/xtables.lock"
					}, {
						name:      "hubble-tls"
						mountPath: "/var/lib/cilium/tls/hubble"
						readOnly:  true
					}, {
						name:      "tmp"
						mountPath: "/tmp"
					}]

					let probe = {
						httpGet: {
							host: "127.0.0.1"
							path: "/healthz"
							port: 9879
							httpHeaders: [{
								name:  "brief"
								value: "true"
							}]
						}
						successThreshold: 1
					}

					livenessProbe: probe & {
						periodSeconds:    30
						failureThreshold: 10
						timeoutSeconds:   5
					}
					readinessProbe: probe & {
						periodSeconds:       30
						failureThreshold:    3
						timeoutSeconds:      5
						initialDelaySeconds: 5
					}
					startupProbe: probe & {
						failureThreshold: 105
						periodSeconds:    2
					}

					lifecycle: {
						postStart: exec: command: [
							"bash",
							"-c",
							"""
							set -o errexit
							set -o pipefail
							set -o nounset

							# When running in AWS ENI mode, it's likely that 'aws-node' has
							# had a chance to install SNAT iptables rules. These can result
							# in dropped traffic, so we should attempt to remove them.
							# We do it using a 'postStart' hook since this may need to run
							# for nodes which might have already been init'ed but may still
							# have dangling rules. This is safe because there are no
							# dependencies on anything that is part of the startup script
							# itself, and can be safely run multiple times per node (e.g. in
							# case of a restart).
							if [[ "$(iptables-save | grep -E -c 'AWS-SNAT-CHAIN|AWS-CONNMARK-CHAIN')" != "0" ]];
							then
							echo 'Deleting iptables rules created by the AWS CNI VPC plugin'
							iptables-save | grep -E -v 'AWS-SNAT-CHAIN|AWS-CONNMARK-CHAIN' | iptables-restore
							fi
							echo 'Done!'

							""",
						]
						preStop: exec: command: ["/cni-uninstall.sh"]
					}
					terminationMessagePolicy: v1.#TerminationMessageFallbackToLogsOnError
					imagePullPolicy:          v1.#PullIfNotPresent
					securityContext: {
						seLinuxOptions: {
							type:  "spc_t"
							level: "s0"
						}
						capabilities: {
							add: ["CHOWN", "KILL", "NET_ADMIN", "NET_RAW", "IPC_LOCK", "SYS_ADMIN", "SYS_RESOURCE", "DAC_OVERRIDE", "FOWNER", "SETGID", "SETUID"]
							drop: ["ALL"]
						}
					}
				}]
				initContainers: [{
					name:  "config"
					image: "quay.io/cilium/cilium:v\(#Version)"
					command: ["cilium-dbg", "build-config"]
					env: [{
						name: "K8S_NODE_NAME"
						valueFrom: fieldRef: fieldPath: "spec.nodeName"
					}, {
						name: "CILIUM_K8S_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}, {
						name:  "KUBERNETES_SERVICE_HOST"
						value: "localhost"
					}, {
						name:  "KUBERNETES_SERVICE_PORT"
						value: "7445"
					}]
					volumeMounts: [{
						name:      "tmp"
						mountPath: "/tmp"
					}]
					terminationMessagePolicy: v1.#TerminationMessageFallbackToLogsOnError
					imagePullPolicy:          v1.#PullIfNotPresent
				}, {
					name:  "apply-sysctl-overwrites"
					image: "quay.io/cilium/cilium:v\(#Version)"
					command: [
						"sh",
						"-ec",
						// The statically linked Go program binary is invoked to avoid any
						// dependency on utilities like sh that can be missing on certain
						// distros installed on the underlying host. Copy the binary to the
						// same directory where we install cilium cni plugin so that exec permissions
						// are available.
						"""
						cp /usr/bin/cilium-sysctlfix /hostbin/cilium-sysctlfix;
						nsenter --mount=/hostproc/1/ns/mnt "${BIN_PATH}/cilium-sysctlfix";
						rm /hostbin/cilium-sysctlfix

						""",
					]
					env: [{
						name:  "BIN_PATH"
						value: "/opt/cni/bin"
					}]
					volumeMounts: [{
						name:      "hostproc"
						mountPath: "/hostproc"
					}, {
						name:      "cni-path"
						mountPath: "/hostbin"
					}]
					terminationMessagePolicy: v1.#TerminationMessageFallbackToLogsOnError
					imagePullPolicy:          v1.#PullIfNotPresent
					securityContext: {
						capabilities: {
							add: ["SYS_ADMIN", "SYS_CHROOT", "SYS_PTRACE"]
							drop: ["ALL"]
						}
						seLinuxOptions: {
							type:  "spc_t"
							level: "s0"
						}
					}
				}, {
					name:  "mount-bpf-fs"
					image: "quay.io/cilium/cilium:v\(#Version)"
					args: ["mount | grep \"/sys/fs/bpf type bpf\" || mount -t bpf bpf /sys/fs/bpf"]
					command: ["/bin/bash", "-c", "--"]
					volumeMounts: [{
						name:             "bpf-maps"
						mountPath:        "/sys/fs/bpf"
						mountPropagation: v1.#MountPropagationBidirectional
					}]
					terminationMessagePolicy: v1.#TerminationMessageFallbackToLogsOnError
					imagePullPolicy:          v1.#PullIfNotPresent
					securityContext: privileged: true
				}, {
					name:  "clean-cilium-state"
					image: "quay.io/cilium/cilium:v\(#Version)"
					command: ["/init-container.sh"]
					env: [{
						name: "CILIUM_ALL_STATE"
						valueFrom: configMapKeyRef: {
							name:     "cilium-config"
							key:      "clean-cilium-state"
							optional: true
						}
					}, {
						name: "CILIUM_BPF_STATE"
						valueFrom: configMapKeyRef: {
							name:     "cilium-config"
							key:      "clean-cilium-bpf-state"
							optional: true
						}
					}, {
						name: "WRITE_CNI_CONF_WHEN_READY"
						valueFrom: configMapKeyRef: {
							name:     "cilium-config"
							key:      "write-cni-conf-when-ready"
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
						name:      "bpf-maps"
						mountPath: "/sys/fs/bpf"
					}, {
						name:             "cilium-cgroup"
						mountPath:        "/sys/fs/cgroup"
						mountPropagation: v1.#MountPropagationHostToContainer
					}, {
						name:      "cilium-run"
						mountPath: "/var/run/cilium"
					}]
					terminationMessagePolicy: v1.#TerminationMessageFallbackToLogsOnError
					imagePullPolicy:          v1.#PullIfNotPresent
					securityContext: {
						seLinuxOptions: {
							type:  "spc_t"
							level: "s0"
						}
						capabilities: {
							add: ["NET_ADMIN", "SYS_ADMIN", "SYS_RESOURCE"]
							drop: ["ALL"]
						}
					}
				}, {
					name:  "install-cni-binaries"
					image: "quay.io/cilium/cilium:v\(#Version)"
					command: ["/install-plugin.sh"]
					resources: requests: {
						(v1.#ResourceCPU):    "100m"
						(v1.#ResourceMemory): "10Mi"
					}
					volumeMounts: [{
						name:      "cni-path"
						mountPath: "/host/opt/cni/bin"
					}]
					terminationMessagePolicy: v1.#TerminationMessageFallbackToLogsOnError
					imagePullPolicy:          v1.#PullIfNotPresent
					securityContext: {
						seLinuxOptions: {
							type:  "spc_t"
							level: "s0"
						}
						capabilities: drop: ["ALL"]
					}
				}]
				terminationGracePeriodSeconds: 1
				nodeSelector: (v1.#LabelOSStable): v1.#Linux
				serviceAccountName: "cilium"
				hostNetwork:        true
				affinity: podAntiAffinity: requiredDuringSchedulingIgnoredDuringExecution: [{
					labelSelector: matchLabels: "k8s-app": "cilium"
					topologyKey: v1.#LabelHostname
				}]
				tolerations: [{operator: v1.#TolerationOpExists}]
				priorityClassName: "system-node-critical"
			}
		}
		updateStrategy: rollingUpdate: maxUnavailable: 2
	}
}]
