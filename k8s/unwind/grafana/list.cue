package grafana

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "grafana"
#Namespace: #Name
#Version:   "9.3.6"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      #Name
			namespace: #Namespace
			labels: {
				"app.kubernetes.io/name":    #Name
				"app.kubernetes.io/version": #version
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#ConfigMapList.items,
	#NamespaceList.items,
	#SecretProviderClassList.items,
	#ServiceList.items,
	#StatefulSetList.items,
	#VMServiceScrapeList.items,
]
