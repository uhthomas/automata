package gateway_api

import "k8s.io/api/core/v1"

#Name: "gateway-api"

#Version: "1.1.0"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			labels: {
				"app.kubernetes.io/name":    #Name
				"app.kubernetes.io/version": #Version
			}
		}
	}]
}

#List: items: #CustomResourceDefinitionList.items
