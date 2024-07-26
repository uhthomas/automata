package cert_manager

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
		name:      "cert-manager-cainjector:leaderelection"
		namespace: "kube-system"
		labels: {
			app:                           "cainjector"
			"app.kubernetes.io/name":      "cainjector"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "cainjector"
		}
	}, rules: [{
		// Used for leader election by the controller
		// cert-manager-cainjector-leader-election is used by the CertificateBased injector controller
		//   see cmd/cainjector/start.go#L113
		// cert-manager-cainjector-leader-election-core is used by the SecretBased injector controller
		//   see cmd/cainjector/start.go#L137
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		resourceNames: ["cert-manager-cainjector-leader-election", "cert-manager-cainjector-leader-election-core"]
		verbs: ["get", "update", "patch"]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		verbs: ["create"]
	}]
}, {
	metadata: {
		name:      "cert-manager:leaderelection"
		namespace: "kube-system"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "controller"
		}
	}, rules: [{
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		resourceNames: ["cert-manager-controller"]
		verbs: ["get", "update", "patch"]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		verbs: ["create"]
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
	}, rules: [{
		apiGroups: [""]
		resources: ["secrets"]
		resourceNames: ["cert-manager-webhook-ca"]
		verbs: ["get", "list", "watch", "update"]
	}, {
		// It's not possible to grant CREATE permission on a single resourceName.
		apiGroups: [""]
		resources: ["secrets"]
		verbs: ["create"]
	}]
}]
