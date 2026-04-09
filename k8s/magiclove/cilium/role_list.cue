package cilium

import rbacv1 "k8s.io/api/rbac/v1"

#RoleList: rbacv1.#RoleList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "Role"
	}]
}

#RoleList: items: [{
	metadata: {
		name: "cilium-config-agent"
		labels: "app.kubernetes.io/part-of": "cilium"
	}
	rules: [{
		apiGroups: [""]
		resources: ["configmaps"]
		verbs: ["get", "list", "watch"]
	}]
}, {
	metadata: {
		name: "cilium-bgp-control-plane-secrets"
		labels: "app.kubernetes.io/part-of": "cilium"
	}
	rules: [{
		apiGroups: [""]
		resources: ["secrets"]
		verbs: ["get", "list", "watch"]
	}]
}, {
	metadata: {
		name: "cilium-operator-ztunnel"
		labels: "app.kubernetes.io/part-of": "cilium"
	}
	// ZTunnel DaemonSet management permissions
	// Note: These permissions must always be granted (not conditional on encryption.type)
	// because the controller needs to clean up stale DaemonSets when ztunnel is disabled.
	rules: [{
		apiGroups: ["apps"]
		resources: ["daemonsets"]
		verbs: ["create", "delete", "get", "list", "watch"]
	}]
}]
