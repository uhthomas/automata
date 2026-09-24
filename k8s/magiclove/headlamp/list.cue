package headlamp

import (
	"list"

	"k8s.io/api/core/v1"

	"github.com/uhthomas/automata/tools"
)

#Name:      "headlamp"
#Namespace: #Name

// renovate: datasource=github-releases depName=kubernetes-sigs/headlamp extractVersion=^v(?<version>.*)$
#Version: "0.43.0"

_image: tools.#Image & {
	name:   "ghcr.io/headlamp-k8s/headlamp"
	tag:    "v0.45.0"
	digest: "sha256:db3f0e0fc58d358d41daa3fe7fc852437552c7ee873c3645470f7b86a8e0db49"
}

_image: tag: "v\(#Version)"

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
	#CiliumNetworkPolicyList.items,
	#ClusterRoleBindingList.items,
	#DeploymentList.items,
	#ListenerSetList.items,
	#HTTPRouteList.items,
	#KanidmOAuth2ClientList.items,
	#NamespaceList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
]
