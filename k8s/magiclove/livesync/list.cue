package livesync

import (
	"list"

	"k8s.io/api/core/v1"

	"github.com/uhthomas/automata/tools"
)

#Name:      "couchdb"
#Namespace: "livesync"

// renovate: datasource=docker depName=couchdb
#Version: "3.5.3"

_image: tools.#Image & {
	name:   "couchdb"
	tag:    "3.5.3"
	digest: "sha256:907eab5b7e55ab7cfd241d39b90b2a335ea40bef82acee5a37388c08bf201dda"
}

_image: tag: #Version

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
	#DeploymentList.items,
	#ExternalSecretList.items,
	#ListenerSetList.items,
	#HTTPRouteList.items,
	#NamespaceList.items,
	#PasswordList.items,
	#PersistentVolumeClaimList.items,
	#ServiceList.items,
]
