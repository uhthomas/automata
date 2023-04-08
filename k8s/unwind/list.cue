import (
	"list"

	"github.com/uhthomas/automata/k8s/unwind/cert_manager_csi_driver"
	"github.com/uhthomas/automata/k8s/unwind/cert_manager"
	"github.com/uhthomas/automata/k8s/unwind/cockroach_operator_system"
	"github.com/uhthomas/automata/k8s/unwind/csi_snapshotter"
	"github.com/uhthomas/automata/k8s/unwind/grafana_agent_operator"
	"github.com/uhthomas/automata/k8s/unwind/grafana_agent"
	"github.com/uhthomas/automata/k8s/unwind/grafana"
	"github.com/uhthomas/automata/k8s/unwind/home_assistant"
	"github.com/uhthomas/automata/k8s/unwind/intel_gpu_plugin"
	"github.com/uhthomas/automata/k8s/unwind/kube_state_metrics"
	"github.com/uhthomas/automata/k8s/unwind/loki"
	"github.com/uhthomas/automata/k8s/unwind/media"
	"github.com/uhthomas/automata/k8s/unwind/mimir"
	"github.com/uhthomas/automata/k8s/unwind/node_feature_discovery"
	"github.com/uhthomas/automata/k8s/unwind/node_problem_detector"
	"github.com/uhthomas/automata/k8s/unwind/rook_ceph"
	"github.com/uhthomas/automata/k8s/unwind/secrets_store_csi_driver"
	"github.com/uhthomas/automata/k8s/unwind/snapshot_controller"
	"github.com/uhthomas/automata/k8s/unwind/tailscale"
	"github.com/uhthomas/automata/k8s/unwind/vault_config_operator"
	"github.com/uhthomas/automata/k8s/unwind/vault_csi_provider"
	"github.com/uhthomas/automata/k8s/unwind/vault"
	"k8s.io/api/core/v1"
)

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{metadata: labels: "app.kubernetes.io/managed-by": "automata"}]
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
	cert_manager_csi_driver.#List.items,
	cert_manager.#List.items,
	cockroach_operator_system.#List.items,
	csi_snapshotter.#List.items,
	grafana_agent_operator.#List.items,
	grafana_agent.#List.items,
	grafana.#List.items,
	home_assistant.#List.items,
	intel_gpu_plugin.#List.items,
	kube_state_metrics.#List.items,
	loki.#List.items,
	media.#List.items,
	mimir.#List.items,
	node_feature_discovery.#List.items,
	node_problem_detector.#List.items,
	rook_ceph.#List.items,
	secrets_store_csi_driver.#List.items,
	snapshot_controller.#List.items,
	tailscale.#List.items,
	vault_config_operator.#List.items,
	vault_csi_provider.#List.items,
	vault.#List.items,
]

#List
