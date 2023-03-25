import (
	"list"

	"github.com/uhthomas/automata/k8s/unwind_bootstrap"
	"k8s.io/api/core/v1"
)

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{metadata: labels: "app.kubernetes.io/managed-by": "automata"}]
}

// items are grouped by dependency requirements, and sorted lexicographically
// where possible.
items: list.Concat(_items)

_items: [
	unwind_bootstrap.clusterList.items,
	unwind_bootstrap.machineDeploymentList.items,
	unwind_bootstrap.metalClusterList.items,
	unwind_bootstrap.metalMachineTemplateList.items,
	unwind_bootstrap.serverList.items,
	unwind_bootstrap.talosConfigTemplateList.items,
	unwind_bootstrap.talosControlPlaneList.items,
]
