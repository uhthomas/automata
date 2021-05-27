package metrics_server

import rbacv1 "k8s.io/api/rbac/v1"

roleBindingList: rbacv1.#RoleBindingList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBindingList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "RoleBinding"
	}]
}

roleBindingList: items: [{
	metadata: name: "metrics-server-auth-reader"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "extension-apiserver-authentication-reader"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "metrics-server"
		namespace: "kube-system"
	}]
}]
