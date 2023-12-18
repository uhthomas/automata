package home_assistant

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "home-assistant"
#Namespace: #Name

// renovate: datasource=github-releases depName=home-assistant/core
#Version: "2023.3.6"

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
	#IngressList.items,
	#NamespaceList.items,
	#ServiceList.items,
	#StatefulSetList.items,
]
