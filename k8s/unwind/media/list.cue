package media

import (
	"list"

	"github.com/uhthomas/automata/k8s/unwind/media/bazarr"
	"github.com/uhthomas/automata/k8s/unwind/media/jellyfin"
	"github.com/uhthomas/automata/k8s/unwind/media/jellyseerr"
	"github.com/uhthomas/automata/k8s/unwind/media/lidarr"
	"github.com/uhthomas/automata/k8s/unwind/media/prowlarr"
	"github.com/uhthomas/automata/k8s/unwind/media/radarr"
	"github.com/uhthomas/automata/k8s/unwind/media/readarr"
	"github.com/uhthomas/automata/k8s/unwind/media/recyclarr"
	"github.com/uhthomas/automata/k8s/unwind/media/sonarr"
	"github.com/uhthomas/automata/k8s/unwind/media/transmission"
	"k8s.io/api/core/v1"
)

#Name:      "media"
#Namespace: #Name

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{metadata: namespace: #Namespace}]

}

#List: items: list.Concat(_items)

_items: [
	// The namespace must be created first.
	#NamespaceList.items,

	// Lexicographic ordering.
	#PersistentVolumeClaimList.items,
	bazarr.#List.items,
	jellyfin.#List.items,
	jellyseerr.#List.items,
	lidarr.#List.items,
	prowlarr.#List.items,
	radarr.#List.items,
	readarr.#List.items,
	recyclarr.#List.items,
	sonarr.#List.items,
	transmission.#List.items,
]
