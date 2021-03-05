import (
	corev1 "k8s.io/api/core/v1"
	"github.com/uhthomas/automata/clusters/desire"
	"github.com/uhthomas/automata/clusters/desire/adya"
	"github.com/uhthomas/automata/clusters/desire/cert_manager"
	"github.com/uhthomas/automata/clusters/desire/helm_operator"
	"github.com/uhthomas/automata/clusters/desire/ingress_nginx"
	"github.com/uhthomas/automata/clusters/desire/kipp"
	"github.com/uhthomas/automata/clusters/desire/kipp_dev"
	"github.com/uhthomas/automata/clusters/desire/kube_system"
	"github.com/uhthomas/automata/clusters/desire/oauth2_proxy"
	"github.com/uhthomas/automata/clusters/desire/promlens"
	"github.com/uhthomas/automata/clusters/desire/root"
	"github.com/uhthomas/automata/clusters/desire/root_dev"
	"github.com/uhthomas/automata/clusters/desire/telemetry"
	"github.com/uhthomas/automata/clusters/desire/tesla_exporter"
	"github.com/uhthomas/automata/clusters/desire/tesladump"
	"github.com/uhthomas/automata/clusters/desire/thanos"
	"github.com/uhthomas/automata/clusters/desire/vector"
)

corev1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: labels: "app.kubernetes.io/managed-by": "automata"
	}]
}

items: [desire.cluster_issuer] +
	adya.items +
	cert_manager.items +
	helm_operator.items +
	ingress_nginx.items +
	kipp.items +
	kipp_dev.items +
	kube_system.items +
	oauth2_proxy.items +
	promlens.items +
	root.items +
	root_dev.items +
	telemetry.items +
	tesla_exporter.items +
	tesladump.items +
	thanos.items +
	vector.items
