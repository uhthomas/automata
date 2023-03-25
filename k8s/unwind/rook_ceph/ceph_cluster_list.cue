package rook_ceph

import "k8s.io/api/core/v1"

#CephClusterList: v1.#List & {
	apiVersion: "ceph.rook.io/v1"
	kind:       "CephClusterList"
	items: [...{
		apiVersion: "ceph.rook.io/v1"
		kind:       "CephCluster"
	}]
}

#CephClusterList: items: [{
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
			}, {
				name:    "rook"
				enabled: true
			}]
		}
		dashboard: {
			enabled: true
			ssl:     true
		}
		// enable prometheus alerting for cluster
		monitoring: enabled: false
		network: connections: {
			encryption: enabled:  true
			compression: enabled: true
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
				name: "talos-avz-rb5"
				devices: [{
					// HGST H7280A520SUN8.0T
					name: "/dev/disk/by-id/wwn-0x5000cca23b366958"
					config: deviceClass: "hdd"
				}, {
					// IBM-ESXS HUH728080AL420
					name: "/dev/disk/by-id/wwn-0x5000cca26105b87c"
					config: deviceClass: "hdd"
				}]
			}, {
				name: "talos-god-636"
				devices: [{
					// HGST H7280A520SUN8.0T
					name: "/dev/disk/by-id/wwn-0x5000cca261057c98"
					config: deviceClass: "hdd"
				}, {
					// IBM-ESXS HUH728080AL420
					name: "/dev/disk/by-id/wwn-0x5000cca23b435a24"
					config: deviceClass: "hdd"
				}]
			}, {
				name: "talos-su3-l23"
				devices: [{
					// HGST H7280A520SUN8.0T
					name: "/dev/disk/by-id/wwn-0x5000cca23b184d70"
					config: deviceClass: "hdd"
				}, {
					// HGST H7280A520SUN8.0T
					name: "/dev/disk/by-id/wwn-0x5000cca23b356ba0"
					config: deviceClass: "hdd"
				}]
			}, {
				name: "talos-3sl-aqp"
				devices: [{
					// HGST H7280A520SUN8.0T
					name: "/dev/disk/by-id/wwn-0x5000cca23b43eb7c"
					config: deviceClass: "hdd"
				}, {
					// HGST H7280A520SUN8.0T
					name: "/dev/disk/by-id/wwn-0x5000cca23b3573bc"
					config: deviceClass: "hdd"
				}]
			}, {
				name: "talos-l94-p4c"
				devices: [{
					// HGST H7280A520SUN8.0T
					name: "/dev/disk/by-id/wwn-0x5000cca23b43d9ec"
					config: deviceClass: "hdd"
				}, {
					// HGST H7280A520SUN8.0T
					name: "/dev/disk/by-id/wwn-0x5000cca23b30dca4"
					config: deviceClass: "hdd"
				}]
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
