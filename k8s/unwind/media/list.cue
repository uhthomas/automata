package media

import (
	"github.com/uhthomas/automata/k8s/unwind/media/bazarr"
	"github.com/uhthomas/automata/k8s/unwind/media/jackett"
	"github.com/uhthomas/automata/k8s/unwind/media/jellyfin"
	"github.com/uhthomas/automata/k8s/unwind/media/jellyseerr"
	"github.com/uhthomas/automata/k8s/unwind/media/radarr"
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

#List: items:
	// The namespace must be created first.
	#NamespaceList.items +
	// Lexicographic ordering.
	#PersistentVolumeClaimList.items +
	bazarr.#List.items +
	jackett.#List.items +
	jellyfin.#List.items +
	jellyseerr.#List.items +
	radarr.#List.items +
	recyclarr.#List.items +
	sonarr.#List.items +
	transmission.#List.items
