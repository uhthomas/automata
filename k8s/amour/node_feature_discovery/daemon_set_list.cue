package node_feature_discovery

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
		name: "nfd-worker"
		labels: "app.kubernetes.io/component": "worker"
	}
	spec: {
		selector: matchLabels: {
			"app.kubernetes.io/name":      #Name
			"app.kubernetes.io/component": "worker"
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      #Name
				"app.kubernetes.io/component": "worker"
			}
			spec: {
				volumes: [{
					hostPath: path: "/boot"
					name: "host-boot"
				}, {
					hostPath: path: "/etc/os-release"
					name: "host-os-release"
				}, {
					hostPath: path: "/sys"
					name: "host-sys"
				}, {
					hostPath: path: "/usr/lib"
					name: "host-usr-lib"
				}, {
					hostPath: path: "/etc/kubernetes/node-feature-discovery/source.d/"
					name: "source-d"
				}, {
					hostPath: path: "/etc/kubernetes/node-feature-discovery/features.d/"
					name: "features-d"
				}, {
					configMap: name: "nfd-worker-conf"
					name: "nfd-worker-conf"
				}]
				containers: [{
					name:  "nfd-worker"
					image: "registry.k8s.io/nfd/node-feature-discovery:v\(#Version)"
					command: ["nfd-worker"]
					args: ["-server=nfd-master:8080"]
					env: [{
						name: "NODE_NAME"
						valueFrom: fieldRef: fieldPath: "spec.nodeName"
					}]
					volumeMounts: [{
						mountPath: "/host-boot"
						name:      "host-boot"
						readOnly:  true
					}, {
						mountPath: "/host-etc/os-release"
						name:      "host-os-release"
						readOnly:  true
					}, {
						mountPath: "/host-sys"
						name:      "host-sys"
						readOnly:  true
					}, {
						mountPath: "/host-usr/lib"
						name:      "host-usr-lib"
						readOnly:  true
					}, {
						mountPath: "/etc/kubernetes/node-feature-discovery/source.d/"
						name:      "source-d"
						readOnly:  true
					}, {
						mountPath: "/etc/kubernetes/node-feature-discovery/features.d/"
						name:      "features-d"
						readOnly:  true
					}, {
						mountPath: "/etc/kubernetes/node-feature-discovery"
						name:      "nfd-worker-conf"
						readOnly:  true
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				serviceAccountName: "nfd-worker"
				dnsPolicy:          v1.#DNSClusterFirstWithHostNet
				securityContext: {
					runAsUser:    1000
					runAsGroup:   3000
					runAsNonRoot: true
					fsGroup:      2000
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
	}
}]
