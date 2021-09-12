package ingress_nginx

import rbacv1 "k8s.io/api/rbac/v1"

clusterRoleBindingList: rbacv1.#ClusterRoleBindingList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBindingList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRoleBinding"
	}]
}

clusterRoleBindingList: items: [{
	metadata: {
		name: "ingress-nginx"
		labels: {
			"app.kubernetes.io/name":     "ingress-nginx"
			"app.kubernetes.io/instance": "ingress-nginx"
		}
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "ingress-nginx"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "ingress-nginx"
		namespace: "ingress-nginx"
	}]
}, {
	metadata: {
		name: "ingress-nginx-admission"
		labels: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/component": "admission-webhook"
		}
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "ingress-nginx-admission"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "ingress-nginx-admission"
		namespace: "ingress-nginx"
	}]
}]
