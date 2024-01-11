package karma

import (
	"list"

	"k8s.io/api/core/v1"

	"github.com/uhthomas/automata/tools"
)

#Name:      "karma"
#Namespace: #Name

// renovate: datasource=github-releases depName=prymitive/karma extractVersion=^v(?<version>.*)$
#Version: "0.116"

_image: tools.#Image & {
	name:   "ghcr.io/prymitive/karma"
	tag:    "0.116"
	digest: "sha256:ddfb0a874d24ca314457a74db351d59db1b9609206f4c01fc272b59a6867d374"
}

_image: tag: #Version

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
