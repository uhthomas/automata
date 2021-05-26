package tigera_operator

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
	// Source: tigera-operator/templates/tigera-operator/02-role-tigera-operator.yaml
	rules: [{
		apiGroups: [
			"",
		]
		resources: [
			"namespaces",
			"pods",
			"podtemplates",
			"services",
			"endpoints",
			"events",
			"configmaps",
			"secrets",
			"serviceaccounts",
		]
		verbs: [
			"create",
			"get",
			"list",
			"update",
			"delete",
			"watch",
		]
	}, {
		apiGroups: [
			"",
		]
		resources: [
			"nodes",
		]
		verbs:
		// Need to update node labels when migrating nodes.
		[
			"get",
			"patch",
			"list",
			"watch",
		]
	}, {
		// We need this for Typha autoscaling

		apiGroups: [
			"rbac.authorization.k8s.io",
		]
		resources: [
			"clusterroles",
			"clusterrolebindings",
			"rolebindings",
			"roles",
		]
		verbs: [
			"create",
			"get",
			"list",
			"update",
			"delete",
			"watch",
			"bind",
			"escalate",
		]
	}, {
		apiGroups: [
			"apps",
		]
		resources: [
			"deployments",
			"daemonsets",
			"statefulsets",
		]
		verbs: [
			"create",
			"get",
			"list",
			"patch",
			"update",
			"delete",
			"watch",
		]
	}, {
		apiGroups: [
			"apps",
		]
		resourceNames: [
			"tigera-operator",
		]
		resources: [
			"deployments/finalizers",
		]
		verbs: [
			"update",
		]
	}, {
		apiGroups: [
			"operator.tigera.io",
		]
		resources: [
			"*",
		]
		verbs: [
			"create",
			"get",
			"list",
			"update",
			"patch",
			"delete",
			"watch",
		]
	}, {
		apiGroups: [
			"crd.projectcalico.org",
		]
		resources: [
			"felixconfigurations",
		]
		verbs: [
			"patch",
		]
	}, {
		apiGroups: [
			"crd.projectcalico.org",
		]
		resources: [
			"ippools",
			"kubecontrollersconfigurations",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"scheduling.k8s.io",
		]
		resources: [
			"priorityclasses",
		]
		verbs: [
			"create",
			"get",
			"list",
			"update",
			"delete",
			"watch",
		]
	}, {
		apiGroups: [
			"monitoring.coreos.com",
		]
		resources: [
			"servicemonitors",
		]
		verbs: [
			"get",
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
			"create",
			"get",
			"list",
			"update",
			"delete",
			"watch",
		]
	}, {
		apiGroups: [
			"apiregistration.k8s.io",
		]
		resources: [
			"apiservices",
		]
		verbs: [
			"list",
			"watch",
		]
	}, {
		// Needed for operator lock
		apiGroups: [
			"coordination.k8s.io",
		]
		resources: [
			"leases",
		]
		verbs: [
			"create",
			"get",
			"list",
			"update",
			"delete",
			"watch",
		]
	}, {
		// Add the appropriate pod security policy permissions
		apiGroups: [
			"policy",
		]
		resources: [
			"podsecuritypolicies",
		]
		resourceNames: [
			"tigera-operator",
		]
		verbs: [
			"use",
		]
	}, {
		apiGroups: [
			"policy",
		]
		resources: [
			"podsecuritypolicies",
		]
		verbs: [
			"get",
			"list",
			"watch",
			"create",
			"update",
		]
	}, {
		// Add the permissions to monitor the status of certificatesigningrequests when certificate management is enabled.
		apiGroups: [
			"certificates.k8s.io",
		]
		resources: [
			"certificatesigningrequests",
		]
		verbs: [
			"list",
		]
	}]
}]
