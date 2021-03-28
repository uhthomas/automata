package kube_state_metrics

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
	rules: [{
		apiGroups: [
			"",
		]
		resources: [
			"configmaps",
			"secrets",
			"nodes",
			"pods",
			"services",
			"resourcequotas",
			"replicationcontrollers",
			"limitranges",
			"persistentvolumeclaims",
			"persistentvolumes",
			"namespaces",
			"endpoints",
		]
		verbs: [
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"extensions",
		]
		resources: [
			"daemonsets",
			"deployments",
			"replicasets",
		]
		verbs: [
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"apps",
		]
		resources: [
			"statefulsets",
			"daemonsets",
			"deployments",
			"replicasets",
		]
		verbs: [
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"batch",
		]
		resources: [
			"cronjobs",
			"jobs",
		]
		verbs: [
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"autoscaling",
		]
		resources: [
			"horizontalpodautoscalers",
		]
		verbs: [
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"authentication.k8s.io",
		]
		resources: [
			"tokenreviews",
		]
		verbs: [
			"create",
		]
	}, {
		apiGroups: [
			"authorization.k8s.io",
		]
		resources: [
			"subjectaccessreviews",
		]
		verbs: [
			"create",
		]
	}, {
		apiGroups: [
			"policy",
		]
		resources: [
			"poddisruptionbudgets",
		]
		verbs: [
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"certificates.k8s.io",
		]
		resources: [
			"certificatesigningrequests",
		]
		verbs: [
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"storage.k8s.io",
		]
		resources: [
			"storageclasses",
			"volumeattachments",
		]
		verbs: [
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"admissionregistration.k8s.io",
		]
		resources: [
			"mutatingwebhookconfigurations",
			"validatingwebhookconfigurations",
		]
		verbs: [
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"networking.k8s.io",
		]
		resources: [
			"networkpolicies",
			"ingresses",
		]
		verbs: [
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"coordination.k8s.io",
		]
		resources: [
			"leases",
		]
		verbs: [
			"list",
			"watch",
		]
	}]
}]
