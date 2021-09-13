package ingress_nginx

import rbacv1 "k8s.io/api/rbac/v1"

roleList: rbacv1.#RoleList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "Role"
	}]
}

roleList: items: [{
	metadata: {
		name: "ingress-nginx"
		labels: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/component": "controller"
		}
	}
	rules: [{
		apiGroups: [
			"",
		]
		resources: [
			"namespaces",
		]
		verbs: [
			"get",
		]
	}, {
		apiGroups: [
			"",
		]
		resources: [
			"configmaps",
			"pods",
			"secrets",
			"endpoints",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"",
		]
		resources: [
			"services",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: ["networking.k8s.io"]
		resources: [
			"ingresses",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: ["networking.k8s.io"]
		resources: [
			"ingresses/status",
		]
		verbs: [
			"update",
		]
	}, {
		apiGroups: ["networking.k8s.io"]
		resources: [
			"ingressclasses",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"",
		]
		resources: [
			"configmaps",
		]
		resourceNames: [
			"ingress-controller-leader-nginx",
		]
		verbs: [
			"get",
			"update",
		]
	}, {
		apiGroups: [
			"",
		]
		resources: [
			"configmaps",
		]
		verbs: [
			"create",
		]
	}, {
		apiGroups: [
			"",
		]
		resources: [
			"events",
		]
		verbs: [
			"create",
			"patch",
		]
	}]
}, {
	metadata: {
		name: "ingress-nginx-admission"
		labels: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/component": "admission-webhook"
		}
	}
	rules: [{
		apiGroups: [
			"",
		]
		resources: [
			"secrets",
		]
		verbs: [
			"get",
			"create",
		]
	}]
}]
