package volsync_system

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
	metadata: name: "volsync-manager"
	rules: [{
		apiGroups: ["apps"]
		resources: ["deployments"]
		verbs: [
			"create",
			"delete",
			"deletecollection",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}, {
		apiGroups: ["batch"]
		resources: ["jobs"]
		verbs: [
			"create",
			"delete",
			"deletecollection",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["configmaps"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: [
			"create",
			"patch",
			"update",
		]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["namespaces"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["nodes"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumeclaims"]
		verbs: [
			"create",
			"delete",
			"deletecollection",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumeclaims/finalizers"]
		verbs: [
			"create",
			"delete",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumes"]
		verbs: [
			"get",
			"list",
			"patch",
			"watch",
		]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["pods"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["pods/log"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["secrets"]
		verbs: [
			"create",
			"delete",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["serviceaccounts"]
		verbs: [
			"create",
			"delete",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["services"]
		verbs: [
			"create",
			"delete",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}, {
		apiGroups: ["events.k8s.io"]
		resources: ["events"]
		verbs: [
			"create",
			"patch",
			"update",
		]
	}, {
		apiGroups: ["populator.storage.k8s.io"]
		resources: ["volumepopulators"]
		verbs: [
			"create",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}, {
		apiGroups: ["rbac.authorization.k8s.io"]
		resources: ["rolebindings"]
		verbs: [
			"create",
			"delete",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}, {
		apiGroups: ["rbac.authorization.k8s.io"]
		resources: ["roles"]
		verbs: [
			"create",
			"delete",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}, {
		apiGroups: ["security.openshift.io"]
		resources: ["securitycontextconstraints"]
		verbs: [
			"create",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}, {
		apiGroups: ["security.openshift.io"]
		resourceNames: ["volsync-privileged-mover"]
		resources: ["securitycontextconstraints"]
		verbs: ["use"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshots"]
		verbs: [
			"create",
			"delete",
			"deletecollection",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["storageclasses"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: ["volsync.backube"]
		resources: ["replicationdestinations"]
		verbs: [
			"create",
			"delete",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}, {
		apiGroups: ["volsync.backube"]
		resources: ["replicationdestinations/finalizers"]
		verbs: [
			"create",
			"delete",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}, {
		apiGroups: ["volsync.backube"]
		resources: ["replicationdestinations/status"]
		verbs: [
			"get",
			"patch",
			"update",
		]
	}, {
		apiGroups: ["volsync.backube"]
		resources: ["replicationsources"]
		verbs: [
			"create",
			"delete",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}, {
		apiGroups: ["volsync.backube"]
		resources: ["replicationsources/finalizers"]
		verbs: [
			"create",
			"delete",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}, {
		apiGroups: ["volsync.backube"]
		resources: ["replicationsources/status"]
		verbs: [
			"get",
			"patch",
			"update",
		]
	}]
}, {
	metadata: name: "volsync-metrics-reader"
	rules: [{
		nonResourceURLs: ["/metrics"]
		verbs: ["get"]
	}]
}, {
	metadata: name: "volsync-proxy"
	rules: [{
		apiGroups: ["authentication.k8s.io"]
		resources: ["tokenreviews"]
		verbs: ["create"]
	}, {
		apiGroups: ["authorization.k8s.io"]
		resources: ["subjectaccessreviews"]
		verbs: ["create"]
	}]
}]
