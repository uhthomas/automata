package thanos

import (
	"k8s.io/api/core/v1"
	compact "github.com/uhthomas/automata/k8s/pillowtalk/thanos/compact"
	query "github.com/uhthomas/automata/k8s/pillowtalk/thanos/query"
	query_frontend "github.com/uhthomas/automata/k8s/pillowtalk/thanos/query_frontend"
	store "github.com/uhthomas/automata/k8s/pillowtalk/thanos/store"
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
				"app.kubernetes.io/version":  "0.21.0"
			}
		}
	}]
}

list: items:
	namespaceList.items +
	objectBucketClaimList.items +
	compact.list.items +
	query.list.items +
	query_frontend.list.items +
	store.list.items
