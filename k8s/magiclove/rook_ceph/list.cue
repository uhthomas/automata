package rook_ceph

import (
	"list"

	"github.com/uhthomas/automata/k8s/magiclove/rook_ceph/ceph_csi"
	"k8s.io/api/core/v1"
)

#Name:      "rook-ceph"
#Namespace: #Name
#Version:   "1.18.1"

#CephVersion: "19.2.3"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: #Namespace
			labels: {
				"app.kubernetes.io/name":      string | *#Name
				"app.kubernetes.io/instance":  #Name
				"app.kubernetes.io/version":   #Version
				"app.kubernetes.io/component": string | *#Name
			}
		}
	}]
}

#List: items: list.Concat([
	ceph_csi.#List.items,
	#CephBlockPoolList.items,
	#CephClusterList.items,
	#CephFilesystemList.items,
	#CephObjectStoreList.items,
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#ConfigMapList.items,
	#CustomResourceDefinitionList.items,
	#DeploymentList.items,
	#GatewayList.items,
	#HTTPRouteList.items,
	#NamespaceList.items,
	#RoleBindingList.items,
	#RoleList.items,
	#ServiceAccountList.items,
	#StorageClassList.items,
	#VMRuleList.items,
	#VMServiceScrapeList.items,
	#VolumeSnapshotClassList.items,
])
