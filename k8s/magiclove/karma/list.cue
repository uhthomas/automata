package karma

import (
	"list"

	"k8s.io/api/core/v1"

	"github.com/uhthomas/automata/tools"
)

#Name:      "karma"
#Namespace: #Name

// renovate: datasource=github-releases depName=prymitive/karma extractVersion=^v(?<version>.*)$
#Version: "0.129"

_image: tools.#Image & {
	name:   "ghcr.io/prymitive/karma"
	tag:    "0.129"
	digest: "sha256:e3982b38c6a178777aa2a49286a56bf04edc1850e7542cc3d9d55307738b8c64"
}

_image: tag: #Version

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
	// #CiliumNetworkPolicyList.items,
	#DeploymentList.items,
	#GatewayList.items,
	#HTTPRouteList.items,
	#NamespaceList.items,
	#ServiceList.items,
]
