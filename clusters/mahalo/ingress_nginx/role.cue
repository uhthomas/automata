package ingress_nginx

import rbacv1 "k8s.io/api/rbac/v1"

role: [...rbacv1.#Role]

role: [{
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "Role"
	metadata: {
		name: "ingress-nginx"
		labels: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/version":   "0.44.0"
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
		apiGroups: [
			"extensions",
			"networking.k8s.io",
		] // k8s 1.14+
		resources: [
			"ingresses",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"extensions",
			"networking.k8s.io",
		] // k8s 1.14+
		resources: [
			"ingresses/status",
		]
		verbs: [
			"update",
		]
	}, {
		apiGroups: ["networking.k8s.io"] // k8s 1.14+
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
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "Role"
	metadata: {
		name: "ingress-nginx-admission"
		labels: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/version":   "0.44.0"
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
