package rook_ceph

import "k8s.io/api/core/v1"

#CephObjectStoreList: v1.#List & {
	apiVersion: "ceph.rook.io/v1"
	kind:       "CephObjectStoreList"
	items: [...{
		apiVersion: "ceph.rook.io/v1"
		kind:       "CephObjectStore"
	}]
}

#CephObjectStoreList: items: [{
	metadata: name: "ecstore-hdd"
	spec: {
		metadataPool: replicated: size: 3
		dataPool: erasureCoded: {
			dataChunks:   3
			codingChunks: 2
		}
		gateway: port: 80
	}
}]
