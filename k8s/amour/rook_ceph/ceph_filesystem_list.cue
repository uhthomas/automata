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

#CephFilesystemList: items: [{
	metadata: name: "cephfs-hdd"
	spec: {
		metadataPool: {
			failureDomain: "osd"
			// TODO: 3
			replicated: size: 2
			deviceClass: "nvme"
		}
		dataPools: [{
			name:          "default"
			failureDomain: "osd"
			// TODO: 3
			replicated: size: 2
			deviceClass: "nvme"
		}, {
			name:          "erasurecoded"
			failureDomain: "osd"
			erasureCoded: {
				dataChunks:   4
				codingChunks: 2
			}
			deviceClass: "hdd"
		}]
		preserveFilesystemOnDelete: true
		metadataServer: {
			activeCount:   1
			activeStandby: true
		}
	}
}]
