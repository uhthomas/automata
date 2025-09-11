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
			image:            "quay.io/ceph/ceph:v\(#CephVersion)"
			allowUnsupported: false
		}
		placement: {
			mgr: tolerations: [{
				key:      "node-role.kubernetes.io/control-plane"
				operator: v1.#TolerationOpExists
				effect:   v1.#TaintEffectNoSchedule
			}]
			mon: tolerations: [{
				key:      "node-role.kubernetes.io/control-plane"
				operator: v1.#TolerationOpExists
				effect:   v1.#TaintEffectNoSchedule
			}]
		}
		dataDirHostPath:                            "/var/lib/rook"
		skipUpgradeChecks:                          false
		continueUpgradeAfterChecksEvenIfNotHealthy: false
		waitTimeoutForHealthyOSDInMinutes:          10
		upgradeOSDRequiresHealthyPGs:               false
		mon: count: 3
		mgr: {
			count: 2
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
			ssl:                false
			prometheusEndpoint: "http://vmsingle-vm.vm.svc.cluster.local:8429"
		}
		// Metrics are still collected, but directly from the pods
		// rather than with service monitors.
		//
		// See: https://github.com/rook/rook/issues/12422
		monitoring: {
			metricsDisabled: false
			exporter: {
				perfCountersPrioLimit: 5
				statsPeriodSeconds:    5
			}
		}
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
			mgr: {
				limits: {
					(v1.#ResourceCPU):    "4"
					(v1.#ResourceMemory): "1Gi"
				}
				requests: (v1.#ResourceCPU): "1"
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
			useAllNodes:               false
			useAllDevices:             false
			allowDeviceClassUpdate:    false
			allowOsdCrushWeightUpdate: false
			nodes: [{
				name: "dice"
				devices: [{
					// Huawei HWE52P436T4M002N
					name: "/dev/disk/by-id/nvme-eui.01000000000000000022a100f034c452"
					config: deviceClass: "nvme"
				}, {
					// Huawei HWE52P436T4M002N
					name: "/dev/disk/by-id/nvme-eui.01000000000000000022a1002039c452"
					config: deviceClass: "nvme"
				}, {
					// KIOXIA KCD61LUL3T84
					name: "/dev/disk/by-id/nvme-eui.00000000000000008ce38ee206d20501"
					config: deviceClass: "nvme"
				}, {
					// INTEL SSDPF2KX038T1
					name: "/dev/disk/by-id/nvme-eui.01000000000000005cd2e49630575551"
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
				}]
			}]
			scheduleAlways:        false
			onlyApplyOSDPlacement: false
		}
		disruptionManagement: {
			managePodBudgets:      true
			osdMaintenanceTimeout: 30
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
