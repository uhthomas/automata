package rook_ceph

import cephv1 "github.com/rook/rook/pkg/apis/ceph.rook.io/v1"

#CephObjectStoreList: cephv1.#CephObjectStoreList & {
	apiVersion: "ceph.rook.io/v1"
	kind:       "CephObjectStoreList"
	items: [...{
		apiVersion: "ceph.rook.io/v1"
		kind:       "CephObjectStore"
	}]
}

#CephObjectStoreList: items: []

// #CephObjectStoreList: items: [{
// 	metadata: name: "ecstore-hdd"
// 	spec: {
// 		metadataPool: {
// 			replicated: size: 3
// 			deviceClass: "hdd"
// 		}
// 		dataPool: {
// 			erasureCoded: {
// 				dataChunks:   3
// 				codingChunks: 2
// 			}
// 			deviceClass: "hdd"
// 		}
// 		gateway: port: 80
// 	}
// }]
