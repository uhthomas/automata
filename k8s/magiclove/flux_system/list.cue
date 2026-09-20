package flux_system

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "flux"
#Namespace: "\(#Name)-system"

// renovate: datasource=github-releases depName=fluxcd/flux2 extractVersion=^v(?<version>.*)$
#Version: "2.9.3"

// These are the component versions shipped by Flux #Version.
#SourceControllerVersion:    "1.9.3"
#KustomizeControllerVersion: "1.9.4"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: string | *#Namespace
			labels: {
				"app.kubernetes.io/instance": #Namespace
				"app.kubernetes.io/part-of":  #Name
				"app.kubernetes.io/version":  "v\(#Version)"
			}
			// Keep every bootstrap object if a future Flux Kustomization
			// changes its inventory or is removed.
			annotations: "kustomize.toolkit.fluxcd.io/prune": "disabled"
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#CustomResourceDefinitionList.items,
	#DeploymentList.items,
	#KustomizationList.items,
	#NamespaceList.items,
	#NetworkPolicyList.items,
	#OCIRepositoryList.items,
	#ResourceQuotaList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
	#VMPodScrapeList.items,
	#VMRuleList.items,
]
