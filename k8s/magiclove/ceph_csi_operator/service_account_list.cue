package ceph_csi_operator

import "k8s.io/api/core/v1"

#ServiceAccountList: v1.#ServiceAccountList & {
	apiVersion: "v1"
	kind:       "ServiceAccountList"
	items: [...{
		apiVersion: "v1"
		kind:       "ServiceAccount"
	}]
}

#ServiceAccountList: items: [
	{metadata: name: "ceph-csi-operator-controller-manager"},
	{metadata: name: "ceph-csi-operator-cephfs-ctrlplugin"},
	{metadata: name: "ceph-csi-operator-cephfs-nodeplugin"},
	{metadata: name: "ceph-csi-operator-nfs-ctrlplugin"},
	{metadata: name: "ceph-csi-operator-nfs-nodeplugin"},
	{metadata: name: "ceph-csi-operator-rbd-ctrlplugin"},
	{metadata: name: "ceph-csi-operator-rbd-nodeplugin"},
]
