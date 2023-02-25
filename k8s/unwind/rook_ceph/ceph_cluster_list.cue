package rook_ceph

import "k8s.io/api/core/v1"

cephClusterList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "ceph.rook.io/v1"
		kind:       "CephCluster"
	}]
}

cephClusterList: items: [{
	spec: {
		cephVersion: {
			image:            "quay.io/ceph/ceph:v17.2.5"
			allowUnsupported: false
		}
		dataDirHostPath:                            "/var/lib/rook"
		skipUpgradeChecks:                          false
		continueUpgradeAfterChecksEvenIfNotHealthy: false
		waitTimeoutForHealthyOSDInMinutes:          10
		mon: {
			count:                5
			allowMultiplePerNode: false
		}
		mgr: {
			count:                2
			allowMultiplePerNode: false
			modules: [{
				name:    "pg_autoscaler"
				enabled: true
			}]
		}
		dashboard: {
			enabled: true
			ssl:     false
		}
		// enable prometheus alerting for cluster
		monitoring: enabled: false
		network: connections: {
			encryption: enabled:  false
			compression: enabled: true
			requireMsgr2: false
		}
		crashCollector: disable: false
		logCollector: {
			enabled:     true
			periodicity: "daily"
			maxLogSize:  "500M"
		}
		cleanupPolicy: {
			// Since cluster cleanup is destructive to data, confirmation is required.
			// To destroy all Rook data on hosts during uninstall, confirmation must be set to "yes-really-destroy-data".
			// This value should only be set when the cluster is about to be deleted. After the confirmation is set,
			// Rook will immediately stop configuring the cluster and only wait for the delete command.
			// If the empty string is set, Rook will not destroy any data on hosts during uninstall.
			confirmation: ""
			sanitizeDisks: {
				method:     "quick"
				dataSource: "zero"
				iteration:  1
			}
			// allowUninstallWithVolumes defines how the uninstall should be performed
			// If set to true, cephCluster deletion does not wait for the PVs to be deleted.
			allowUninstallWithVolumes: false
		}
		removeOSDsIfOutAndSafeToRemove: false
		priorityClassNames: {
			mon: "system-node-critical"
			osd: "system-node-critical"
			mgr: "system-cluster-critical"
		}
		storage: {
			useAllNodes:   false
			useAllDevices: false
			nodes: [{
				name: "talos-6xb-myy"
				devices: [
					// HGST H7280A520SUN8.0T
					{name: "/dev/disk/by-id/wwn-0x5000cca23b43d9ec"},
					// HGST H7280A520SUN8.0T
					{name: "/dev/disk/by-id/wwn-0x5000cca23b30dca4"},
				]
			}, {
				name: "talos-8op-x2k"
				devices: [
					// HGST H7280A520SUN8.0T
					{name: "/dev/disk/by-id/wwn-0x5000cca23b43eb7c"},
					// HGST H7280A520SUN8.0T
					{name: "/dev/disk/by-id/wwn-0x5000cca23b3573bc"},
				]
			}, {
				name: "talos-nlu-hin"
				devices: [
					// HGST H7280A520SUN8.0T
					{name: "/dev/disk/by-id/wwn-0x5000cca23b366958"},
					// IBM-ESXS HUH728080AL420
					{name: "/dev/disk/by-id/wwn-0x5000cca26105b87c"},
				]
			}, {
				name: "talos-rh9-xsk"
				devices: [
					// HGST H7280A520SUN8.0T
					{name: "/dev/disk/by-id/wwn-0x5000cca261057c98"},
					// IBM-ESXS HUH728080AL420
					{name: "/dev/disk/by-id/wwn-0x5000cca23b435a24"},
				]
			}, {
				name: "talos-x7c-56v"
				devices: [
					// HGST H7280A520SUN8.0T
					{name: "/dev/disk/by-id/wwn-0x5000cca23b184d70"},
					// HGST H7280A520SUN8.0T
					{name: "/dev/disk/by-id/wwn-0x5000cca23b356ba0"},
				]
			}]
			onlyApplyOSDPlacement: false
		}
		disruptionManagement: {
			managePodBudgets:      true
			osdMaintenanceTimeout: 30
			pgHealthCheckTimeout:  0
		}
		healthCheck: {
			daemonHealth: {
				mon: {
					disabled: false
					interval: "45s"
				}
				osd: {
					disabled: false
					interval: "60s"
				}
				status: {
					disabled: false
					interval: "60s"
				}
			}
			livenessProbe: {
				mon: disabled: false
				mgr: disabled: false
				osd: disabled: false
			}
			startupProbe: {
				mon: disabled: false
				mgr: disabled: false
				osd: disabled: false
			}
		}
	}
}]
