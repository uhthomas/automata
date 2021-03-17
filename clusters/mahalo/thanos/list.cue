package thanos

import (
	"k8s.io/api/core/v1"
	compact "github.com/uhthomas/automata/clusters/desire/thanos/compact"
	query "github.com/uhthomas/automata/clusters/desire/thanos/query"
	query_frontend "github.com/uhthomas/automata/clusters/desire/thanos/query_frontend"
	store "github.com/uhthomas/automata/clusters/desire/thanos/store"
)

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			namespace: "thanos"
			labels: {
				"app.kubernetes.io/name":     "thanos"
				"app.kubernetes.io/instance": "thanos"
				"app.kubernetes.io/version":  "0.18.0"
			}
		}
	}]
}

items:
	namespace +
	sealed_secret +
	compact.items +
	query.items +
	query_frontend.items +
	store.items
