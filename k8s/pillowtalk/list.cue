import (
	"github.com/uhthomas/automata/k8s/pillowtalk"
	"github.com/uhthomas/automata/k8s/pillowtalk/kube_state_metrics"
	"github.com/uhthomas/automata/k8s/pillowtalk/kube_system"
	"github.com/uhthomas/automata/k8s/pillowtalk/prometheus"
	"github.com/uhthomas/automata/k8s/pillowtalk/prometheus_operator"
	"github.com/uhthomas/automata/k8s/pillowtalk/rook_ceph"
	"github.com/uhthomas/automata/k8s/pillowtalk/sealed_secrets"
	"github.com/uhthomas/automata/k8s/pillowtalk/tigera_operator"
	"k8s.io/api/core/v1"
)

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{metadata: labels: "app.kubernetes.io/managed-by": "automata"}]
}

// items are grouped by dependency requirements, and sorted lexicographically
// where possible.
items:
	tigera_operator.list.items +

	// requires tigera_operator
	pillowtalk.installationList.items +

	kube_system.list.items +

	kube_state_metrics.list.items +

	sealed_secrets.list.items +

	rook_ceph.list.items +

	prometheus_operator.list.items +
	prometheus.list.items
