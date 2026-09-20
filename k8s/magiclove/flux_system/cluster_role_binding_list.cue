package flux_system

import rbacv1 "k8s.io/api/rbac/v1"

#ClusterRoleBindingList: rbacv1.#ClusterRoleBindingList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBindingList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRoleBinding"
	}]
}

#ClusterRoleBindingList: items: [{
	metadata: name: "cluster-reconciler-flux-system"
	subjects: [{
		kind:      "ServiceAccount"
		name:      "kustomize-controller"
		namespace: #Namespace
	}, {
		kind:      "ServiceAccount"
		name:      "helm-controller"
		namespace: #Namespace
	}]
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "cluster-admin"
	}
}, {
	metadata: name: "crd-controller-flux-system"
	subjects: [{
		kind:      "ServiceAccount"
		name:      "kustomize-controller"
		namespace: #Namespace
	}, {
		kind:      "ServiceAccount"
		name:      "helm-controller"
		namespace: #Namespace
	}, {
		kind:      "ServiceAccount"
		name:      "source-controller"
		namespace: #Namespace
	}, {
		kind:      "ServiceAccount"
		name:      "notification-controller"
		namespace: #Namespace
	}, {
		kind:      "ServiceAccount"
		name:      "image-reflector-controller"
		namespace: #Namespace
	}, {
		kind:      "ServiceAccount"
		name:      "image-automation-controller"
		namespace: #Namespace
	}, {
		kind:      "ServiceAccount"
		name:      "source-watcher"
		namespace: #Namespace
	}]
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "crd-controller-flux-system"
	}
}]
