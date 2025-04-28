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
			size:                   3
			requireSafeReplicaSize: true
		}
		deviceClass: "nvme"
		parameters: compression_mode: "none"
		enableRBDStats: true
		mirroring: enabled: false
	}
}, {
	metadata: name: "ecpool-nvme"
	spec: {
		failureDomain: "osd"
		erasureCoded: {
			dataChunks:   4
			codingChunks: 2
		}
		deviceClass: "nvme"
		parameters: compression_mode: "none"
		enableRBDStats: true
	}
}, {
	metadata: name: "replicapool-nvme"
	spec: {
		failureDomain: "osd"
		replicated: size: 3
		deviceClass: "nvme"
		parameters: compression_mode: "none"
		enableRBDStats: true
	}
}]
