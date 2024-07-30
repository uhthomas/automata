import (
	"list"

	"github.com/uhthomas/automata/k8s/amour"
	"github.com/uhthomas/automata/k8s/amour/backup"
	"github.com/uhthomas/automata/k8s/amour/cert_manager_csi_driver"
	"github.com/uhthomas/automata/k8s/amour/cert_manager"
	"github.com/uhthomas/automata/k8s/amour/cilium"
	"github.com/uhthomas/automata/k8s/amour/dcgm_exporter"
	"github.com/uhthomas/automata/k8s/amour/default"
	"github.com/uhthomas/automata/k8s/amour/emqx"
	"github.com/uhthomas/automata/k8s/amour/emqx_exporter"
	"github.com/uhthomas/automata/k8s/amour/external_dns"
	"github.com/uhthomas/automata/k8s/amour/external_secrets"
	// "github.com/uhthomas/automata/k8s/amour/fluent_bit"
	"github.com/uhthomas/automata/k8s/amour/frigate"
	"github.com/uhthomas/automata/k8s/amour/grafana"
	"github.com/uhthomas/automata/k8s/amour/grafana_operator"
	"github.com/uhthomas/automata/k8s/amour/home_assistant"
	"github.com/uhthomas/automata/k8s/amour/karma"
	"github.com/uhthomas/automata/k8s/amour/kube_state_metrics"
	"github.com/uhthomas/automata/k8s/amour/kube_system"
	"github.com/uhthomas/automata/k8s/amour/media"
	"github.com/uhthomas/automata/k8s/amour/metrics_server"
	"github.com/uhthomas/automata/k8s/amour/minecraft"
	"github.com/uhthomas/automata/k8s/amour/node_exporter"
	// "github.com/uhthomas/automata/k8s/amour/node_feature_discovery"
	"github.com/uhthomas/automata/k8s/amour/node_problem_detector"
	"github.com/uhthomas/automata/k8s/amour/nvidia_device_plugin"
	"github.com/uhthomas/automata/k8s/amour/onepassword_connect"
	"github.com/uhthomas/automata/k8s/amour/ping_exporter"
	"github.com/uhthomas/automata/k8s/amour/rook_ceph"
	"github.com/uhthomas/automata/k8s/amour/scrutiny"
	"github.com/uhthomas/automata/k8s/amour/smartctl_exporter"
	"github.com/uhthomas/automata/k8s/amour/snapshot_controller"
	"github.com/uhthomas/automata/k8s/amour/speedtest_exporter"
	"github.com/uhthomas/automata/k8s/amour/tailscale"
	"github.com/uhthomas/automata/k8s/amour/thomas"
	// "github.com/uhthomas/automata/k8s/amour/trivy_system"
	"github.com/uhthomas/automata/k8s/amour/vector"
	"github.com/uhthomas/automata/k8s/amour/victoria_logs"
	"github.com/uhthomas/automata/k8s/amour/vm_operator"
	"github.com/uhthomas/automata/k8s/amour/vm"
	"github.com/uhthomas/automata/k8s/amour/volsync_system"
	"github.com/uhthomas/automata/k8s/amour/wireguard"
	"github.com/uhthomas/automata/k8s/amour/wireguard_operator"
	"k8s.io/api/core/v1"
)

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
}

_#KindWeight: {
	kind:   string | *"?"
	weight: [
		if kind == "CustomResourceDefinition" {1},
		if kind == "Namespace" {0},
		-1,
	][0]
}

#List: items: list.Sort(list.Concat(_items), {
	x:    _
	y:    _
	less: (_#KindWeight & {kind: x.kind}).weight > (_#KindWeight & {kind: y.kind}).weight
})

_items: [
	amour.#ApplySetList.items,
	amour.#ClusterSecretStoreList.items,
	amour.#CustomResourceDefinitionList.items,
	backup.#List.items,
	cert_manager_csi_driver.#List.items,
	cert_manager.#List.items,
	cilium.#List.items,
	dcgm_exporter.#List.items,
	default.#List.items,
	emqx.#List.items,
	emqx_exporter.#List.items,
	external_dns.#List.items,
	external_secrets.#List.items,
	// fluent_bit.#List.items,
	frigate.#List.items,
	grafana.#List.items,
	grafana_operator.#List.items,
	home_assistant.#List.items,
	karma.#List.items,
	kube_state_metrics.#List.items,
	kube_system.#List.items,
	media.#List.items,
	metrics_server.#List.items,
	minecraft.#List.items,
	node_exporter.#List.items,
	// node_feature_discovery.#List.items,
	node_problem_detector.#List.items,
	nvidia_device_plugin.#List.items,
	onepassword_connect.#List.items,
	ping_exporter.#List.items,
	rook_ceph.#List.items,
	scrutiny.#List.items,
	smartctl_exporter.#List.items,
	snapshot_controller.#List.items,
	speedtest_exporter.#List.items,
	tailscale.#List.items,
	thomas.#List.items,
	// trivy_system.#List.items,
	vector.#List.items,
	victoria_logs.#List.items,
	vm_operator.#List.items,
	vm.#List.items,
	volsync_system.#List.items,
	wireguard.#List.items,
	wireguard_operator.#List.items,
]

#List
