package nvidia_gpu_operator

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "nvidia-gpu-operator"
#Namespace: #Name

// renovate: datasource=github-releases depName=NVIDIA/gpu-operator extractVersion=^v(?<version>.*)$
#Version: "23.9.1"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: #Namespace
			labels: {
				"app.kubernetes.io/name":    #Name
				"app.kubernetes.io/version": #Version
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#ClusterPolicyList.items,
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#CustomResourceDefinitionList.items,
	#DeploymentList.items,
	#NamespaceList.items,
	#ServiceAccountList.items,
]
