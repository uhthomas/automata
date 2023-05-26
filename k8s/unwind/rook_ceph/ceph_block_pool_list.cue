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
		failureDomain: "host"
		replicated: {
			size:                   3
			requireSafeReplicaSize: true
		}
		deviceClass: "hdd"
		parameters: compression_mode: "none"
		mirroring: enabled:           false
	}
}, {
	metadata: name: "ecpool"
	spec: {
		erasureCoded: {
			dataChunks:   3
			codingChunks: 2
		}
		deviceClass: "hdd"
	}
}, {
	metadata: name: "replicapool"
	spec: {
		failureDomain: "host"
		replicated: size: 3
		deviceClass: "hdd"
	}
}]
