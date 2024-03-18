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
			image:            "docker.io/rkachach/ceph:v18.2.1_patched_v1"
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
			enabled:            true
			ssl:                true
			prometheusEndpoint: "http://vmsingle-vm.vm.svc.cluster.local:8429"
		}
		// Metrics are still collected, but directly from the pods
		// rather than with service monitors.
		//
		// See: https://github.com/rook/rook/issues/12422
		// monitoring: enabled: true
		monitoring: metricsDisabled: false
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
			api: limits: {
				(v1.#ResourceCPU):    "100m"
				(v1.#ResourceMemory): "512Mi"
			}
			mgr: limits: {
				(v1.#ResourceCPU):    "500m"
				(v1.#ResourceMemory): "768Mi"
			}
			mon: limits: {
				(v1.#ResourceCPU):    "500m"
				(v1.#ResourceMemory): "768Mi"
			}
			osd: {
				limits: (v1.#ResourceMemory): "3Gi"
				requests: (v1.#ResourceCPU):  "300m"
			}
			exporter: limits: {
				(v1.#ResourceCPU):    "1"
				(v1.#ResourceMemory): "50Mi"
			}
			logcollector: limits: {
				(v1.#ResourceCPU):    "50m"
				(v1.#ResourceMemory): "50Mi"
			}
		}
		storage: {
			useAllNodes:   false
			useAllDevices: false
			nodes: [{
				name: "rhode"
				devices: [{
					// KIOXIA KCD61LUL3T84
					name: "/dev/disk/by-id/nvme-eui.00000000000000008ce38ee206d20501"
					config: deviceClass: "nvme"
				}, {
					// SAMSUNG MZWLL3T2HMJP-00003
					name: "/dev/disk/by-id/nvme-eui.334841304b4002370025385800000004"
					config: deviceClass: "nvme"
				}, {
					// SAMSUNG MZWLL3T2HMJP-00003
					name: "/dev/disk/by-id/nvme-eui.334841304b4015940025385800000003"
					config: deviceClass: "nvme"
				}, {
					// SAMSUNG MZWLL3T2HMJP-00003
					name: "/dev/disk/by-id/nvme-eui.334841304bb000770025385800000004"
					config: deviceClass: "nvme"
				}, {
					// SAMSUNG MZWLL3T2HMJP-00003
					name: "/dev/disk/by-id/nvme-eui.334841304bb000790025385800000004"
					config: deviceClass: "nvme"
				}, {
					// SAMSUNG MZWLL3T2HMJP-00003
					name: "/dev/disk/by-id/nvme-eui.334841304bb001020025385800000004"
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
				}, {
					// WD 4TB (TEMP - DELETE SOON)
					name: "/dev/disk/by-id/wwn-0x50014ee20a0d98d1"
					config: deviceClass: "hdd"
				}, {
					// WD 4TB (TEMP - DELETE SOON)
					name: "/dev/disk/by-id/wwn-0x50014ee20a85be27"
					config: deviceClass: "hdd"
				}, {
					// HGST HUH721010AL5200
					name: "/dev/disk/by-id/wwn-0x5000cca2669799a0"
					config: deviceClass: "hdd"
				}, {
					// HGST HUH721010AL5200
					name: "/dev/disk/by-id/wwn-0x5000cca26c015ed8"
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
