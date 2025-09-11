package rook_ceph

import (
	"encoding/yaml"

	"k8s.io/api/core/v1"
)

#ConfigMapList: v1.#ConfigMapList & {
	apiVersion: "v1"
	kind:       "ConfigMapList"
	items: [...{
		apiVersion: "v1"
		kind:       "ConfigMap"
	}]
}

#ConfigMapList: items: [{
	//################################################################################################################
	// The deployment for the rook operator
	// Contains the common settings for most Kubernetes deployments.
	// For example, to create the rook-ceph cluster:
	//   kubectl create -f crds.yaml -f common.yaml -f operator.yaml
	//   kubectl create -f cluster.yaml
	//
	// Also see other operator sample files for variations of operator.yaml:
	// - operator-openshift.yaml: Common settings for running in OpenShift
	//##############################################################################################################
	// Rook Ceph Operator Config ConfigMap
	// Use this ConfigMap to override Rook-Ceph Operator configurations.
	// NOTE! Precedence will be given to this config if the same Env Var config also exists in the
	//       Operator Deployment.
	// To move a configuration(s) from the Operator Deployment to this ConfigMap, add the config
	// here. It is recommended to then remove it from the Deployment to eliminate any future confusion.
	metadata: name: "rook-ceph-operator-config"
	data: {
		// The logging level for the operator: ERROR | WARNING | INFO | DEBUG
		ROOK_LOG_LEVEL: "INFO"

		// Allow using loop devices for osds in test clusters.
		ROOK_CEPH_ALLOW_LOOP_DEVICES: "false"

		ROOK_USE_CSI_OPERATOR: "true"

		// Enable the CSI driver.
		// To run the non-default version of the CSI driver, see the override-able image properties in operator.yaml
		ROOK_CSI_ENABLE_CEPHFS: "true"
		// Enable the default version of the CSI RBD driver. To start another version of the CSI driver, see image properties below.
		ROOK_CSI_ENABLE_RBD: "true"
		// Enable the CSI NFS driver. To start another version of the CSI driver, see image properties below.
		ROOK_CSI_ENABLE_NFS:          "false"
		ROOK_CSI_ENABLE_GRPC_METRICS: "false"

		// Set to true to enable Ceph CSI pvc encryption support.
		CSI_ENABLE_ENCRYPTION: "false"

		CSI_CEPHFS_KERNEL_MOUNT_OPTIONS: "ms_mode=secure"

		// Set to true to enable host networking for CSI CephFS and RBD nodeplugins. This may be necessary
		// in some network configurations where the SDN does not provide access to an external cluster or
		// there is significant drop in read/write performance.
		// CSI_ENABLE_HOST_NETWORK: "true"
		// Set to true to enable adding volume metadata on the CephFS subvolume and RBD images.
		// Not all users might be interested in getting volume/snapshot details as metadata on CephFS subvolume and RBD images.
		// Hence enable metadata is false by default.
		// CSI_ENABLE_METADATA: "true"
		// cluster name identifier to set as metadata on the CephFS subvolume and RBD images. This will be useful in cases
		// like for example, when two container orchestrator clusters (Kubernetes/OCP) are using a single ceph cluster.
		// CSI_CLUSTER_NAME: "my-prod-cluster"
		// Set logging level for cephCSI containers maintained by the cephCSI.
		// Supported values from 0 to 5. 0 for general useful logs, 5 for trace level verbosity.
		// CSI_LOG_LEVEL: "0"
		// Set logging level for Kubernetes-csi sidecar containers.
		// Supported values from 0 to 5. 0 for general useful logs (the default), 5 for trace level verbosity.
		// CSI_SIDECAR_LOG_LEVEL: "0"
		// Set replicas for csi provisioner deployment.
		CSI_PROVISIONER_REPLICAS: "2"

		// OMAP generator will generate the omap mapping between the PV name and the RBD image.
		// CSI_ENABLE_OMAP_GENERATOR need to be enabled when we are using rbd mirroring feature.
		// By default OMAP generator sidecar is deployed with CSI provisioner pod, to disable
		// it set it to false.
		// CSI_ENABLE_OMAP_GENERATOR: "false"
		// set to false to disable deployment of snapshotter container in CephFS provisioner pod.
		CSI_ENABLE_CEPHFS_SNAPSHOTTER: "true"

		// set to false to disable deployment of snapshotter container in NFS provisioner pod.
		CSI_ENABLE_NFS_SNAPSHOTTER: "true"

		// set to false to disable deployment of snapshotter container in RBD provisioner pod.
		CSI_ENABLE_RBD_SNAPSHOTTER: "true"

		// Enable cephfs kernel driver instead of ceph-fuse.
		// If you disable the kernel client, your application may be disrupted during upgrade.
		// See the upgrade guide: https://rook.io/docs/rook/latest/ceph-upgrade.html
		// NOTE! cephfs quota is not supported in kernel version < 4.17
		CSI_FORCE_CEPHFS_KERNEL_CLIENT: "true"

		// (Optional) policy for modifying a volume's ownership or permissions when the RBD PVC is being mounted.
		// supported values are documented at https://kubernetes-csi.github.io/docs/support-fsgroup.html
		CSI_RBD_FSGROUPPOLICY: "File"

		// (Optional) policy for modifying a volume's ownership or permissions when the CephFS PVC is being mounted.
		// supported values are documented at https://kubernetes-csi.github.io/docs/support-fsgroup.html
		CSI_CEPHFS_FSGROUPPOLICY: "File"

		// (Optional) policy for modifying a volume's ownership or permissions when the NFS PVC is being mounted.
		// supported values are documented at https://kubernetes-csi.github.io/docs/support-fsgroup.html
		CSI_NFS_FSGROUPPOLICY: "File"

		// (Optional) Allow starting unsupported ceph-csi image
		ROOK_CSI_ALLOW_UNSUPPORTED_VERSION: "false"

		// (Optional) control the host mount of /etc/selinux for csi plugin pods.
		CSI_PLUGIN_ENABLE_SELINUX_HOST_MOUNT: "false"

		// The default version of CSI supported by Rook will be started. To change the version
		// of the CSI driver to something other than what is officially supported, change
		// these images to the desired release of the CSI driver.
		// ROOK_CSI_CEPH_IMAGE: "quay.io/cephcsi/cephcsi:v3.7.2"
		// ROOK_CSI_REGISTRAR_IMAGE: "registry.k8s.io/sig-storage/csi-node-driver-registrar:v2.7.0"
		// ROOK_CSI_RESIZER_IMAGE: "registry.k8s.io/sig-storage/csi-resizer:v1.7.0"
		// ROOK_CSI_PROVISIONER_IMAGE: "registry.k8s.io/sig-storage/csi-provisioner:v3.4.0"
		// ROOK_CSI_SNAPSHOTTER_IMAGE: "registry.k8s.io/sig-storage/csi-snapshotter:v6.2.1"
		// ROOK_CSI_ATTACHER_IMAGE: "registry.k8s.io/sig-storage/csi-attacher:v4.1.0"
		// To indicate the image pull policy to be applied to all the containers in the csi driver pods.
		// ROOK_CSI_IMAGE_PULL_POLICY: "IfNotPresent"
		// (Optional) set user created priorityclassName for csi plugin pods.
		CSI_PLUGIN_PRIORITY_CLASSNAME: "system-node-critical"

		// (Optional) set user created priorityclassName for csi provisioner pods.
		CSI_PROVISIONER_PRIORITY_CLASSNAME: "system-cluster-critical"

		// CSI CephFS plugin daemonset update strategy, supported values are OnDelete and RollingUpdate.
		// Default value is RollingUpdate.
		// CSI_CEPHFS_PLUGIN_UPDATE_STRATEGY: "OnDelete"
		// CSI RBD plugin daemonset update strategy, supported values are OnDelete and RollingUpdate.
		// Default value is RollingUpdate.
		// CSI_RBD_PLUGIN_UPDATE_STRATEGY: "OnDelete"
		// A maxUnavailable parameter of CSI RBD plugin daemonset update strategy.
		// Default value is 1.
		// CSI_RBD_PLUGIN_UPDATE_STRATEGY_MAX_UNAVAILABLE: "1"
		// CSI NFS plugin daemonset update strategy, supported values are OnDelete and RollingUpdate.
		// Default value is RollingUpdate.
		// CSI_NFS_PLUGIN_UPDATE_STRATEGY: "OnDelete"
		// kubelet directory path, if kubelet configured to use other than /var/lib/kubelet path.
		// ROOK_CSI_KUBELET_DIR_PATH: "/var/lib/kubelet"
		// Labels to add to the CSI CephFS Deployments and DaemonSets Pods.
		// ROOK_CSI_CEPHFS_POD_LABELS: "key1=value1,key2=value2"
		// Labels to add to the CSI RBD Deployments and DaemonSets Pods.
		// ROOK_CSI_RBD_POD_LABELS: "key1=value1,key2=value2"
		// Labels to add to the CSI NFS Deployments and DaemonSets Pods.
		// ROOK_CSI_NFS_POD_LABELS: "key1=value1,key2=value2"
		// (Optional) CephCSI CephFS plugin Volumes
		// CSI_CEPHFS_PLUGIN_VOLUME: |
		//  - name: lib-modules
		//    hostPath:
		//      path: /run/current-system/kernel-modules/lib/modules/
		//  - name: host-nix
		//    hostPath:
		//      path: /nix
		// (Optional) CephCSI CephFS plugin Volume mounts
		// CSI_CEPHFS_PLUGIN_VOLUME_MOUNT: |
		//  - name: host-nix
		//    mountPath: /nix
		//    readOnly: true
		// (Optional) CephCSI RBD plugin Volumes
		// CSI_RBD_PLUGIN_VOLUME: |
		//  - name: lib-modules
		//    hostPath:
		//      path: /run/current-system/kernel-modules/lib/modules/
		//  - name: host-nix
		//    hostPath:
		//      path: /nix
		// (Optional) CephCSI RBD plugin Volume mounts
		// CSI_RBD_PLUGIN_VOLUME_MOUNT: |
		//  - name: host-nix
		//    mountPath: /nix
		//    readOnly: true
		// (Optional) CephCSI provisioner NodeAffinity (applied to both CephFS and RBD provisioner).
		// CSI_PROVISIONER_NODE_AFFINITY: "role=storage-node; storage=rook, ceph"
		// (Optional) CephCSI provisioner tolerations list(applied to both CephFS and RBD provisioner).
		// Put here list of taints you want to tolerate in YAML format.
		// CSI provisioner would be best to start on the same nodes as other ceph daemons.
		CSI_PROVISIONER_TOLERATIONS: yaml.Marshal([{
			key:      "node-role.kubernetes.io/control-plane"
			operator: v1.#TolerationOpExists
			effect:   v1.#TaintEffectNoSchedule
		}])
		//   - effect: NoExecute
		//     key: node-role.kubernetes.io/etcd
		//     operator: Exists
		// (Optional) CephCSI plugin NodeAffinity (applied to both CephFS and RBD plugin).
		// CSI_PLUGIN_NODE_AFFINITY: "role=storage-node; storage=rook, ceph"
		// (Optional) CephCSI plugin tolerations list(applied to both CephFS and RBD plugin).
		// Put here list of taints you want to tolerate in YAML format.
		// CSI plugins need to be started on all the nodes where the clients need to mount the storage.
		CSI_PLUGIN_TOLERATIONS: yaml.Marshal([{
			key:      "node-role.kubernetes.io/control-plane"
			operator: v1.#TolerationOpExists
			effect:   v1.#TaintEffectNoSchedule
		}])
		// (Optional) CephCSI RBD provisioner NodeAffinity (if specified, overrides CSI_PROVISIONER_NODE_AFFINITY).
		// CSI_RBD_PROVISIONER_NODE_AFFINITY: "role=rbd-node"
		// (Optional) CephCSI RBD provisioner tolerations list(if specified, overrides CSI_PROVISIONER_TOLERATIONS).
		// Put here list of taints you want to tolerate in YAML format.
		// CSI provisioner would be best to start on the same nodes as other ceph daemons.
		CSI_RBD_PROVISIONER_TOLERATIONS: yaml.Marshal([{
			key:      "node-role.kubernetes.io/control-plane"
			operator: v1.#TolerationOpExists
			effect:   v1.#TaintEffectNoSchedule
		}])
		// (Optional) CephCSI RBD plugin NodeAffinity (if specified, overrides CSI_PLUGIN_NODE_AFFINITY).
		// CSI_RBD_PLUGIN_NODE_AFFINITY: "role=rbd-node"
		// (Optional) CephCSI RBD plugin tolerations list(if specified, overrides CSI_PLUGIN_TOLERATIONS).
		// Put here list of taints you want to tolerate in YAML format.
		// CSI plugins need to be started on all the nodes where the clients need to mount the storage.
		CSI_RBD_PLUGIN_TOLERATIONS: yaml.Marshal([{
			key:      "node-role.kubernetes.io/control-plane"
			operator: v1.#TolerationOpExists
			effect:   v1.#TaintEffectNoSchedule
		}])
		// (Optional) CephCSI CephFS provisioner NodeAffinity (if specified, overrides CSI_PROVISIONER_NODE_AFFINITY).
		// CSI_CEPHFS_PROVISIONER_NODE_AFFINITY: "role=cephfs-node"
		// (Optional) CephCSI CephFS provisioner tolerations list(if specified, overrides CSI_PROVISIONER_TOLERATIONS).
		// Put here list of taints you want to tolerate in YAML format.
		// CSI provisioner would be best to start on the same nodes as other ceph daemons.
		CSI_CEPHFS_PROVISIONER_TOLERATIONS: yaml.Marshal([{
			key:      "node-role.kubernetes.io/control-plane"
			operator: v1.#TolerationOpExists
			effect:   v1.#TaintEffectNoSchedule
		}])
		// (Optional) CephCSI CephFS plugin NodeAffinity (if specified, overrides CSI_PLUGIN_NODE_AFFINITY).
		// CSI_CEPHFS_PLUGIN_NODE_AFFINITY: "role=cephfs-node"
		// NOTE: Support for defining NodeAffinity for operators other than "In" and "Exists" requires the user to input a
		// valid v1.NodeAffinity JSON or YAML string. For example, the following is valid YAML v1.NodeAffinity:
		// CSI_CEPHFS_PLUGIN_NODE_AFFINITY: |
		//   requiredDuringSchedulingIgnoredDuringExecution:
		//     nodeSelectorTerms:
		//       - matchExpressions:
		//         - key: myKey
		//           operator: DoesNotExist
		// (Optional) CephCSI CephFS plugin tolerations list(if specified, overrides CSI_PLUGIN_TOLERATIONS).
		// Put here list of taints you want to tolerate in YAML format.
		// CSI plugins need to be started on all the nodes where the clients need to mount the storage.
		// CSI_CEPHFS_PLUGIN_TOLERATIONS: |
		//   - key: node.rook.io/cephfs
		//     operator: Exists
		// (Optional) CephCSI NFS provisioner NodeAffinity (overrides CSI_PROVISIONER_NODE_AFFINITY).
		// CSI_NFS_PROVISIONER_NODE_AFFINITY: "role=nfs-node"
		// (Optional) CephCSI NFS provisioner tolerations list (overrides CSI_PROVISIONER_TOLERATIONS).
		// Put here list of taints you want to tolerate in YAML format.
		// CSI provisioner would be best to start on the same nodes as other ceph daemons.
		// CSI_NFS_PROVISIONER_TOLERATIONS: |
		//   - key: node.rook.io/nfs
		//     operator: Exists
		// (Optional) CephCSI NFS plugin NodeAffinity (overrides CSI_PLUGIN_NODE_AFFINITY).
		// CSI_NFS_PLUGIN_NODE_AFFINITY: "role=nfs-node"
		// (Optional) CephCSI NFS plugin tolerations list (overrides CSI_PLUGIN_TOLERATIONS).
		// Put here list of taints you want to tolerate in YAML format.
		// CSI plugins need to be started on all the nodes where the clients need to mount the storage.
		// CSI_NFS_PLUGIN_TOLERATIONS: |
		//   - key: node.rook.io/nfs
		//     operator: Exists
		// (Optional) CEPH CSI RBD provisioner resource requirement list, Put here list of resource
		// requests and limits you want to apply for provisioner pod
		//CSI_RBD_PROVISIONER_RESOURCE: |
		//  - name : csi-provisioner
		//    resource:
		//      requests:
		//        memory: 128Mi
		//        cpu: 100m
		//      limits:
		//        memory: 256Mi
		//        cpu: 200m
		//  - name : csi-resizer
		//    resource:
		//      requests:
		//        memory: 128Mi
		//        cpu: 100m
		//      limits:
		//        memory: 256Mi
		//        cpu: 200m
		//  - name : csi-attacher
		//    resource:
		//      requests:
		//        memory: 128Mi
		//        cpu: 100m
		//      limits:
		//        memory: 256Mi
		//        cpu: 200m
		//  - name : csi-snapshotter
		//    resource:
		//      requests:
		//        memory: 128Mi
		//        cpu: 100m
		//      limits:
		//        memory: 256Mi
		//        cpu: 200m
		//  - name : csi-rbdplugin
		//    resource:
		//      requests:
		//        memory: 512Mi
		//        cpu: 250m
		//      limits:
		//        memory: 1Gi
		//        cpu: 500m
		//  - name : csi-omap-generator
		//    resource:
		//      requests:
		//        memory: 512Mi
		//        cpu: 250m
		//      limits:
		//        memory: 1Gi
		//        cpu: 500m
		//  - name : liveness-prometheus
		//    resource:
		//      requests:
		//        memory: 128Mi
		//        cpu: 50m
		//      limits:
		//        memory: 256Mi
		//        cpu: 100m
		// (Optional) CEPH CSI RBD plugin resource requirement list, Put here list of resource
		// requests and limits you want to apply for plugin pod
		//CSI_RBD_PLUGIN_RESOURCE: |
		//  - name : driver-registrar
		//    resource:
		//      requests:
		//        memory: 128Mi
		//        cpu: 50m
		//      limits:
		//        memory: 256Mi
		//        cpu: 100m
		//  - name : csi-rbdplugin
		//    resource:
		//      requests:
		//        memory: 512Mi
		//        cpu: 250m
		//      limits:
		//        memory: 1Gi
		//        cpu: 500m
		//  - name : liveness-prometheus
		//    resource:
		//      requests:
		//        memory: 128Mi
		//        cpu: 50m
		//      limits:
		//        memory: 256Mi
		//        cpu: 100m
		// (Optional) CEPH CSI CephFS provisioner resource requirement list, Put here list of resource
		// requests and limits you want to apply for provisioner pod
		//CSI_CEPHFS_PROVISIONER_RESOURCE: |
		//  - name : csi-provisioner
		//    resource:
		//      requests:
		//        memory: 128Mi
		//        cpu: 100m
		//      limits:
		//        memory: 256Mi
		//        cpu: 200m
		//  - name : csi-resizer
		//    resource:
		//      requests:
		//        memory: 128Mi
		//        cpu: 100m
		//      limits:
		//        memory: 256Mi
		//        cpu: 200m
		//  - name : csi-attacher
		//    resource:
		//      requests:
		//        memory: 128Mi
		//        cpu: 100m
		//      limits:
		//        memory: 256Mi
		//        cpu: 200m
		//  - name : csi-snapshotter
		//    resource:
		//      requests:
		//        memory: 128Mi
		//        cpu: 100m
		//      limits:
		//        memory: 256Mi
		//        cpu: 200m
		//  - name : csi-cephfsplugin
		//    resource:
		//      requests:
		//        memory: 512Mi
		//        cpu: 250m
		//      limits:
		//        memory: 1Gi
		//        cpu: 500m
		//  - name : liveness-prometheus
		//    resource:
		//      requests:
		//        memory: 128Mi
		//        cpu: 50m
		//      limits:
		//        memory: 256Mi
		//        cpu: 100m
		// (Optional) CEPH CSI CephFS plugin resource requirement list, Put here list of resource
		// requests and limits you want to apply for plugin pod
		//CSI_CEPHFS_PLUGIN_RESOURCE: |
		//  - name : driver-registrar
		//    resource:
		//      requests:
		//        memory: 128Mi
		//        cpu: 50m
		//      limits:
		//        memory: 256Mi
		//        cpu: 100m
		//  - name : csi-cephfsplugin
		//    resource:
		//      requests:
		//        memory: 512Mi
		//        cpu: 250m
		//      limits:
		//        memory: 1Gi
		//        cpu: 500m
		//  - name : liveness-prometheus
		//    resource:
		//      requests:
		//        memory: 128Mi
		//        cpu: 50m
		//      limits:
		//        memory: 256Mi
		//        cpu: 100m
		// (Optional) CEPH CSI NFS provisioner resource requirement list, Put here list of resource
		// requests and limits you want to apply for provisioner pod
		// CSI_NFS_PROVISIONER_RESOURCE: |
		//  - name : csi-provisioner
		//    resource:
		//      requests:
		//        memory: 128Mi
		//        cpu: 100m
		//      limits:
		//        memory: 256Mi
		//        cpu: 200m
		//  - name : csi-nfsplugin
		//    resource:
		//      requests:
		//        memory: 512Mi
		//        cpu: 250m
		//      limits:
		//        memory: 1Gi
		//        cpu: 500m
		// (Optional) CEPH CSI NFS plugin resource requirement list, Put here list of resource
		// requests and limits you want to apply for plugin pod
		// CSI_NFS_PLUGIN_RESOURCE: |
		//  - name : driver-registrar
		//    resource:
		//      requests:
		//        memory: 128Mi
		//        cpu: 50m
		//      limits:
		//        memory: 256Mi
		//        cpu: 100m
		//  - name : csi-nfsplugin
		//    resource:
		//      requests:
		//        memory: 512Mi
		//        cpu: 250m
		//      limits:
		//        memory: 1Gi
		//        cpu: 500m
		// Configure CSI Ceph FS grpc and liveness metrics port
		// Set to true to enable Ceph CSI liveness container.
		CSI_ENABLE_LIVENESS: "true"
		// CSI_CEPHFS_GRPC_METRICS_PORT: "9091"
		// CSI_CEPHFS_LIVENESS_METRICS_PORT: "9081"
		// Configure CSI RBD grpc and liveness metrics port
		// CSI_RBD_GRPC_METRICS_PORT: "9090"
		// CSI_RBD_LIVENESS_METRICS_PORT: "9080"
		// CSIADDONS_PORT: "9070"
		// Whether the OBC provisioner should watch on the operator namespace or not, if not the namespace of the cluster will be used
		ROOK_OBC_WATCH_OPERATOR_NAMESPACE: "true"

		// Whether to start the discovery daemon to watch for raw storage devices on nodes in the cluster.
		// This daemon does not need to run if you are only going to create your OSDs based on StorageClassDeviceSets with PVCs.
		ROOK_ENABLE_DISCOVERY_DAEMON: "true"
		// The timeout value (in seconds) of Ceph commands. It should be >= 1. If this variable is not set or is an invalid value, it's default to 15.
		ROOK_CEPH_COMMANDS_TIMEOUT_SECONDS: "15"
		// Enable the csi addons sidecar.
		CSI_ENABLE_CSIADDONS: "false"
		// Enable watch for faster recovery from rbd rwo node loss
		ROOK_WATCH_FOR_NODE_FAILURE: "true"
		// ROOK_CSIADDONS_IMAGE: "quay.io/csiaddons/k8s-sidecar:v0.5.0"
		// The CSI GRPC timeout value (in seconds). It should be >= 120. If this variable is not set or is an invalid value, it's default to 150.
		CSI_GRPC_TIMEOUT_SECONDS: "150"

		ROOK_DISABLE_ADMISSION_CONTROLLER: "true"

		// Enable topology based provisioning.
		CSI_ENABLE_TOPOLOGY: "false"
	}
}, {
	metadata: name: "rook-config-override"
	data: config: """
		[osd]
		osd_scrub_auto_repair = true

		"""
}]
