package cilium

import rbacv1 "k8s.io/api/rbac/v1"

#RoleBindingList: rbacv1.#RoleBindingList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBindingList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "RoleBinding"
	}]
}

#RoleBindingList: items: [{
	metadata: {
		name: "cilium-config-agent"
		labels: "app.kubernetes.io/part-of": "cilium"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "cilium-config-agent"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "cilium"
		namespace: #Namespace
	}]
}]
