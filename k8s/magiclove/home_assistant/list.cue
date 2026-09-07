package home_assistant

import (
	"list"

	"github.com/uhthomas/automata/k8s/magiclove/home_assistant/piper"
	"github.com/uhthomas/automata/k8s/magiclove/home_assistant/whisper"
	"k8s.io/api/core/v1"
)

#Name:      "home-assistant"
#Namespace: #Name

// renovate: datasource=github-releases depName=home-assistant/core
#Version: "2025.12.5"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: #Namespace
			labels: {
				"app.kubernetes.io/name":    string | *#Name
				"app.kubernetes.io/version": string | *#Version
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#GatewayList.items,
	#HTTPRouteList.items,
	#NamespaceList.items,
	#PersistentVolumeClaimList.items,
	#PersistentVolumeList.items,
	#ServiceList.items,
	#StatefulSetList.items,
	#VMServiceScrapeList.items,
	piper.#List.items,
	whisper.#List.items,
]
