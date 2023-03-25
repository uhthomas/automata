package cert_manager

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
	metadata: {
		name: "cert-manager-cainjector"
		labels: {
			app:                           "cainjector"
			"app.kubernetes.io/name":      "cainjector"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "cainjector"
		}
	}
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "cert-manager-cainjector"
	}
	subjects: [{
		name:      "cert-manager-cainjector"
		namespace: #Namespace
		kind:      rbacv1.#ServiceAccountKind
	}]
}, {
	metadata: {
		name: "cert-manager-controller-issuers"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "controller"
		}
	}
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "cert-manager-controller-issuers"
	}
	subjects: [{
		name:      "cert-manager"
		namespace: #Namespace
		kind:      rbacv1.#ServiceAccountKind
	}]
}, {
	metadata: {
		name: "cert-manager-controller-clusterissuers"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "controller"
		}
	}
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "cert-manager-controller-clusterissuers"
	}
	subjects: [{
		name:      "cert-manager"
		namespace: #Namespace
		kind:      rbacv1.#ServiceAccountKind
	}]
}, {
	metadata: {
		name: "cert-manager-controller-certificates"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "controller"
		}
	}
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "cert-manager-controller-certificates"
	}
	subjects: [{
		name:      "cert-manager"
		namespace: #Namespace
		kind:      rbacv1.#ServiceAccountKind
	}]
}, {
	metadata: {
		name: "cert-manager-controller-orders"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "controller"
		}
	}
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "cert-manager-controller-orders"
	}
	subjects: [{
		name:      "cert-manager"
		namespace: #Namespace
		kind:      rbacv1.#ServiceAccountKind
	}]
}, {
	metadata: {
		name: "cert-manager-controller-challenges"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "controller"
		}
	}
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "cert-manager-controller-challenges"
	}
	subjects: [{
		name:      "cert-manager"
		namespace: #Namespace
		kind:      rbacv1.#ServiceAccountKind
	}]
}, {
	metadata: {
		name: "cert-manager-controller-ingress-shim"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "controller"
		}
	}
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "cert-manager-controller-ingress-shim"
	}
	subjects: [{
		name:      "cert-manager"
		namespace: #Namespace
		kind:      rbacv1.#ServiceAccountKind
	}]
}, {
	metadata: {
		name: "cert-manager-controller-approve:cert-manager-io"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "cert-manager"
		}
	}
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "cert-manager-controller-approve:cert-manager-io"
	}
	subjects: [{
		name:      "cert-manager"
		namespace: #Namespace
		kind:      rbacv1.#ServiceAccountKind
	}]
}, {
	metadata: {
		name: "cert-manager-controller-certificatesigningrequests"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "cert-manager"
		}
	}
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "cert-manager-controller-certificatesigningrequests"
	}
	subjects: [{
		name:      "cert-manager"
		namespace: #Namespace
		kind:      rbacv1.#ServiceAccountKind
	}]
}, {
	metadata: {
		name: "cert-manager-webhook:subjectaccessreviews"
		labels: {
			app:                           "webhook"
			"app.kubernetes.io/name":      "webhook"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "webhook"
		}
	}
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "cert-manager-webhook:subjectaccessreviews"
	}
	subjects: [{
		apiGroup:  ""
		kind:      rbacv1.#ServiceAccountKind
		name:      "cert-manager-webhook"
		namespace: #Namespace
	}]
}]
