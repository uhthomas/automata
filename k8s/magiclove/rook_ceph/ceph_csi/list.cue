package ceph_csi

import (
	"list"

	"k8s.io/api/core/v1"
)

#Namespace: "rook-ceph"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
}

#List: items: list.Concat([
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#RoleBindingList.items,
	#RoleList.items,
	#ServiceAccountList.items,
])
