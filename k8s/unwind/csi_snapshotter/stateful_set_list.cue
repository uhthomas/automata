package csi_snapshotter

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
)

#StatefulSetList: appsv1.#StatefulSetList & {
	apiVersion: "apps/v1"
	kind:       "StatefulSetList"
	items: [...{
		apiVersion: "apps/v1"
		kind:       "StatefulSet"
	}]
}

#StatefulSetList: items: [{
	spec: {
		replicas: 1
		selector: matchLabels: "app.kubernetes.io/name": #Name
		serviceName: #Name
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				volumes: [{
					name: "socket-dir"
					emptyDir: {}
				}]
				containers: [{
					name:  "csi-provisioner"
					image: "registry.k8s.io/sig-storage/csi-provisioner:v3.6.4"
					args: [
						"--v=5",
						"--csi-address=$(ADDRESS)",
					]
					env: [{
						name:  "ADDRESS"
						value: "/csi/csi.sock"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					volumeMounts: [{
						mountPath: "/csi"
						name:      "socket-dir"
					}]
				}, {
					name:  "csi-snapshotter"
					image: "registry.k8s.io/sig-storage/csi-snapshotter:v6.2.1"
					args: [
						"--v=5",
						"--csi-address=$(ADDRESS)",
						"--leader-election=false",
					]
					env: [{
						name:  "ADDRESS"
						value: "/csi/csi.sock"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					volumeMounts: [{
						mountPath: "/csi"
						name:      "socket-dir"
					}]
				}, {
					name:  "hostpath"
					image: "registry.k8s.io/sig-storage/hostpathplugin:v1.11.0"
					args: [
						"--v=5",
						"--endpoint=$(CSI_ENDPOINT)",
						"--nodeid=$(NODE_NAME)",
					]
					env: [{
						name:  "CSI_ENDPOINT"
						value: "unix:///csi/csi.sock"
					}, {
						name: "NODE_NAME"
						valueFrom: fieldRef: {
							apiVersion: "v1"
							fieldPath:  "spec.nodeName"
						}
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: privileged: true
					volumeMounts: [{
						mountPath: "/csi"
						name:      "socket-dir"
					}]
				}]
				serviceAccountName: "csi-snapshotter"
			}
		}
	}
}]
