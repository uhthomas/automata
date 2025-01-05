package worker

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
					name: "host-boot"
					hostPath: path: "/boot"
				}, {
					name: "host-os-release"
					hostPath: path: "/etc/os-release"
				}, {
					name: "host-sys"
					hostPath: path: "/sys"
				}, {
					name: "host-usr-lib"
					hostPath: path: "/usr/lib"
				}, {
					name: "host-lib"
					hostPath: path: "/lib"
				}, {
					name: "source-d"
					hostPath: path: "/etc/kubernetes/node-feature-discovery/source.d/"
				}, {
					name: "features-d"
					hostPath: path: "/etc/kubernetes/node-feature-discovery/features.d/"
				}, {
					name: "conf"
					configMap: {
						name: #Name
						items: [{
							key:  "nfd-worker.conf"
							path: "nfd-worker.conf"
						}]
					}
				}]
				containers: [{
					name:  "worker"
					image: "registry.k8s.io/nfd/node-feature-discovery:v\(#Version)"
					command: ["nfd-worker"]
					ports: [{
						name:          "http-metrics"
						containerPort: 8081
					}]
					env: [{
						name: "NODE_NAME"
						valueFrom: fieldRef: fieldPath: "spec.nodeName"
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "50m"
						(v1.#ResourceMemory): "64Mi"
					}
					volumeMounts: [{
						name:      "host-boot"
						mountPath: "/host-boot"
						readOnly:  true
					}, {
						name:      "host-os-release"
						mountPath: "/host-etc/os-release"
						readOnly:  true
					}, {
						name:      "host-sys"
						mountPath: "/host-sys"
						readOnly:  true
					}, {
						name:      "host-usr-lib"
						mountPath: "/host-usr/lib"
						readOnly:  true
					}, {
						name:      "host-lib"
						mountPath: "/host-lib"
						readOnly:  true
					}, {
						name:      "source-d"
						mountPath: "/etc/kubernetes/node-feature-discovery/source.d/"
						readOnly:  true
					}, {
						name:      "features-d"
						mountPath: "/etc/kubernetes/node-feature-discovery/features.d/"
						readOnly:  true
					}, {
						name:      "conf"
						mountPath: "/etc/kubernetes/node-feature-discovery"
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
				dnsPolicy:          v1.#DNSClusterFirstWithHostNet
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
