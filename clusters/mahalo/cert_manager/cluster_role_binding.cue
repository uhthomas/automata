package cert_manager

import rbacv1 "k8s.io/api/rbac/v1"

cluster_role_binding: [...rbacv1.#ClusterRoleBinding]

cluster_role_binding: [{
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: {
		name: "cert-manager-cainjector"
		labels: {
			app:                           "cainjector"
			"app.kubernetes.io/component": "cainjector"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "cainjector"
		}
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "cert-manager-cainjector"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "cert-manager-cainjector"
		namespace: "cert-manager"
	}]
}, {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: {
		name: "cert-manager-controller-issuers"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/component": "controller"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
		}
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "cert-manager-controller-issuers"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "cert-manager"
		namespace: "cert-manager"
	}]
}, {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: {
		name: "cert-manager-controller-clusterissuers"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/component": "controller"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
		}
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "cert-manager-controller-clusterissuers"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "cert-manager"
		namespace: "cert-manager"
	}]
}, {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: {
		name: "cert-manager-controller-certificates"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/component": "controller"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
		}
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "cert-manager-controller-certificates"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "cert-manager"
		namespace: "cert-manager"
	}]
}, {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: {
		name: "cert-manager-controller-orders"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/component": "controller"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
		}
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "cert-manager-controller-orders"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "cert-manager"
		namespace: "cert-manager"
	}]
}, {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: {
		name: "cert-manager-controller-challenges"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/component": "controller"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
		}
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "cert-manager-controller-challenges"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "cert-manager"
		namespace: "cert-manager"
	}]
}, {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: {
		name: "cert-manager-controller-ingress-shim"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/component": "controller"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
		}
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "cert-manager-controller-ingress-shim"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "cert-manager"
		namespace: "cert-manager"
	}]
}]
