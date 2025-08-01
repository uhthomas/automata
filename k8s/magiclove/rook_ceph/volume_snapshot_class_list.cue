package rook_ceph

import volumesnapshotv1 "github.com/kubernetes-csi/external-snapshotter/client/v8/apis/volumesnapshot/v1"

#VolumeSnapshotClassList: volumesnapshotv1.#VolumeSnapshotClassList & {
	apiVersion: "snapshot.storage.k8s.io/v1"
	kind:       "VolumeSnapshotClassList"
	items: [...{
		apiVersion: "snapshot.storage.k8s.io/v1"
		kind:       "VolumeSnapshotClass"
	}]
}

#VolumeSnapshotClassList: items: [{
	metadata: {
		name: "ceph-filesystem"
		annotations: "snapshot.storage.kubernetes.io/is-default-class": "true"
	}
	driver: "\(#Namespace).cephfs.csi.ceph.com"
	parameters: {
		clusterID:                                         #Namespace
		"csi.storage.k8s.io/snapshotter-secret-name":      "rook-csi-cephfs-provisioner"
		"csi.storage.k8s.io/snapshotter-secret-namespace": #Namespace
	}
	deletionPolicy: volumesnapshotv1.#VolumeSnapshotContentDelete
}, {
	metadata: {
		name: "ceph-block"
		annotations: "snapshot.storage.kubernetes.io/is-default-class": "true"
	}
	driver: "\(#Namespace).rbd.csi.ceph.com"
	parameters: {
		clusterID:                                         #Namespace
		"csi.storage.k8s.io/snapshotter-secret-name":      "rook-csi-rbd-provisioner"
		"csi.storage.k8s.io/snapshotter-secret-namespace": #Namespace
	}
	deletionPolicy: volumesnapshotv1.#VolumeSnapshotContentDelete
}]
