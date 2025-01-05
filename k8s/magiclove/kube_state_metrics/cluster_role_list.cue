package kube_state_metrics

import (
	admissionregistrationv1 "k8s.io/api/admissionregistration/v1"
	appsv1 "k8s.io/api/apps/v1"
	authenticationv1 "k8s.io/api/authentication/v1"
	authorizationv1 "k8s.io/api/authorization/v1"
	autoscalingv1 "k8s.io/api/autoscaling/v1"
	batchv1 "k8s.io/api/batch/v1"
	certificatesv1 "k8s.io/api/certificates/v1"
	coordinationv1 "k8s.io/api/coordination/v1"
	"k8s.io/api/core/v1"
	discoveryv1 "k8s.io/api/discovery/v1"
	networkingv1 "k8s.io/api/networking/v1"
	policyv1 "k8s.io/api/policy/v1"
	rbacv1 "k8s.io/api/rbac/v1"
	storagev1 "k8s.io/api/storage/v1"
)

#ClusterRoleList: rbacv1.#ClusterRoleList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRole"
	}]
}

#ClusterRoleList: items: [{
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: [
			"configmaps",
			"secrets",
			"nodes",
			"pods",
			"services",
			"serviceaccounts",
			"resourcequotas",
			"replicationcontrollers",
			"limitranges",
			"persistentvolumeclaims",
			"persistentvolumes",
			"namespaces",
			"endpoints",
		]
		verbs: ["list", "watch"]
	}, {
		apiGroups: [appsv1.#GroupName]
		resources: [
			"statefulsets",
			"daemonsets",
			"deployments",
			"replicasets",
		]
		verbs: ["list", "watch"]
	}, {
		apiGroups: [batchv1.#GroupName]
		resources: ["cronjobs", "jobs"]
		verbs: ["list", "watch"]
	}, {
		apiGroups: [autoscalingv1.#GroupName]
		resources: ["horizontalpodautoscalers"]
		verbs: ["list", "watch"]
	}, {
		apiGroups: [authenticationv1.#GroupName]
		resources: ["tokenreviews"]
		verbs: ["create"]
	}, {
		apiGroups: [authorizationv1.#GroupName]
		resources: ["subjectaccessreviews"]
		verbs: ["create"]
	}, {
		apiGroups: [policyv1.#GroupName]
		resources: ["poddisruptionbudgets"]
		verbs: ["list", "watch"]
	}, {
		apiGroups: [certificatesv1.#GroupName]
		resources: ["certificatesigningrequests"]
		verbs: ["list", "watch"]
	}, {
		apiGroups: [discoveryv1.#GroupName]
		resources: ["endpointslices"]
		verbs: ["list", "watch"]
	}, {
		apiGroups: [storagev1.#GroupName]
		resources: ["storageclasses", "volumeattachments"]
		verbs: ["list", "watch"]
	}, {
		apiGroups: [admissionregistrationv1.#GroupName]
		resources: [
			"mutatingwebhookconfigurations",
			"validatingwebhookconfigurations",
		]
		verbs: ["list", "watch"]
	}, {
		apiGroups: [networkingv1.#GroupName]
		resources: [
			"networkpolicies",
			"ingressclasses",
			"ingresses",
		]
		verbs: ["list", "watch"]
	}, {
		apiGroups: [coordinationv1.#GroupName]
		resources: ["leases"]
		verbs: ["list", "watch"]
	}, {
		apiGroups: [rbacv1.#GroupName]
		resources: ["clusterrolebindings", "clusterroles", "rolebindings", "roles"]
		verbs: ["list", "watch"]
	}]
}]
