package cilium_secrets

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
		name: "cilium-gateway-secrets"
		labels: "app.kubernetes.io/part-of": "cilium"
	}
	rules: [{
		apiGroups: [""]
		resources: ["secrets"]
		verbs: ["get", "list", "watch"]
	}]
}, {
	metadata: {
		name: "cilium-operator-gateway-secrets"
		labels: "app.kubernetes.io/part-of": "cilium"
	}
	rules: [{
		apiGroups: [""]
		resources: ["secrets"]
		verbs: ["create", "delete", "update", "patch"]
	}]
}, {
	metadata: {
		name: "cilium-tlsinterception-secrets"
		labels: "app.kubernetes.io/part-of": "cilium"
	}
	rules: [{
		apiGroups: [""]
		resources: ["secrets"]
		verbs: ["get", "list", "watch"]
	}]
}, {
	metadata: {
		name: "cilium-operator-tlsinterception-secrets"
		labels: "app.kubernetes.io/part-of": "cilium"
	}
	rules: [{
		apiGroups: [""]
		resources: ["secrets"]
		verbs: ["create", "delete", "update", "patch"]
	}]
}]
