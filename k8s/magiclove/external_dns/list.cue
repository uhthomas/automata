package external_dns

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "external-dns"
#Namespace: #Name

// renovate: datasource=github-releases depName=kubernetes-sigs/external-dns extractVersion=^v(?<version>.*)$
#Version: "0.20.0"

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
	#CustomResourceDefinitionList.items,
	#DeploymentList.items,
	#ExternalSecretList.items,
	#NamespaceList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
	#VMServiceScrapeList.items,
]
