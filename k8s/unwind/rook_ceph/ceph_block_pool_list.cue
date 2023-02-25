package rook_ceph

import "k8s.io/api/core/v1"

cephBlockPoolList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "ceph.rook.io/v1"
		kind:       "CephBlockPool"
	}]
}

cephBlockPoolList: items: [{
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
