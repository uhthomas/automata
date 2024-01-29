package cilium

import (
	"k8s.io/api/core/v1"
	rbacv1 "k8s.io/api/rbac/v1"
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
	metadata: {
		name: "cilium"
		labels: "app.kubernetes.io/part-of": "cilium"
	}
	rules: [{
		apiGroups: ["networking.k8s.io"]
		resources: ["networkpolicies"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["discovery.k8s.io"]
		resources: ["endpointslices"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["namespaces", "services", "pods", "endpoints", "nodes"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["nodes/status"]
		verbs: ["patch"]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		verbs: ["create", "get", "update", "list", "delete"]
	}, {
		apiGroups: ["apiextensions.k8s.io"]
		resources: ["customresourcedefinitions"]
		verbs: ["list", "watch", "get"]
	}, {
		apiGroups: ["cilium.io"]
		resources: ["ciliumloadbalancerippools", "ciliumbgppeeringpolicies", "ciliumclusterwideenvoyconfigs", "ciliumclusterwidenetworkpolicies", "ciliumegressgatewaypolicies", "ciliumendpoints", "ciliumendpointslices", "ciliumenvoyconfigs", "ciliumidentities", "ciliumlocalredirectpolicies", "ciliumnetworkpolicies", "ciliumnodes", "ciliumnodeconfigs", "ciliumcidrgroups", "ciliuml2announcementpolicies", "ciliumpodippools"]
		verbs: ["list", "watch"]
	}, {
		apiGroups: ["cilium.io"]
		resources: ["ciliumidentities", "ciliumendpoints", "ciliumnodes"]
		verbs: ["create"]
	}, {
		apiGroups: ["cilium.io"]
		resources: ["ciliumidentities"]
		verbs: ["update"]
	}, {
		apiGroups: ["cilium.io"]
		resources: ["ciliumendpoints"]
		verbs: ["delete", "get"]
	}, {
		apiGroups: ["cilium.io"]
		resources: ["ciliumnodes", "ciliumnodes/status"]
		verbs: ["get", "update"]
	}, {
		apiGroups: ["cilium.io"]
		resources: ["ciliumnetworkpolicies/status", "ciliumclusterwidenetworkpolicies/status", "ciliumendpoints/status", "ciliumendpoints", "ciliuml2announcementpolicies/status", "ciliumbgpnodeconfigs/status"]
		verbs: ["patch"]
	}]
}, {
	metadata: {
		name: "cilium-operator"
		labels: "app.kubernetes.io/part-of": "cilium"
	}
	rules: [{
		apiGroups: [""]
		resources: ["pods"]
		verbs: ["get", "list", "watch", "delete"]
	}, {
		apiGroups: [""]
		resources: ["nodes"]
		verbs: ["list", "watch"]
	}, {
		apiGroups: [""]
		resources: ["nodes", "nodes/status"]
		verbs: ["patch"]
	}, {
		apiGroups: ["discovery.k8s.io"]
		resources: ["endpointslices"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [""]
		resources: ["services/status"]
		verbs: ["update", "patch"]
	}, {
		apiGroups: [""]
		resources: ["namespaces"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [""]
		resources: ["services", "endpoints"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["cilium.io"]
		resources: ["ciliumnetworkpolicies", "ciliumclusterwidenetworkpolicies"]
		verbs: ["create", "update", "deletecollection", "patch", "get", "list", "watch"]
	}, {

		apiGroups: ["cilium.io"]
		resources: ["ciliumnetworkpolicies/status", "ciliumclusterwidenetworkpolicies/status"]
		verbs: ["patch", "update"]
	}, {
		apiGroups: ["cilium.io"]
		resources: ["ciliumendpoints", "ciliumidentities"]
		verbs: ["delete", "list", "watch"]
	}, {
		apiGroups: ["cilium.io"]
		resources: ["ciliumidentities"]
		verbs: ["update"]
	}, {
		apiGroups: ["cilium.io"]
		resources: ["ciliumnodes"]
		verbs: ["create", "update", "get", "list", "watch", "delete"]
	}, {

		apiGroups: ["cilium.io"]
		resources: ["ciliumnodes/status"]
		verbs: ["update"]
	}, {
		apiGroups: ["cilium.io"]
		resources: ["ciliumendpointslices", "ciliumenvoyconfigs"]
		verbs: ["create", "update", "get", "list", "watch", "delete", "patch"]
	}, {
		apiGroups: ["apiextensions.k8s.io"]
		resources: ["customresourcedefinitions"]
		verbs: ["create", "get", "list", "watch"]
	}, {
		apiGroups: ["apiextensions.k8s.io"]
		resources: ["customresourcedefinitions"]
		verbs: ["update"]
		resourceNames: ["ciliumloadbalancerippools.cilium.io", "ciliumbgppeeringpolicies.cilium.io", "ciliumclusterwideenvoyconfigs.cilium.io", "ciliumclusterwidenetworkpolicies.cilium.io", "ciliumegressgatewaypolicies.cilium.io", "ciliumendpoints.cilium.io", "ciliumendpointslices.cilium.io", "ciliumenvoyconfigs.cilium.io", "ciliumexternalworkloads.cilium.io", "ciliumidentities.cilium.io", "ciliumlocalredirectpolicies.cilium.io", "ciliumnetworkpolicies.cilium.io", "ciliumnodes.cilium.io", "ciliumnodeconfigs.cilium.io", "ciliumcidrgroups.cilium.io", "ciliuml2announcementpolicies.cilium.io", "ciliumpodippools.cilium.io"]
	}, {
		apiGroups: ["cilium.io"]
		resources: ["ciliumloadbalancerippools", "ciliumpodippools", "ciliumbgppeeringpolicies", "ciliumbgpclusterconfigs", "ciliumbgpnodeconfigoverrides"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["cilium.io"]
		resources: ["ciliumpodippools"]
		verbs: ["create"]
	}, {
		apiGroups: ["cilium.io"]
		resources: ["ciliumloadbalancerippools/status"]
		verbs: ["patch"]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		verbs: ["create", "get", "update"]
	}]
}]
