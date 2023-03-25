import (
	"github.com/uhthomas/automata/k8s/unwind/media"
	"github.com/uhthomas/automata/k8s/unwind/cert_manager_csi_driver"
	"github.com/uhthomas/automata/k8s/unwind/cert_manager"
	"github.com/uhthomas/automata/k8s/unwind/grafana_agent_operator"
	"github.com/uhthomas/automata/k8s/unwind/grafana_agent"
	"github.com/uhthomas/automata/k8s/unwind/grafana"
	"github.com/uhthomas/automata/k8s/unwind/rook_ceph"
	"github.com/uhthomas/automata/k8s/unwind/secrets_store_csi_driver"
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

// items are grouped by dependency requirements, and sorted lexicographically
// where possible.
#List: items:
	cert_manager.#List.items +
	cert_manager_csi_driver.#List.items +
	rook_ceph.#List.items +
	secrets_store_csi_driver.#List.items +

	// Requires rook_ceph and secrets_store_csi_driver.
	vault.#List.items +
	vault_csi_provider.#List.items +
	vault_config_operator.#List.items +

	// Requires secrets_store_csi_driver.
	tailscale.#List.items +

	// Requires rook_ceph and tailscale.
	grafana_agent_operator.#List.items +
	grafana_agent.#List.items +
	grafana.#List.items +
	media.#List.items

#List
