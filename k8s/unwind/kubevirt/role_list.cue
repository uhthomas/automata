package kubevirt

import (
	rbacv1 "k8s.io/api/rbac/v1"
	"k8s.io/api/core/v1"
)

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
		name: "kubevirt-operator"
		labels: "kubevirt.io": ""
	}
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["secrets"]
		verbs: ["create", "get", "list", "watch", "patch", "delete"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["configmaps"]
		verbs: ["create", "get", "list", "watch", "patch", "delete"]
	}, {
		apiGroups: ["route.openshift.io"]
		resources: ["routes"]
		verbs: ["create", "get", "list", "watch", "patch", "delete"]
	}, {
		apiGroups: ["route.openshift.io"]
		resources: ["routes/custom-host"]
		verbs: ["create"]
	}]
}]
