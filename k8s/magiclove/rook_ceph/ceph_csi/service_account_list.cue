package ceph_csi

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
	{metadata: name: "ceph-csi-operator-cephfs-ctrlplugin-sa"},
	{metadata: name: "ceph-csi-operator-cephfs-nodeplugin-sa"},
	{metadata: name: "ceph-csi-operator-nfs-ctrlplugin-sa"},
	{metadata: name: "ceph-csi-operator-nfs-nodeplugin-sa"},
	{metadata: name: "ceph-csi-operator-rbd-ctrlplugin-sa"},
	{metadata: name: "ceph-csi-operator-rbd-nodeplugin-sa"},
]
