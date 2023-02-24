package tailscale

import "k8s.io/api/core/v1"

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *"tailscale"
			namespace: "tailscale"
		}
	}]

}

list: items:
	// The namespace must be created first.
	namespaceList.items +
	// Lexicographic ordering.
	clusterRoleBindingList.items +
	clusterRoleList.items +
	deploymentList.items +
	roleBindingList.items +
	roleList.items +
	secretList.items +
	serviceAccountList.items
