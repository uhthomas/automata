package cert_manager

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
	// grant cert-manager permission to manage the leaderelection configmap in the
	// leader election namespace
	metadata: {
		name:      "cert-manager-cainjector:leaderelection"
		namespace: "kube-system"
		labels: {
			app:                           "cainjector"
			"app.kubernetes.io/name":      "cainjector"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "cainjector"
		}
	}
	roleRef: {
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
	// grant cert-manager permission to manage the leaderelection configmap in the
	// leader election namespace
	metadata: {
		name:      "cert-manager:leaderelection"
		namespace: "kube-system"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "controller"
		}
	}
	roleRef: {
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
	metadata: {
		name:      "cert-manager-webhook:dynamic-serving"
		namespace: #Namespace
		labels: {
			app:                           "webhook"
			"app.kubernetes.io/name":      "webhook"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "webhook"
		}
	}
	roleRef: {
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
