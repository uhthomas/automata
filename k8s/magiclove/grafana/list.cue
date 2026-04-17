package grafana

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "grafana"
#Namespace: #Name

// renovate: datasource=github-releases depName=grafana/grafana extractVersion=^v(?<version>.*)$
#Version: "13.0.1"

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
	#ExternalSecretList.items,
	#GatewayList.items,
	#GrafanaDashboardList.items,
	#GrafanaDatasourceList.items,
	#GrafanaList.items,
	#KanidmOAuth2ClientList.items,
	#HTTPRouteList.items,
	#NamespaceList.items,
	#PersistentVolumeClaimList.items,
	#PersistentVolumeList.items,
	#ServiceList.items,
	#StatefulSetList.items,
	#VMServiceScrapeList.items,
]
