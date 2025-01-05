package media

import (
	"list"

	// "github.com/uhthomas/automata/k8s/magiclove/media/bazarr"
	"github.com/uhthomas/automata/k8s/magiclove/media/jellyfin"
	"github.com/uhthomas/automata/k8s/magiclove/media/jellyseerr"
	// "github.com/uhthomas/automata/k8s/magiclove/media/lidarr"
	"github.com/uhthomas/automata/k8s/magiclove/media/prowlarr"
	"github.com/uhthomas/automata/k8s/magiclove/media/radarr"
	// "github.com/uhthomas/automata/k8s/magiclove/media/readarr"
	"github.com/uhthomas/automata/k8s/magiclove/media/recyclarr"
	"github.com/uhthomas/automata/k8s/magiclove/media/sabnzbd"
	"github.com/uhthomas/automata/k8s/magiclove/media/sonarr"
	// "github.com/uhthomas/automata/k8s/magiclove/media/tdarr"
	// "github.com/uhthomas/automata/k8s/magiclove/media/transmission"
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
	#NamespaceList.items,
	#PersistentVolumeClaimList.items,
	#PersistentVolumeList.items,
	// bazarr.#List.items,
	jellyfin.#List.items,
	jellyseerr.#List.items,
	// lidarr.#List.items,
	prowlarr.#List.items,
	radarr.#List.items,
	// readarr.#List.items,
	recyclarr.#List.items,
	sabnzbd.#List.items,
	sonarr.#List.items,
	// tdarr.#List.items,
	// transmission.#List.items,
]
