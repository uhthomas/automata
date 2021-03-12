package cert_manager

import rbacv1 "k8s.io/api/rbac/v1"

role_binding: [...rbacv1.#RoleBinding]

role_binding: [{
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBinding"
	metadata: {
		name: "cert-manager-cainjector:leaderelection"
		labels: {
			app:                           "cainjector"
			"app.kubernetes.io/component": "cainjector"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "cainjector"
		}
		namespace: "kube-system"
	}, roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "cert-manager-cainjector:leaderelection"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "cert-manager-cainjector"
		namespace: "cert-manager"
	}]
}, {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBinding"
	metadata: {
		name: "cert-manager:leaderelection"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/component": "controller"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
		}
		namespace: "kube-system"
	}, roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "cert-manager:leaderelection"
	}
	subjects: [{
		apiGroup:  ""
		kind:      "ServiceAccount"
		name:      "cert-manager"
		namespace: "cert-manager"
	}]
}, {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBinding"
	metadata: {
		name: "cert-manager-webhook:dynamic-serving"
		labels: {
			app:                           "webhook"
			"app.kubernetes.io/component": "webhook"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "webhook"
		}
		namespace: "cert-manager"
	}, roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "cert-manager-webhook:dynamic-serving"
	}
	subjects: [{
		apiGroup:  ""
		kind:      "ServiceAccount"
		name:      "cert-manager-webhook"
		namespace: "cert-manager"
	}]
}]
