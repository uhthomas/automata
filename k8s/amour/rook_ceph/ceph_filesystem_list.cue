package rook_ceph

import cephv1 "github.com/rook/rook/pkg/apis/ceph.rook.io/v1"

#CephFilesystemList: cephv1.#CephFilesystemList & {
	apiVersion: "ceph.rook.io/v1"
	kind:       "CephFilesystemList"
	items: [...{
		apiVersion: "ceph.rook.io/v1"
		kind:       "CephFilesystem"
	}]
}

#CephFilesystemList: items: []

// #CephFilesystemList: items: [{
// 	metadata: name: "mainfs-ec"
// 	spec: {
// 		metadataPool: {
// 			replicated: size: 3
// 			deviceClass: "hdd"
// 		}
// 		dataPools: [{
// 			name: "default"
// 			replicated: size: 3
// 			deviceClass: "hdd"
// 		}, {
// 			name: "erasurecoded"
// 			erasureCoded: {
// 				dataChunks:   3
// 				codingChunks: 2
// 			}
// 			deviceClass: "hdd"
// 		}]
// 		preserveFilesystemOnDelete: true
// 		metadataServer: {
// 			activeCount:   1
// 			activeStandby: true
// 		}
// 	}
// }]
