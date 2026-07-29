package envoy_gateway_system

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "envoy-gateway"
#Namespace: "\(#Name)-system"
#Version:   "1.8.2"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: string | *#Namespace
			labels: {
				"app.kubernetes.io/name":    #Name
				"app.kubernetes.io/version": #Version
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#NamespaceList.items,
	#CertificateList.items,
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#ConfigMapList.items,
	#CustomResourceDefinitionList.items,
	#DeploymentList.items,
	#ExternalSecretList.items,
	#IssuerList.items,
	#MutatingWebhookConfigurationList.items,
	#PasswordList.items,
	#RoleBindingList.items,
	#RoleList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
	#VMServiceScrapeList.items,
]
