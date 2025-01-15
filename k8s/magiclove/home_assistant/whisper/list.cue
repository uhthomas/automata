package whisper

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name: "whisper"

// renovate: datasource=docker depName=rhasspy/wyoming-whisper
#Version: "2.4.0"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name: #Name
			labels: {
				"app.kubernetes.io/name":    #Name
				"app.kubernetes.io/version": #Version
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#ServiceList.items,
	#StatefulSetList.items,
]
