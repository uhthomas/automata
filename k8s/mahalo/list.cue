import (
	"github.com/uhthomas/automata/k8s/mahalo"
	"github.com/uhthomas/automata/k8s/mahalo/adya"
	"github.com/uhthomas/automata/k8s/mahalo/cert_manager"
	"github.com/uhthomas/automata/k8s/mahalo/grafana"
	"github.com/uhthomas/automata/k8s/mahalo/ingress_nginx"
	"github.com/uhthomas/automata/k8s/mahalo/io_6f"
	"github.com/uhthomas/automata/k8s/mahalo/io_6f_dev"
	"github.com/uhthomas/automata/k8s/mahalo/kipp"
	"github.com/uhthomas/automata/k8s/mahalo/kipp_dev"
	"github.com/uhthomas/automata/k8s/mahalo/kube_state_metrics"
	"github.com/uhthomas/automata/k8s/mahalo/loki"
	"github.com/uhthomas/automata/k8s/mahalo/oauth2_proxy"
	"github.com/uhthomas/automata/k8s/mahalo/prometheus"
	"github.com/uhthomas/automata/k8s/mahalo/promtail"
	"github.com/uhthomas/automata/k8s/mahalo/rasmus"
	"github.com/uhthomas/automata/k8s/mahalo/sealed_secrets"
	"github.com/uhthomas/automata/k8s/mahalo/tesla_exporter"
	"github.com/uhthomas/automata/k8s/mahalo/thanos"
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
	cert_manager.list.items +
	ingress_nginx.list.items +

	// requires:
	// - cert_manager: Custom Resource Definition
	// - ingress_nginx: HTTP-01 solver
	mahalo.clusterIssuerList.items +

	sealed_secrets.list.items +

	// requires:
	// - cert_manager
	// - ingress_nginx
	// - sealed_secrets
	oauth2_proxy.list.items +

	kube_state_metrics.list.items +

	// requires:
	// - kube_state_metrics
	// - sealed_secrets
	prometheus.list.items +

	// requires:
	// - ingress_nginx
	// - oauth2_proxy
	// - prometheus
	// - sealed_secrets
	thanos.list.items +

	loki.list.items +

	// requires:
	// - loki
	promtail.list.items +

	// requires:
	// - ingress_nginx
	// - loki
	// - oauth2_proxy
	// - sealed_secrets
	// - thanos
	grafana.list.items +

	// requires:
	// - sealed_secrets
	adya.list.items +

	// requires:
	// - ingress_nginx
	io_6f.list.items +
	io_6f_dev.list.items +

	// requires:
	// - ingress_nginx
	// - sealed_secrets
	kipp.list.items +
	kipp_dev.list.items +

	// requires:
	// - sealed_secrets
	tesla_exporter.list.items +

	// requiresL
	// - ingress_nginx
	rasmus.list.items
