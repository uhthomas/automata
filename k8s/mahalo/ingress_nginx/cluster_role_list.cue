package ingress_nginx

import rbacv1 "k8s.io/api/rbac/v1"

clusterRoleList: rbacv1.#ClusterRoleList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRole"
	}]
}

clusterRoleList: items: [{
	metadata: {
		name: "ingress-nginx"
		labels: {
			"app.kubernetes.io/name":     "ingress-nginx"
			"app.kubernetes.io/instance": "ingress-nginx"
		}
	}
	rules: [{
		apiGroups: [
			"",
		]
		resources: [
			"configmaps",
			"endpoints",
			"nodes",
			"pods",
			"secrets",
		]
		verbs: [
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"",
		]
		resources: [
			"nodes",
		]
		verbs: [
			"get",
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
			"",
		]
		resources: [
			"events",
		]
		verbs: [
			"create",
			"patch",
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
			"admissionregistration.k8s.io",
		]
		resources: [
			"validatingwebhookconfigurations",
		]
		verbs: [
			"get",
			"update",
		]
	}]
}]
