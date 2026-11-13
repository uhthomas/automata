package gateway_api

import (
	"list"
	"k8s.io/api/core/v1"
)

#Name: "gateway-api"

#Version: "1.6.1"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: labels: {
			"app.kubernetes.io/name":    #Name
			"app.kubernetes.io/version": #Version
		}
	}]
}

#List: items: list.Concat([
	#CustomResourceDefinitionList.items,
	#ValidatingAdmissionPolicyList.items,
	#ValidatingAdmissionPolicyBindingList.items,
])
