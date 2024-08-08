package nvidia_device_plugin

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "nvidia-device-plugin"
#Namespace: #Name

// renovate: datasource=docker depName=nvcr.io/nvidia/k8s-device-plugin versioning=docker
#Version: "0.16.2"

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
	#ConfigMapList.items,
	#DaemonSetList.items,
	#NamespaceList.items,
	#RuntimeClassList.items,
]
