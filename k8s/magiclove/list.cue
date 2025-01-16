import (
	"list"

	"github.com/uhthomas/automata/k8s/magiclove"
	"github.com/uhthomas/automata/k8s/magiclove/backup"
	"github.com/uhthomas/automata/k8s/magiclove/cert_manager_csi_driver"
	"github.com/uhthomas/automata/k8s/magiclove/cert_manager"
	"github.com/uhthomas/automata/k8s/magiclove/cilium"
	"github.com/uhthomas/automata/k8s/magiclove/cilium_secrets"
	"github.com/uhthomas/automata/k8s/magiclove/dcgm_exporter"
	"github.com/uhthomas/automata/k8s/magiclove/default"
	"github.com/uhthomas/automata/k8s/magiclove/emqx"
	"github.com/uhthomas/automata/k8s/magiclove/emqx_exporter"
	"github.com/uhthomas/automata/k8s/magiclove/external_dns"
	"github.com/uhthomas/automata/k8s/magiclove/external_secrets"
	// "github.com/uhthomas/automata/k8s/magiclove/fluent_bit"
	"github.com/uhthomas/automata/k8s/magiclove/frigate"
	"github.com/uhthomas/automata/k8s/magiclove/fstrim"
	"github.com/uhthomas/automata/k8s/magiclove/gateway_api"
	"github.com/uhthomas/automata/k8s/magiclove/grafana"
	"github.com/uhthomas/automata/k8s/magiclove/grafana_operator"
	"github.com/uhthomas/automata/k8s/magiclove/home_assistant"
	"github.com/uhthomas/automata/k8s/magiclove/karma"
	"github.com/uhthomas/automata/k8s/magiclove/kube_state_metrics"
	"github.com/uhthomas/automata/k8s/magiclove/kube_system"
	"github.com/uhthomas/automata/k8s/magiclove/linkding"
	"github.com/uhthomas/automata/k8s/magiclove/media"
	"github.com/uhthomas/automata/k8s/magiclove/metrics_server"
	"github.com/uhthomas/automata/k8s/magiclove/minecraft"
	"github.com/uhthomas/automata/k8s/magiclove/node_exporter"
	// "github.com/uhthomas/automata/k8s/magiclove/node_feature_discovery"
	"github.com/uhthomas/automata/k8s/magiclove/node_problem_detector"
	"github.com/uhthomas/automata/k8s/magiclove/nvidia_device_plugin"
	"github.com/uhthomas/automata/k8s/magiclove/onepassword_connect"
	"github.com/uhthomas/automata/k8s/magiclove/ping_exporter"
	"github.com/uhthomas/automata/k8s/magiclove/rook_ceph"
	"github.com/uhthomas/automata/k8s/magiclove/scrutiny"
	"github.com/uhthomas/automata/k8s/magiclove/smartctl_exporter"
	"github.com/uhthomas/automata/k8s/magiclove/snapshot_controller"
	"github.com/uhthomas/automata/k8s/magiclove/speedtest_exporter"
	"github.com/uhthomas/automata/k8s/magiclove/spire"
	"github.com/uhthomas/automata/k8s/magiclove/thomas"
	// "github.com/uhthomas/automata/k8s/magiclove/trivy_system"
	"github.com/uhthomas/automata/k8s/magiclove/vector"
	"github.com/uhthomas/automata/k8s/magiclove/victoria_logs"
	"github.com/uhthomas/automata/k8s/magiclove/vm_operator"
	"github.com/uhthomas/automata/k8s/magiclove/vm"
	"github.com/uhthomas/automata/k8s/magiclove/volsync_system"
	"github.com/uhthomas/automata/k8s/magiclove/wireguard"
	"github.com/uhthomas/automata/k8s/magiclove/wireguard_operator"
	"k8s.io/api/core/v1"
)

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
}

_#KindWeight: {
	kind:   string | *"?"
	weight: [
		if kind == "CustomResourceDefinition" {2},
		if kind == "Namespace" {1},
		if kind == "PersistentVolume" {0},
		-1,
	][0]
}

#List: items: list.Sort(list.Concat(_items), {
	x:    _
	y:    _
	less: (_#KindWeight & {kind: x.kind}).weight > (_#KindWeight & {kind: y.kind}).weight
})

_items: [
	magiclove.#ApplySetList.items,
	magiclove.#ClusterIssuerList.items,
	magiclove.#ClusterSecretStoreList.items,
	magiclove.#CustomResourceDefinitionList.items,
	magiclove.#GatewayClassList.items,
	backup.#List.items,
	cert_manager_csi_driver.#List.items,
	cert_manager.#List.items,
	cilium.#List.items,
	cilium_secrets.#List.items,
	dcgm_exporter.#List.items,
	default.#List.items,
	emqx.#List.items,
	emqx_exporter.#List.items,
	external_dns.#List.items,
	external_secrets.#List.items,
	// fluent_bit.#List.items,
	frigate.#List.items,
	fstrim.#List.items,
	gateway_api.#List.items,
	grafana.#List.items,
	grafana_operator.#List.items,
	home_assistant.#List.items,
	karma.#List.items,
	kube_state_metrics.#List.items,
	kube_system.#List.items,
	linkding.#List.items,
	media.#List.items,
	metrics_server.#List.items,
	// minecraft.#List.items,
	node_exporter.#List.items,
	// node_feature_discovery.#List.items,
	// node_problem_detector.#List.items,
	nvidia_device_plugin.#List.items,
	onepassword_connect.#List.items,
	ping_exporter.#List.items,
	rook_ceph.#List.items,
	scrutiny.#List.items,
	smartctl_exporter.#List.items,
	snapshot_controller.#List.items,
	speedtest_exporter.#List.items,
	spire.#List.items,
	thomas.#List.items,
	// trivy_system.#List.items,
	// vector.#List.items,
	// victoria_logs.#List.items,
	vm_operator.#List.items,
	vm.#List.items,
	// volsync_system.#List.items,
	wireguard.#List.items,
	wireguard_operator.#List.items,
]

#List
