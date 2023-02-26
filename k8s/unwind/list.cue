import (
	"github.com/uhthomas/automata/k8s/unwind"
	"github.com/uhthomas/automata/k8s/unwind/grafana"
	"github.com/uhthomas/automata/k8s/unwind/grafana_agent_operator"
	"github.com/uhthomas/automata/k8s/unwind/rook_ceph"
	"github.com/uhthomas/automata/k8s/unwind/tailscale"
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
	// unwind.clusterList.items +
	// unwind.machineDeploymentList.items +
	// unwind.metalClusterList.items +
	// unwind.metalMachineTemplateList.items +
	// unwind.serverList.items +
	// unwind.talosConfigTemplateList.items +
	// unwind.talosControlPlaneList.items
	rook_ceph.list.items +
	tailscale.list.items +

	// Requires rook_ceph and tailscale.
	grafana.list.items +
	grafana_agent_operator.list.items
