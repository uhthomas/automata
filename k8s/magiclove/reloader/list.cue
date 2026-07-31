package reloader

import (
	"list"

	"k8s.io/api/core/v1"

	"github.com/uhthomas/automata/tools"
)

#Name:      "reloader"
#Namespace: #Name

// renovate: datasource=helm depName=reloader registryUrl=https://stakater.github.io/stakater-charts
#ChartVersion: "2.2.12"

// renovate: datasource=github-releases depName=stakater/Reloader extractVersion=^v(?<version>.*)$
#Version: "1.4.17"

_image: tools.#Image & {
	name:   "ghcr.io/stakater/reloader"
	tag:    "v\(#Version)"
	digest: "sha256:6346ad857388731950498be1c34caab931cbb8ae05330081c66f38ff551c5f21"
}

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
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#DeploymentList.items,
	#NamespaceList.items,
	#RoleBindingList.items,
	#RoleList.items,
	#ServiceAccountList.items,
	#VMPodScrapeList.items,
]
