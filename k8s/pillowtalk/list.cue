import (
	"github.com/uhthomas/automata/k8s/pillowtalk"
	"github.com/uhthomas/automata/k8s/pillowtalk/cert_manager"
	"github.com/uhthomas/automata/k8s/pillowtalk/cloudflared"
	"github.com/uhthomas/automata/k8s/pillowtalk/kube_state_metrics"
	"github.com/uhthomas/automata/k8s/pillowtalk/kube_system"
	"github.com/uhthomas/automata/k8s/pillowtalk/loki"
	"github.com/uhthomas/automata/k8s/pillowtalk/node_exporter"
	"github.com/uhthomas/automata/k8s/pillowtalk/prometheus"
	"github.com/uhthomas/automata/k8s/pillowtalk/prometheus_operator"
	"github.com/uhthomas/automata/k8s/pillowtalk/promtail"
	"github.com/uhthomas/automata/k8s/pillowtalk/rook_ceph"
	"github.com/uhthomas/automata/k8s/pillowtalk/sealed_secrets"
	"github.com/uhthomas/automata/k8s/pillowtalk/thanos"
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
	pillowtalk.installationList.items +


	cert_manager.list.items +
	cluster_issuer_list.cue +

	// none of these really have any dependencies
	cloudflared.list.items +
	kube_system.list.items +
	kube_state_metrics.list.items +
	node_exporter.list.items +
	rook_ceph.list.items +
	sealed_secrets.list.items +

	loki.list.items +
	prometheus_operator.list.items +
	prometheus.list.items +
	thanos.list.items +

	// requires loki
	promtail.list.items
