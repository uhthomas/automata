package rook_ceph

import "k8s.io/api/core/v1"

configMapList: v1.#ConfigMapList & {
	apiVersion: "v1"
	kind:       "ConfigMapList"
	items: [...{
		apiVersion: "v1"
		kind:       "ConfigMap"
	}]
}

configMapList: items: [{
	// Rook Ceph Operator Config ConfigMap
	// Use this ConfigMap to override Rook-Ceph Operator configurations.
	// NOTE! Precedence will be given to this config if the same Env Var config also exists in the
	//       Operator Deployment.
	// To move a configuration(s) from the Operator Deployment to this ConfigMap, add the config
	// here. It is recommended to then remove it from the Deployment to eliminate any future confusion.
	metadata: name: "rook-ceph-operator-config"
	data: {
		// Enable the CSI driver.
		// To run the non-default version of the CSI driver, see the override-able image properties in operator.yaml
		ROOK_CSI_ENABLE_CEPHFS: "true"
		// Enable the default version of the CSI RBD driver. To start another version of the CSI driver, see image properties below.
		ROOK_CSI_ENABLE_RBD:          "true"
		ROOK_CSI_ENABLE_GRPC_METRICS: "false"

		// Set to true to enable host networking for CSI CephFS and RBD nodeplugins. This may be necessary
		// in some network configurations where the SDN does not provide access to an external cluster or
		// there is significant drop in read/write performance.
		// CSI_ENABLE_HOST_NETWORK: "true"
		// Set logging level for csi containers.
		// Supported values from 0 to 5. 0 for general useful logs, 5 for trace level verbosity.
		// CSI_LOG_LEVEL: "0"
		// OMAP generator will generate the omap mapping between the PV name and the RBD image.
		// CSI_ENABLE_OMAP_GENERATOR need to be enabled when we are using rbd mirroring feature.
		// By default OMAP generator sidecar is deployed with CSI provisioner pod, to disable
		// it set it to false.
		// CSI_ENABLE_OMAP_GENERATOR: "false"
		// set to false to disable deployment of snapshotter container in CephFS provisioner pod.
		CSI_ENABLE_CEPHFS_SNAPSHOTTER: "true"

		// set to false to disable deployment of snapshotter container in RBD provisioner pod.
		CSI_ENABLE_RBD_SNAPSHOTTER: "true"

		// Enable cephfs kernel driver instead of ceph-fuse.
		// If you disable the kernel client, your application may be disrupted during upgrade.
		// See the upgrade guide: https://rook.io/docs/rook/master/ceph-upgrade.html
		// NOTE! cephfs quota is not supported in kernel version < 4.17
		CSI_FORCE_CEPHFS_KERNEL_CLIENT: "true"

		// (Optional) policy for modifying a volume's ownership or permissions when the RBD PVC is being mounted.
		// supported values are documented at https://kubernetes-csi.github.io/docs/support-fsgroup.html
		CSI_RBD_FSGROUPPOLICY: "ReadWriteOnceWithFSType"

		// (Optional) policy for modifying a volume's ownership or permissions when the CephFS PVC is being mounted.
		// supported values are documented at https://kubernetes-csi.github.io/docs/support-fsgroup.html
		CSI_CEPHFS_FSGROUPPOLICY: "ReadWriteOnceWithFSType"

		// (Optional) Allow starting unsupported ceph-csi image
		ROOK_CSI_ALLOW_UNSUPPORTED_VERSION: "false"
		// The default version of CSI supported by Rook will be started. To change the version
		// of the CSI driver to something other than what is officially supported, change
		// these images to the desired release of the CSI driver.
		// ROOK_CSI_CEPH_IMAGE: "quay.io/cephcsi/cephcsi:v3.3.1"
		// ROOK_CSI_REGISTRAR_IMAGE: "k8s.gcr.io/sig-storage/csi-node-driver-registrar:v2.0.1"
		// ROOK_CSI_RESIZER_IMAGE: "k8s.gcr.io/sig-storage/csi-resizer:v1.0.1"
		// ROOK_CSI_PROVISIONER_IMAGE: "k8s.gcr.io/sig-storage/csi-provisioner:v2.0.4"
		// ROOK_CSI_SNAPSHOTTER_IMAGE: "k8s.gcr.io/sig-storage/csi-snapshotter:v4.0.0"
		// ROOK_CSI_ATTACHER_IMAGE: "k8s.gcr.io/sig-storage/csi-attacher:v3.0.2"
		// (Optional) set user created priorityclassName for csi plugin pods.
		// CSI_PLUGIN_PRIORITY_CLASSNAME: "system-node-critical"
		// (Optional) set user created priorityclassName for csi provisioner pods.
		// CSI_PROVISIONER_PRIORITY_CLASSNAME: "system-cluster-critical"
		// CSI CephFS plugin daemonset update strategy, supported values are OnDelete and RollingUpdate.
		// Default value is RollingUpdate.
		// CSI_CEPHFS_PLUGIN_UPDATE_STRATEGY: "OnDelete"
		// CSI RBD plugin daemonset update strategy, supported values are OnDelete and RollingUpdate.
		// Default value is RollingUpdate.
		// CSI_RBD_PLUGIN_UPDATE_STRATEGY: "OnDelete"
		// kubelet directory path, if kubelet configured to use other than /var/lib/kubelet path.
		// ROOK_CSI_KUBELET_DIR_PATH: "/var/lib/kubelet"
		// Labels to add to the CSI CephFS Deployments and DaemonSets Pods.
		// ROOK_CSI_CEPHFS_POD_LABELS: "key1=value1,key2=value2"
		// Labels to add to the CSI RBD Deployments and DaemonSets Pods.
		// ROOK_CSI_RBD_POD_LABELS: "key1=value1,key2=value2"
		// (Optional) Ceph Provisioner NodeAffinity.
		// CSI_PROVISIONER_NODE_AFFINITY: "role=storage-node; storage=rook, ceph"
		// (Optional) CEPH CSI provisioner tolerations list. Put here list of taints you want to tolerate in YAML format.
		// CSI provisioner would be best to start on the same nodes as other ceph daemons.
		// CSI_PROVISIONER_TOLERATIONS: |
		//   - effect: NoSchedule
		//     key: node-role.kubernetes.io/controlplane
		//     operator: Exists
		//   - effect: NoExecute
		//     key: node-role.kubernetes.io/etcd
		//     operator: Exists
		// (Optional) Ceph CSI plugin NodeAffinity.
		// CSI_PLUGIN_NODE_AFFINITY: "role=storage-node; storage=rook, ceph"
		// (Optional) CEPH CSI plugin tolerations list. Put here list of taints you want to tolerate in YAML format.
		// CSI plugins need to be started on all the nodes where the clients need to mount the storage.
		// CSI_PLUGIN_TOLERATIONS: |
		//   - effect: NoSchedule
		//     key: node-role.kubernetes.io/controlplane
		//     operator: Exists
		//   - effect: NoExecute
		//     key: node-role.kubernetes.io/etcd
		//     operator: Exists
		// (Optional) CEPH CSI RBD provisioner resource requirement list, Put here list of resource
		// requests and limits you want to apply for provisioner pod
		// CSI_RBD_PROVISIONER_RESOURCE: |
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
		// CSI_RBD_PLUGIN_RESOURCE: |
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
		// CSI_CEPHFS_PROVISIONER_RESOURCE: |
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
		// CSI_CEPHFS_PLUGIN_RESOURCE: |
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
		// Configure CSI CSI Ceph FS grpc and liveness metrics port
		// CSI_CEPHFS_GRPC_METRICS_PORT: "9091"
		// CSI_CEPHFS_LIVENESS_METRICS_PORT: "9081"
		// Configure CSI RBD grpc and liveness metrics port
		// CSI_RBD_GRPC_METRICS_PORT: "9090"
		// CSI_RBD_LIVENESS_METRICS_PORT: "9080"
		// Whether the OBC provisioner should watch on the operator namespace or not, if not the namespace of the cluster will be used
		ROOK_OBC_WATCH_OPERATOR_NAMESPACE: "true"

		// Whether to enable the flex driver. By default it is enabled and is fully supported, but will be deprecated in some future release
		// in favor of the CSI driver.
		ROOK_ENABLE_FLEX_DRIVER: "false"
		// Whether to start the discovery daemon to watch for raw storage devices on nodes in the cluster.
		// This daemon does not need to run if you are only going to create your OSDs based on StorageClassDeviceSets with PVCs.
		ROOK_ENABLE_DISCOVERY_DAEMON: "false"
		// Enable volume replication controller
		CSI_ENABLE_VOLUME_REPLICATION: "false"
	}
}, {
	metadata: name: "rook-config-override"
	data: config: """
		[mon]
		auth_allow_insecure_global_id_reclaim = false

		"""
}]
