package compact

import "k8s.io/api/core/v1"

cephObjectStoreUserList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "ceph.rook.io/v1"
		kind:       "CephObjectStoreUser"
	}]
}

cephObjectStoreUserList: items: [{
	spec: {
		store:       "thanos"
		displayName: "thanos-compact"
	}
}]
