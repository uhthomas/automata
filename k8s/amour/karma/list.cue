package karma

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "karma"
#Namespace: #Name

// renovate: datasource=github-releases depName=prymitive/karma extractVersion=^v(?<version>.*)$
#Version: "0.116"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      #Name
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
	#CiliumNetworkPolicyList.items,
	#DeploymentList.items,
	#IngressList.items,
	#NamespaceList.items,
	#ServiceList.items,
]
