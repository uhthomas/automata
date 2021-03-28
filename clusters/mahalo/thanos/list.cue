package thanos

import (
	"k8s.io/api/core/v1"
	compact "github.com/uhthomas/automata/clusters/mahalo/thanos/compact"
	query "github.com/uhthomas/automata/clusters/mahalo/thanos/query"
	query_frontend "github.com/uhthomas/automata/clusters/mahalo/thanos/query_frontend"
	store "github.com/uhthomas/automata/clusters/mahalo/thanos/store"
)

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *"thanos"
			namespace: "thanos"
			labels: {
				"app.kubernetes.io/name":     "thanos"
				"app.kubernetes.io/instance": "thanos"
				"app.kubernetes.io/version":  "0.18.0"
			}
		}
	}]
}

list: items:
	namespaceList.items +
	sealedSecretList.items +
	compact.list.items +
	query.list.items +
	query_frontend.list.items +
	store.list.items
