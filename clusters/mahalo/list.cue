import (
	"github.com/uhthomas/automata/clusters/mahalo"
	"github.com/uhthomas/automata/clusters/mahalo/cert_manager"
	"github.com/uhthomas/automata/clusters/mahalo/grafana"
	"github.com/uhthomas/automata/clusters/mahalo/ingress_nginx"
	"github.com/uhthomas/automata/clusters/mahalo/io_6f_dev"
	"github.com/uhthomas/automata/clusters/mahalo/kube_state_metrics"
	"github.com/uhthomas/automata/clusters/mahalo/loki"
	"github.com/uhthomas/automata/clusters/mahalo/oauth2_proxy"
	"github.com/uhthomas/automata/clusters/mahalo/prometheus"
	"github.com/uhthomas/automata/clusters/mahalo/promtail"
	"github.com/uhthomas/automata/clusters/mahalo/sealed_secrets"
	"github.com/uhthomas/automata/clusters/mahalo/thanos"
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
	cert_manager.items +
	ingress_nginx.items +

	// requires:
	// - cert_manager: Custom Resource Definition
	// - ingress_nginx: HTTP-01 solver
	mahalo.cluster_issuer +

	sealed_secrets.items +

	// requires:
	// cert_manager
	// - ingress_nginx
	// - sealed_secrets
	oauth2_proxy.items +

	kube_state_metrics.items +

	// requires:
	// - kube_state_metrics
	// - sealed_secrets
	prometheus.items +

	// requires:
	// - ingress_nginx
	// - oauth2_proxy
	// - prometheus
	// - sealed_secrets
	thanos.items +

	loki.items +

	// requires:
	// - loki
	promtail.items +

	// requires:
	// - ingress_nginx
	// - loki
	// - oauth2_proxy
	// - sealed_secrets
	// - thanos
	grafana.items +

	// requires:
	// - ingress_nginx
	io_6f_dev.items
