package ingress_nginx

import rbacv1 "k8s.io/api/rbac/v1"

cluster_role: [...rbacv1.#ClusterRole]

cluster_role: [{
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: {
		name: "ingress-nginx"
		labels: {
			"app.kubernetes.io/name":     "ingress-nginx"
			"app.kubernetes.io/instance": "ingress-nginx"
			"app.kubernetes.io/version":  "0.44.0"
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
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
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
