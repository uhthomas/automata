package rook_ceph

import cephv1 "github.com/rook/rook/pkg/apis/ceph.rook.io/v1"

#CephBlockPoolList: cephv1.#CephBlockPoolList & {
	apiVersion: "ceph.rook.io/v1"
	kind:       "CephBlockPoolList"
	items: [...{
		apiVersion: "ceph.rook.io/v1"
		kind:       "CephBlockPool"
	}]
}

#CephBlockPoolList: items: [{
	metadata: name: "builtin-mgr"
	spec: {
		name:          ".mgr"
		failureDomain: "osd"
		replicated: {
			// TODO: size: 3
			size:                   2
			requireSafeReplicaSize: true
		}
		deviceClass: "nvme"
		parameters: compression_mode: "none"
		mirroring: enabled:           false
	}
}, {
	metadata: name: "ecpool-nvme"
	spec: {
		failureDomain: "osd"
		erasureCoded: {
			dataChunks:   4
			codingChunks: 6
		}
		deviceClass: "nvme"
		parameters: {
			compression_algorithm: "zstd"
			compression_mode:      "aggressive"
		}
	}
}, {
	metadata: name: "replicapool-nvme"
	spec: {
		failureDomain: "osd"
		// TODO: size: 3
		replicated: size: 2
		deviceClass: "nvme"
		parameters: {
			compression_algorithm: "zstd"
			compression_mode:      "aggressive"
		}
	}
}, {
	metadata: name: "ecpool-hdd"
	spec: {
		failureDomain: "osd"
		erasureCoded: {
			dataChunks:   4
			codingChunks: 6
		}
		deviceClass: "hdd"
		parameters: {
			compression_algorithm: "zstd"
			compression_mode:      "aggressive"
		}
	}
}, {
	metadata: name: "replicapool-hdd"
	spec: {
		failureDomain: "osd"
		replicated: size: 3
		deviceClass: "hdd"
		parameters: {
			compression_algorithm: "zstd"
			compression_mode:      "aggressive"
		}
	}
}]
