package rook_ceph

import rbacv1 "k8s.io/api/rbac/v1"

#ClusterRoleList: rbacv1.#ClusterRoleList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRole"
	}]
}

#ClusterRoleList: items: [{
	// TODO: remove this, once https://github.com/rook/rook/issues/10141
	// is resolved.
	metadata: name: "cephfs-csi-nodeplugin"
	rules: [{
		apiGroups: [""]
		resources: ["nodes"]
		verbs: ["get"]
	}]
}, {
	metadata: name: "cephfs-external-provisioner-runner"
	rules: [{
		apiGroups: [""]
		resources: ["secrets"]
		verbs: ["get", "list"]
	}, {
		apiGroups: [""]
		resources: ["persistentvolumes"]
		verbs: ["get", "list", "watch", "create", "delete", "patch"]
	}, {
		apiGroups: [""]
		resources: ["persistentvolumeclaims"]
		verbs: ["get", "list", "watch", "patch", "update"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["storageclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [""]
		resources: ["events"]
		verbs: ["list", "watch", "create", "update", "patch"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["volumeattachments"]
		verbs: ["get", "list", "watch", "patch"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["volumeattachments/status"]
		verbs: ["patch"]
	}, {
		apiGroups: [""]
		resources: ["persistentvolumeclaims/status"]
		verbs: ["patch"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshots"]
		verbs: ["get", "list"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotcontents"]
		verbs: ["get", "list", "watch", "patch", "update"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotcontents/status"]
		verbs: ["update", "patch"]
	}]
}, {
	metadata: {
		name: "rbd-csi-nodeplugin"
		labels: {
			operator:                    "rook"
			"storage-backend":           "ceph"
			"app.kubernetes.io/part-of": "rook-ceph-operator"
		}
	}
	rules: [{
		apiGroups: [""]
		resources: ["secrets"]
		verbs: ["get", "list"]
	}, {
		apiGroups: [""]
		resources: ["persistentvolumes"]
		verbs: ["get", "list"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["volumeattachments"]
		verbs: ["get", "list"]
	}, {
		apiGroups: [""]
		resources: ["configmaps"]
		verbs: ["get"]
	}, {
		apiGroups: [""]
		resources: ["serviceaccounts"]
		verbs: ["get"]
	}, {
		apiGroups: [""]
		resources: ["serviceaccounts/token"]
		verbs: ["create"]
	}, {
		apiGroups: [""]
		resources: ["nodes"]
		verbs: ["get"]
	}]
}, {
	metadata: name: "rbd-external-provisioner-runner"
	rules: [{
		apiGroups: [""]
		resources: ["secrets"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [""]
		resources: ["persistentvolumes"]
		verbs: ["get", "list", "watch", "create", "delete", "patch"]
	}, {
		apiGroups: [""]
		resources: ["persistentvolumeclaims"]
		verbs: ["get", "list", "watch", "update"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["storageclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [""]
		resources: ["events"]
		verbs: ["list", "watch", "create", "update", "patch"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["volumeattachments"]
		verbs: ["get", "list", "watch", "patch"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["volumeattachments/status"]
		verbs: ["patch"]
	}, {
		apiGroups: [""]
		resources: ["nodes"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["csinodes"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [""]
		resources: ["persistentvolumeclaims/status"]
		verbs: ["patch"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshots"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotcontents"]
		verbs: ["get", "list", "watch", "patch", "update"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotcontents/status"]
		verbs: ["update", "patch"]
	}, {
		apiGroups: [""]
		resources: ["configmaps"]
		verbs: ["get"]
	}, {
		apiGroups: [""]
		resources: ["serviceaccounts"]
		verbs: ["get"]
	}, {
		apiGroups: [""]
		resources: ["serviceaccounts/token"]
		verbs: ["create"]
	}, {
		apiGroups: [""]
		resources: ["nodes"]
		verbs: ["get", "list", "watch\""]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["csinodes"]
		verbs: ["get", "list", "watch"]
	}]
}, {
	// The cluster role for managing all the cluster-specific resources in a namespace
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: {
		name: "rook-ceph-cluster-mgmt"
		labels: {
			operator:                    "rook"
			"storage-backend":           "ceph"
			"app.kubernetes.io/part-of": "rook-ceph-operator"
		}
	}
	rules: [{
		apiGroups: [
			"",
			"apps",
			"extensions",
		]
		resources: [
			"secrets",
			"pods",
			"pods/log",
			"services",
			"configmaps",
			"deployments",
			"daemonsets",
		]
		verbs: [
			"get",
			"list",
			"watch",
			"patch",
			"create",
			"update",
			"delete",
		]
	}]
}, {
	// The cluster role for managing the Rook CRDs
	apiVersion: "rbac.authorization.k8s.io/v1"
	// Rook watches for its CRDs in all namespaces, so this should be a cluster-scoped role unless the
	// operator config `ROOK_CURRENT_NAMESPACE_ONLY=true`.
	kind: "ClusterRole"
	metadata: {
		name: "rook-ceph-global"
		labels: {
			operator:                    "rook"
			"storage-backend":           "ceph"
			"app.kubernetes.io/part-of": "rook-ceph-operator"
		}
	}
	rules: [{
		apiGroups: [
			"",
		]
		resources:
		// Pod access is needed for fencing
		[
			"pods",
			"nodes",
			"nodes/proxy",
			"services",
			"secrets",
			"configmaps",
		]
		// Node access is needed for determining nodes where mons should run
		// Rook watches secrets which it uses to configure access to external resources.
		// e.g., external Ceph cluster; TLS certificates for the admission controller or object store
		// Rook watches for changes to the rook-operator-config configmap
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"",
		]
		resources:
		// Rook creates events for its custom resources
		[
			"events",
			"persistentvolumes",
			"persistentvolumeclaims",
			"endpoints",
		]
		// Rook creates PVs and PVCs for OSDs managed by the Rook provisioner
		// Rook creates endpoints for mgr and object store access
		verbs: [
			"get",
			"list",
			"watch",
			"patch",
			"create",
			"update",
			"delete",
		]
	}, {
		apiGroups: [
			"storage.k8s.io",
		]
		resources: [
			"storageclasses",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"batch",
		]
		resources: [
			"jobs",
			"cronjobs",
		]
		verbs: [
			"get",
			"list",
			"watch",
			"create",
			"update",
			"delete",
		]
	}, {
		// The Rook operator must be able to watch all ceph.rook.io resources to reconcile them.
		apiGroups: ["ceph.rook.io"]
		resources: [
			"cephclients",
			"cephclusters",
			"cephblockpools",
			"cephfilesystems",
			"cephnfses",
			"cephobjectstores",
			"cephobjectstoreusers",
			"cephobjectrealms",
			"cephobjectzonegroups",
			"cephobjectzones",
			"cephbuckettopics",
			"cephbucketnotifications",
			"cephrbdmirrors",
			"cephfilesystemmirrors",
			"cephfilesystemsubvolumegroups",
			"cephblockpoolradosnamespaces",
		]
		verbs: [
			"get",
			"list",
			"watch",
			"update",
		]
	}, {
		// Ideally the update permission is not required, but Rook needs it to add finalizers to resources.
		// Rook must have update access to status subresources for its custom resources.
		apiGroups: ["ceph.rook.io"]
		resources: [
			"cephclients/status",
			"cephclusters/status",
			"cephblockpools/status",
			"cephfilesystems/status",
			"cephnfses/status",
			"cephobjectstores/status",
			"cephobjectstoreusers/status",
			"cephobjectrealms/status",
			"cephobjectzonegroups/status",
			"cephobjectzones/status",
			"cephbuckettopics/status",
			"cephbucketnotifications/status",
			"cephrbdmirrors/status",
			"cephfilesystemmirrors/status",
			"cephfilesystemsubvolumegroups/status",
			"cephblockpoolradosnamespaces/status",
		]
		verbs: ["update"]
	}, {
		// The "*/finalizers" permission may need to be strictly given for K8s clusters where
		// OwnerReferencesPermissionEnforcement is enabled so that Rook can set blockOwnerDeletion on
		// resources owned by Rook CRs (e.g., a Secret owned by an OSD Deployment). See more:
		// https://kubernetes.io/docs/reference/access-authn-authz/_print/#ownerreferencespermissionenforcement
		apiGroups: ["ceph.rook.io"]
		resources: [
			"cephclients/finalizers",
			"cephclusters/finalizers",
			"cephblockpools/finalizers",
			"cephfilesystems/finalizers",
			"cephnfses/finalizers",
			"cephobjectstores/finalizers",
			"cephobjectstoreusers/finalizers",
			"cephobjectrealms/finalizers",
			"cephobjectzonegroups/finalizers",
			"cephobjectzones/finalizers",
			"cephbuckettopics/finalizers",
			"cephbucketnotifications/finalizers",
			"cephrbdmirrors/finalizers",
			"cephfilesystemmirrors/finalizers",
			"cephfilesystemsubvolumegroups/finalizers",
			"cephblockpoolradosnamespaces/finalizers",
		]
		verbs: ["update"]
	}, {
		apiGroups: [
			"policy",
			"apps",
			"extensions",
		]
		resources:
		// This is for the clusterdisruption controller
		[
			"poddisruptionbudgets",
			"deployments",
			"replicasets",
		]
		// This is for both clusterdisruption and nodedrain controllers
		verbs: [
			"get",
			"list",
			"watch",
			"create",
			"update",
			"delete",
			"deletecollection",
		]
	}, {
		apiGroups: [
			"healthchecking.openshift.io",
		]
		resources: [
			"machinedisruptionbudgets",
		]
		verbs: [
			"get",
			"list",
			"watch",
			"create",
			"update",
			"delete",
		]
	}, {
		apiGroups: [
			"machine.openshift.io",
		]
		resources: [
			"machines",
		]
		verbs: [
			"get",
			"list",
			"watch",
			"create",
			"update",
			"delete",
		]
	}, {
		apiGroups: [
			"storage.k8s.io",
		]
		resources: [
			"csidrivers",
		]
		verbs: [
			"create",
			"delete",
			"get",
			"update",
		]
	}, {
		apiGroups: [
			"k8s.cni.cncf.io",
		]
		resources: [
			"network-attachment-definitions",
		]
		verbs: [
			"get",
		]
	}]
}, {
	// Aspects of ceph-mgr that require cluster-wide access
	metadata: {
		name: "rook-ceph-mgr-cluster"
		labels: {
			operator:                    "rook"
			"storage-backend":           "ceph"
			"app.kubernetes.io/part-of": "rook-ceph-operator"
		}
	}
	rules: [{
		apiGroups: [
			"",
		]
		resources: [
			"configmaps",
			"nodes",
			"nodes/proxy",
			"persistentvolumes",
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
			"list",
			"get",
			"watch",
		]
	}, {
		apiGroups: [
			"storage.k8s.io",
		]
		resources: [
			"storageclasses",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}]
}, {
	// Aspects of ceph-mgr that require access to the system namespace
	metadata: name: "rook-ceph-mgr-system"
	rules: [{
		apiGroups: [
			"",
		]
		resources: [
			"configmaps",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}]
}, {
	// Used for provisioning ObjectBuckets (OBs) in response to ObjectBucketClaims (OBCs).
	// Note: Rook runs a copy of the lib-bucket-provisioner's OBC controller.
	// OBCs can be created in any Kubernetes namespace, so this must be a cluster-scoped role.
	metadata: {
		name: "rook-ceph-object-bucket"
		labels: {
			operator:                    "rook"
			"storage-backend":           "ceph"
			"app.kubernetes.io/part-of": "rook-ceph-operator"
		}
	}
	rules: [{
		apiGroups: [""]
		resources: ["secrets", "configmaps"]
		verbs:
		// OBC controller creates secrets and configmaps containing information for users about how to
		// connect to object buckets. It deletes them when an OBC is deleted.
		[
			"get",
			"create",
			"update",
			"delete",
		]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["storageclasses"]
		verbs:
		// OBC controller gets parameters from the OBC's storageclass
		// Rook gets additional parameters from the OBC's storageclass
		[
			"get",
		]
	}, {
		apiGroups: ["objectbucket.io"]
		resources: ["objectbucketclaims"]
		verbs:
		// OBC controller needs to list/watch OBCs and get latest version of a reconciled OBC
		[
			"list",
			"watch",
			"get",
			"update",
		]
	}, {
		// Ideally, update should not be needed, but the OBC controller updates the OBC with bucket
		// information outside of the status subresource
		// OBC controller does not delete OBCs; users do this
		apiGroups: ["objectbucket.io"]
		resources: ["objectbuckets"]
		verbs:
		// OBC controller needs to list/watch OBs and get latest version of a reconciled OB
		[
			"list",
			"watch",
			"get",
			"create",
			"update",
			"delete",
		]
	}, {

		apiGroups: ["objectbucket.io"]
		resources: ["objectbucketclaims/status", "objectbuckets/status"]
		verbs:
		// OBC controller updates OBC and OB statuses
		[
			"update",
		]
		// OBC controller creates an OB when an OBC's bucket has been provisioned by Ceph, updates them
		// when an OBC is updated, and deletes them when the OBC is de-provisioned.
	}, {
		apiGroups: ["objectbucket.io"]
		// This does not strictly allow the OBC/OB controllers to update finalizers. That is handled by
		// the direct "update" permissions above. Instead, this allows Rook's controller to create
		// resources which are owned by OBs/OBCs and where blockOwnerDeletion is set.
		resources: ["objectbucketclaims/finalizers", "objectbuckets/finalizers"]
		verbs: [
			"update",
		]
	}]
}, {
	metadata: name: "rook-ceph-osd"
	rules: [{
		apiGroups: [
			"",
		]
		resources: [
			"nodes",
		]
		verbs: [
			"get",
			"list",
		]
	}]
}, {
	metadata: {
		name: "rook-ceph-system"
		labels: {
			operator:                    "rook"
			"storage-backend":           "ceph"
			"app.kubernetes.io/part-of": "rook-ceph-operator"
		}
	}
	rules: [{
		// Most resources are represented by a string representation of their name, such as "pods", just as it appears in the URL for the relevant API endpoint.
		// However, some Kubernetes APIs involve a "subresource", such as the logs for a pod. [...]
		// To represent this in an RBAC role, use a slash to delimit the resource and subresource.
		// https://kubernetes.io/docs/reference/access-authn-authz/rbac/#referring-to-resources
		apiGroups: [""]
		resources: ["pods", "pods/log"]
		verbs: ["get", "list"]
	}, {
		apiGroups: [""]
		resources: ["pods/exec"]
		verbs: ["create"]
	}, {
		apiGroups: ["admissionregistration.k8s.io"]
		resources: ["validatingwebhookconfigurations"]
		verbs: ["create", "get", "delete", "update"]
	}]
}]
