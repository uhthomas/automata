package rook_ceph

import "k8s.io/api/core/v1"

storageClassList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "ceph.rook.io/v1"
		kind:       "StorageClass"
	}]
}

storageClassList: items: [{
	metadata: name: "rook-ceph-block"
	// Change "rook-ceph" provisioner prefix to match the operator namespace if needed
	provisioner: "rook-ceph.rbd.csi.ceph.com"
	parameters: {
		// clusterID is the namespace where the rook cluster is running
		// If you change this namespace, also change the namespace below where the secret namespaces are defined
		clusterID: "rook-ceph" // namespace:cluster
		// If you want to use erasure coded pool with RBD, you need to create
		// two pools. one erasure coded and one replicated.
		// You need to specify the replicated pool here in the `pool` parameter, it is
		// used for the metadata of the images.
		// The erasure coded pool must be set as the `dataPool` parameter below.
		//dataPool: ec-data-pool
		pool: "replicapool"

		// (optional) mapOptions is a comma-separated list of map options.
		// For krbd options refer
		// https://docs.ceph.com/docs/master/man/8/rbd/#kernel-rbd-krbd-options
		// For nbd options refer
		// https://docs.ceph.com/docs/master/man/8/rbd-nbd/#options
		// mapOptions: lock_on_read,queue_depth=1024
		// (optional) unmapOptions is a comma-separated list of unmap options.
		// For krbd options refer
		// https://docs.ceph.com/docs/master/man/8/rbd/#kernel-rbd-krbd-options
		// For nbd options refer
		// https://docs.ceph.com/docs/master/man/8/rbd-nbd/#options
		// unmapOptions: force
		// RBD image format. Defaults to "2".
		imageFormat: "2"

		// RBD image features. Available for imageFormat: "2". CSI RBD currently supports only `layering` feature.
		imageFeatures: "layering"

		// The secrets contain Ceph admin credentials. These are generated automatically by the operator
		// in the same namespace as the cluster.
		"csi.storage.k8s.io/provisioner-secret-name":            "rook-csi-rbd-provisioner"
		"csi.storage.k8s.io/provisioner-secret-namespace":       "rook-ceph" // namespace:cluster
		"csi.storage.k8s.io/controller-expand-secret-name":      "rook-csi-rbd-provisioner"
		"csi.storage.k8s.io/controller-expand-secret-namespace": "rook-ceph" // namespace:cluster
		"csi.storage.k8s.io/node-stage-secret-name":             "rook-csi-rbd-node"
		"csi.storage.k8s.io/node-stage-secret-namespace":        "rook-ceph" // namespace:cluster
		// Specify the filesystem type of the volume. If not specified, csi-provisioner
		// will set default as `ext4`. Note that `xfs` is not recommended due to potential deadlock
		// in hyperconverged settings where the volume is mounted on the same node as the osds.
		"csi.storage.k8s.io/fstype": "ext4"
	}
	// uncomment the following to use rbd-nbd as mounter on supported nodes
	// **IMPORTANT**: If you are using rbd-nbd as the mounter, during upgrade you will be hit a ceph-csi
	// issue that causes the mount to be disconnected. You will need to follow special upgrade steps
	// to restart your application pods. Therefore, this option is not recommended.
	//mounter: rbd-nbd
	allowVolumeExpansion: true
	reclaimPolicy:        "Delete"
}]
