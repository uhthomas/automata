package thanos

import (
	corev1 "k8s.io/api/core/v1"
	compact "github.com/uhthomas/automata/clusters/desire/thanos/compact"
	query "github.com/uhthomas/automata/clusters/desire/thanos/query"
	query_frontend "github.com/uhthomas/automata/clusters/desire/thanos/query_frontend"
	store "github.com/uhthomas/automata/clusters/desire/thanos/store"
)

corev1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items:      [
			namespace,
			sealed_secret,
	] +
		compact.items +
		query.items +
		query_frontend.items +
		store.items
}
