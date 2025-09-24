package external_secrets

import (
	"list"

	"k8s.io/api/core/v1"
	"github.com/uhthomas/automata/k8s/magiclove/external_secrets/webhook"
)

#Name:      "external-secrets"
#Namespace: #Name
#Version:   "0.20.1"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: #Namespace
			labels: {
				"app.kubernetes.io/name":    string | *#Name
				"app.kubernetes.io/version": #Version
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	webhook.#List.items,
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#CustomResourceDefinitionList.items,
	#DeploymentList.items,
	#NamespaceList.items,
	#RoleBindingList.items,
	#RoleList.items,
	#ServiceAccountList.items,

]
