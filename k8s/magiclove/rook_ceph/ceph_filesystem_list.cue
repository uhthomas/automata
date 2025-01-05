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
	metadata: name: "main"
	spec: {
		metadataPool: {
			failureDomain: "osd"
			replicated: size: 3
			deviceClass: "nvme"
		}
		dataPools: [{
			name:          "default"
			failureDomain: "osd"
			replicated: size: 3
			deviceClass: "nvme"
		}, {
			name:          "nvme-ec"
			failureDomain: "osd"
			erasureCoded: {
				dataChunks:   4
				codingChunks: 2
			}
			deviceClass: "nvme"
		}]
		preserveFilesystemOnDelete: true
		metadataServer: {
			activeCount:   1
			activeStandby: true
		}
	}
}]
