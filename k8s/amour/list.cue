import (
	"list"

	"github.com/uhthomas/automata/k8s/amour"
	"github.com/uhthomas/automata/k8s/amour/cert_manager_csi_driver"
	"github.com/uhthomas/automata/k8s/amour/cert_manager"
	"github.com/uhthomas/automata/k8s/amour/cilium"
	"github.com/uhthomas/automata/k8s/amour/intel_gpu_plugin"
	"github.com/uhthomas/automata/k8s/amour/kube_state_metrics"
	"github.com/uhthomas/automata/k8s/amour/kube_system"
	"github.com/uhthomas/automata/k8s/amour/node_exporter"
	"github.com/uhthomas/automata/k8s/amour/node_feature_discovery"
	"github.com/uhthomas/automata/k8s/amour/node_problem_detector"
	"github.com/uhthomas/automata/k8s/amour/onepassword_connect"
	"github.com/uhthomas/automata/k8s/amour/onepassword_operator"
	"github.com/uhthomas/automata/k8s/amour/rook_ceph"
	"github.com/uhthomas/automata/k8s/amour/thomas"
	"github.com/uhthomas/automata/k8s/amour/vm_operator"
	"github.com/uhthomas/automata/k8s/amour/vm"
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
	amour.#CustomResourceDefinitionList.items,
	cert_manager_csi_driver.#List.items,
	cert_manager.#List.items,
	cilium.#List.items,
	intel_gpu_plugin.#List.items,
	kube_state_metrics.#List.items,
	kube_system.#List.items,
	node_exporter.#List.items,
	node_feature_discovery.#List.items,
	node_problem_detector.#List.items,
	onepassword_connect.#List.items,
	onepassword_operator.#List.items,
	rook_ceph.#List.items,
	thomas.#List.items,
	vm_operator.#List.items,
	vm.#List.items,
]

#List
