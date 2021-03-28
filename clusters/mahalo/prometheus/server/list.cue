package server

import "k8s.io/api/core/v1"

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
}

items:
	serviceAccountList.items +
	clusterRoleList.items +
	clusterRoleBindingList.items +
	sealedSecretList.items +
	configMapList.items +
	persistentVolumeClaimList.items +
	serviceList.items +
	deploymentList.items
