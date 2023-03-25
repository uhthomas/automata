package rook_ceph

import "k8s.io/api/core/v1"

#CephFilesystemList: v1.#List & {
	apiVersion: "ceph.rook.io/v1"
	kind:       "CephFilesystemList"
	items: [...{
		apiVersion: "ceph.rook.io/v1"
		kind:       "CephFilesystem"
	}]
}

#CephFilesystemList: items: [{
	metadata: name: "mainfs-ec"
	spec: {
		metadataPool: replicated: size: 3
		dataPools: [{
			name: "default"
			replicated: size: 3
		}, {
			name: "erasurecoded"
			erasureCoded: {
				dataChunks:   3
				codingChunks: 2
			}
		}]
		preserveFilesystemOnDelete: true
		metadataServer: {
			activeCount:   1
			activeStandby: true
		}
	}
}]
