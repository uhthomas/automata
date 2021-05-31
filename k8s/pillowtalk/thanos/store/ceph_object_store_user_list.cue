package store

import "k8s.io/api/core/v1"

cephObjectStoreUserList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "objectbucket.io/v1alpha1"
		kind:       "CephObjectStoreUser"
	}]
}

cephObjectStoreUserList: items: [{
	store:       "thanos"
	displayName: "thanos-store"
}]
