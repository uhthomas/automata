package node_feature_discovery

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
	metadata: name: "nfd-worker"
	rules: [{
		apiGroups: ["nfd.k8s-sigs.io"]
		resources: ["nodefeatures"]
		verbs: ["create", "get", "update"]
	}]
}]
