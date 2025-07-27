package envoy_gateway

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "envoy-gateway"
#Namespace: #Name
#Version:   "1.4.2"

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
	#ConfigMapList.items,
	#CustomResourceDefinitionList.items,
	#DeploymentList.items,
	#EnvoyProxyList.items,
	#IssuerList.items,
	#MutatingWebhookConfigurationList.items,
	#NamespaceList.items,
	#RoleBindingList.items,
	#RoleList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
	#VMPodScrapeList.items,
	#VMServiceScrapeList.items,
]
