package olm

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
	metadata: name: "system:controller:operator-lifecycle-manager"
	rules: [{
		apiGroups: [rbacv1.#APIGroupAll]
		resources: [rbacv1.#ResourceAll]
		verbs: [rbacv1.#VerbAll]
	}, {
		nonResourceURLs: [rbacv1.#NonResourceAll]
		verbs: [rbacv1.#VerbAll]
	}]
}, {
	metadata: {
		name: "aggregate-olm-edit"
		labels: {
			"rbac.authorization.k8s.io/aggregate-to-admin": "true"
			"rbac.authorization.k8s.io/aggregate-to-edit":  "true"
		}
	}
	rules: [{
		apiGroups: ["operators.coreos.com"]
		resources: ["subscriptions"]
		verbs: ["create", "update", "patch", "delete"]
	}, {
		apiGroups: ["operators.coreos.com"]
		resources: ["clusterserviceversions", "catalogsources", "installplans", "subscriptions"]
		verbs: ["delete"]
	}]
}, {
	metadata: {
		name: "aggregate-olm-view"
		labels: {
			"rbac.authorization.k8s.io/aggregate-to-admin": "true"
			"rbac.authorization.k8s.io/aggregate-to-edit":  "true"
			"rbac.authorization.k8s.io/aggregate-to-view":  "true"
		}
	}
	rules: [{
		apiGroups: ["operators.coreos.com"]
		resources: ["clusterserviceversions", "catalogsources", "installplans", "subscriptions", "operatorgroups"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["packages.operators.coreos.com"]
		resources: ["packagemanifests", "packagemanifests/icon"]
		verbs: ["get", "list", "watch"]
	}]
}]
