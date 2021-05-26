import (
	"github.com/uhthomas/automata/k8s/pillowtalk"
	"github.com/uhthomas/automata/k8s/pillowtalk/tigera_operator"
	"k8s.io/api/core/v1"
)

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: labels: "app.kubernetes.io/managed-by": "automata"
	}]
}

// items are grouped by dependency requirements, and sorted lexicographically
// where possible.
items:
    tigera_operator.items +

    // requires tigera_operator
    pillowtalk.intallationList.items
