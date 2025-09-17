package spegel

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
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				volumes: [{
					name: "containerd-sock"
					hostPath: {
						path: "/run/containerd/containerd.sock"
						type: v1.#HostPathSocket
					}
				}, {
					name: "containerd-content"
					hostPath: {
						path: "/var/lib/containerd/io.containerd.content.v1.content"
						type: v1.#HostPathDirectory
					}
				}, {
					name: "containerd-config"
					hostPath: {
						path: "/etc/cri/conf.d/hosts"
						type: v1.#HostPathDirectoryOrCreate
					}
				}]
				initContainers: [{
					name:  "config"
					image: _image.reference
					args: [
						"configuration",
						"--log-level=INFO",
						"--containerd-registry-config-path=/etc/cri/conf.d/hosts",
						"--mirror-targets",
						"http://$(NODE_IP):30020",
						"--resolve-tags=true",
						"--prepend-existing=false",
					]
					env: [{
						name: "NODE_IP"
						valueFrom: fieldRef: fieldPath: "status.hostIP"
					}]
					resources: limits: {
						cpu:    "100m"
						memory: "128Mi"
					}
					volumeMounts: [{
						name:      "containerd-config"
						mountPath: "/etc/cri/conf.d/hosts"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				containers: [{
					name:  "spegel"
					image: _image.reference
					args: [
						"registry",
						"--log-level=INFO",
						"--mirror-resolve-retries=3",
						"--mirror-resolve-timeout=20ms",
						"--registry-addr=:5000",
						"--router-addr=:5001",
						"--metrics-addr=:9090",
						"--containerd-sock=/run/containerd/containerd.sock",
						"--containerd-namespace=k8s.io",
						"--containerd-registry-config-path=/etc/cri/conf.d/hosts",
						"--bootstrap-kind=dns",
						"--dns-bootstrap-domain=\(#Name)-bootstrap.\(#Namespace).svc.cluster.local.",
						"--resolve-latest-tag=true",
						"--containerd-content-path=/var/lib/containerd/io.containerd.content.v1.content",
						"--debug-web-enabled=true",
					]
					env: [{
						name:  "DATA_DIR"
						value: ""
					}, {
						name: "NODE_IP"
						valueFrom: fieldRef: fieldPath: "status.hostIP"
					}, {
						name: "GOMEMLIMIT"
						valueFrom: resourceFieldRef: {
							resource: "limits.memory"
							divisor:  1
						}
					}]
					ports: [{
						name:          "registry"
						containerPort: 5000
					}, {
						name:          "router"
						containerPort: 5001
					}, {
						name:          "metrics"
						containerPort: 9090
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "300m"
						(v1.#ResourceMemory): "128Mi"
					}
					volumeMounts: [{
						name:      "containerd-sock"
						mountPath: "/run/containerd/containerd.sock"
					}, {
						name:      "containerd-content"
						mountPath: "/var/lib/containerd/io.containerd.content.v1.content"
						readOnly:  true
					}]

					let probe = {
						httpGet: {
							path: "/readyz"
							port: "registry"
						}
					}

					livenessProbe:  probe
					readinessProbe: probe
					startupProbe: probe & {
						periodSeconds:    3
						failureThreshold: 60
					}

					imagePullPolicy: v1.#PullIfNotPresent
					// securityContext: {
					// 	capabilities: drop: ["ALL"]
					// 	readOnlyRootFilesystem:   true
					// 	allowPrivilegeEscalation: false
					// }
					securityContext: readOnlyRootFilesystem: true
				}]
				// securityContext: {
				// 	runAsUser:    1000
				// 	runAsGroup:   3000
				// 	runAsNonRoot: true
				// 	fsGroup:      2000
				// 	seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				// }
				tolerations: [{
					key:      "CriticalAddonsOnly"
					operator: v1.#TolerationOpExists
				}, {
					operator: v1.#TolerationOpExists
					effect:   v1.#TaintEffectNoExecute
				}, {
					operator: v1.#TolerationOpExists
					effect:   v1.#TaintEffectNoSchedule
				}]
			}
		}
	}
}]
