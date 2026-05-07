package kaniop

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "kaniop"
#Namespace: #Name

// renovate: datasource=docker depName=ghcr.io/pando85/kaniop
#Version: "0.6.1"

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
	#CertificateList.items,
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#CustomResourceDefinitionList.items,
	#DeploymentList.items,
	#IssuerList.items,
	#NamespaceList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
	#ValidatingAdmissionPolicyList.items,
	#ValidatingAdmissionPolicyBindingList.items,
	#ValidatingWebhookConfigurationList.items,
	#VMRuleList.items,
	#VMServiceScrapeList.items,
]
