package flux_system

import rbacv1 "k8s.io/api/rbac/v1"

#ClusterRoleList: rbacv1.#ClusterRoleList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRole"
	}]
}

#ClusterRoleList: items: [{
	metadata: name: "crd-controller-flux-system"
	rules: [{
		verbs: ["*"]
		apiGroups: ["source.toolkit.fluxcd.io"]
		resources: ["*"]
	}, {
		verbs: ["*"]
		apiGroups: ["kustomize.toolkit.fluxcd.io"]
		resources: ["*"]
	}, {
		verbs: ["*"]
		apiGroups: ["helm.toolkit.fluxcd.io"]
		resources: ["*"]
	}, {
		verbs: ["*"]
		apiGroups: ["notification.toolkit.fluxcd.io"]
		resources: ["*"]
	}, {
		verbs: ["*"]
		apiGroups: ["image.toolkit.fluxcd.io"]
		resources: ["*"]
	}, {
		verbs: ["*"]
		apiGroups: ["source.extensions.fluxcd.io"]
		resources: ["*"]
	}, {
		verbs: ["get", "list", "watch"]
		apiGroups: [""]
		resources: ["namespaces", "secrets", "configmaps", "serviceaccounts"]
	}, {
		verbs: ["create", "patch"]
		apiGroups: [""]
		resources: ["events"]
	}, {
		verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
		apiGroups: [""]
		resources: ["configmaps"]
	}, {
		verbs: ["get", "update", "patch"]
		apiGroups: [""]
		resources: ["configmaps/status"]
	}, {
		verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
	}, {
		verbs: ["create"]
		apiGroups: [""]
		resources: ["serviceaccounts/token"]
	}, {
		verbs: ["head"]
		nonResourceURLs: ["/livez/ping"]
	}]
}, {
	metadata: {
		name: "flux-edit-flux-system"
		labels: {
			"rbac.authorization.k8s.io/aggregate-to-admin": "true"
			"rbac.authorization.k8s.io/aggregate-to-edit":  "true"
		}
	}
	rules: [{
		verbs: ["create", "delete", "deletecollection", "patch", "update"]
		apiGroups: ["notification.toolkit.fluxcd.io", "source.toolkit.fluxcd.io", "source.extensions.fluxcd.io", "helm.toolkit.fluxcd.io", "image.toolkit.fluxcd.io", "kustomize.toolkit.fluxcd.io"]
		resources: ["*"]
	}]
}, {
	metadata: {
		name: "flux-view-flux-system"
		labels: {
			"rbac.authorization.k8s.io/aggregate-to-admin": "true"
			"rbac.authorization.k8s.io/aggregate-to-edit":  "true"
			"rbac.authorization.k8s.io/aggregate-to-view":  "true"
		}
	}
	rules: [{
		verbs: ["get", "list", "watch"]
		apiGroups: ["notification.toolkit.fluxcd.io", "source.toolkit.fluxcd.io", "source.extensions.fluxcd.io", "helm.toolkit.fluxcd.io", "image.toolkit.fluxcd.io", "kustomize.toolkit.fluxcd.io"]
		resources: ["*"]
	}]
}]
