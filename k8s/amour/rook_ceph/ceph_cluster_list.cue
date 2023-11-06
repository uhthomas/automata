package rook_ceph

import (
	cephv1 "github.com/rook/rook/pkg/apis/ceph.rook.io/v1"
	"k8s.io/api/core/v1"
)

#CephClusterList: cephv1.#CephClusterList & {
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
			image:            "quay.io/ceph/ceph:v18.2.0"
			allowUnsupported: false
		}
		dataDirHostPath:                            "/var/lib/rook"
		skipUpgradeChecks:                          false
		continueUpgradeAfterChecksEvenIfNotHealthy: false
		waitTimeoutForHealthyOSDInMinutes:          10
		mon: {
			count:                3
			allowMultiplePerNode: true
		}
		mgr: {
			count:                2
			allowMultiplePerNode: true
			modules: [{
				name:    "diskprediction_local"
				enabled: true
			}, {
				name:    "nfs"
				enabled: false
			}, {
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
		// Metrics are still collected, but directly from the pods
		// rather than with service monitors.
		//
		// See: https://github.com/rook/rook/issues/12422
		monitoring: enabled: true
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
				method:     cephv1.#SanitizeMethodQuick
				dataSource: cephv1.#SanitizeDataSourceZero
				iteration:  1
			}
			// allowUninstallWithVolumes defines how the uninstall should be performed
			// If set to true, cephCluster deletion does not wait for the PVs to be deleted.
			allowUninstallWithVolumes: false
		}
		removeOSDsIfOutAndSafeToRemove: true
		priorityClassNames: {
			mon: "system-node-critical"
			osd: "system-node-critical"
			mgr: "system-cluster-critical"
		}
		resources: {
			api: {
				requests: {
					(v1.#ResourceCPU):    "500m"
					(v1.#ResourceMemory): "512Mi"
				}
				limits: {
					(v1.#ResourceCPU):    "500m"
					(v1.#ResourceMemory): "512Mi"
				}
			}
			mgr: {
				requests: {
					(v1.#ResourceCPU):    "500m"
					(v1.#ResourceMemory): "512Mi"
				}
				limits: {
					(v1.#ResourceCPU):    "500m"
					(v1.#ResourceMemory): "1Gi"
				}
			}
			mon: {
				requests: {
					(v1.#ResourceCPU):    "500m"
					(v1.#ResourceMemory): "512Mi"
				}
				limits: {
					(v1.#ResourceCPU):    "500m"
					(v1.#ResourceMemory): "512Mi"
				}
			}
			osd: {
				requests: {
					(v1.#ResourceCPU):    "500m"
					(v1.#ResourceMemory): "512Mi"
				}
				limits: {
					(v1.#ResourceCPU):    "1"
					(v1.#ResourceMemory): "4Gi"
				}
			}
			exporter: {
				limits: {
					(v1.#ResourceCPU):    "250m"
					(v1.#ResourceMemory): "128Mi"
				}
				requests: {
					(v1.#ResourceCPU):    "50m"
					(v1.#ResourceMemory): "50Mi"
				}
			}
		}
		storage: {
			useAllNodes:   false
			useAllDevices: false
			nodes: [{
				name: "rhode"
				devices: [{
					// Samsung 970 EVO Plus 2TB
					name: "/dev/disk/by-id/nvme-eui.002538543190f788"
					config: deviceClass: "nvme"
				}, {
					// Samsung 970 EVO Plus 2TB
					name: "/dev/disk/by-id/nvme-eui.0025385531b39d87"
					config: deviceClass: "nvme"
				}, {
					// HGST H7280A520SUN8.0T
					name: "/dev/disk/by-id/wwn-0x5000cca23b3573bc"
					config: deviceClass: "hdd"
				}, {
					// HGST H7280A520SUN8.0T
					name: "/dev/disk/by-id/wwn-0x5000cca23b435a24"
					config: deviceClass: "hdd"
				}, {
					// IBM-ESXS HUH728080AL420
					name: "/dev/disk/by-id/wwn-0x5000cca261057c98"
					config: deviceClass: "hdd"
				}, {
					// IBM-ESXS HUH728080AL420
					name: "/dev/disk/by-id/wwn-0x5000cca26105b87c"
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
