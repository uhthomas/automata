package webhook

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "external-secrets-webhook"
#Namespace: "external-secrets"
#Version:   "0.9.5"

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
	#CertificateList.items,
	#DeploymentList.items,
	#IssuerList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
	#ValidatingWebhookConfigurationList.items,
]
