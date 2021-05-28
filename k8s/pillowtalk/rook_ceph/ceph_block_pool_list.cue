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
	metadata: name: "replicapool"
	spec: {
		failureDomain: "host"
		replicated: {
			size: 3
			// Disallow setting pool with replica 1, this could lead to data loss without recovery.
			// Make sure you're *ABSOLUTELY CERTAIN* that is what you want
			requireSafeReplicaSize: true
		}
	}
	// gives a hint (%) to Ceph in terms of expected consumption of the total cluster capacity of a given pool
	// for more info: https://docs.ceph.com/docs/master/rados/operations/placement-groups/#specifying-expected-pool-size
	//targetSizeRatio: .5
}]
