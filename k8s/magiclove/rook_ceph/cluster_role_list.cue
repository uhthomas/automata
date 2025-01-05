package rook_ceph

import (
	admissionregistrationv1 "k8s.io/api/admissionregistration/v1"
	appsv1 "k8s.io/api/apps/v1"
	batchv1 "k8s.io/api/batch/v1"
	"k8s.io/api/core/v1"
	extensionsv1beta1 "k8s.io/api/extensions/v1beta1"
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
	metadata: name: "cephfs-csi-nodeplugin"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["nodes"]
		verbs: ["get"]
	}]
}, {
	metadata: name: "cephfs-external-provisioner-runner"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["secrets"]
		verbs: ["get", "list"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumes"]
		verbs: ["get", "list", "watch", "update", "create", "delete", "patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumeclaims"]
		verbs: ["get", "list", "watch", "patch", "update"]
	}, {
		apiGroups: [storagev1.#GroupName]
		resources: ["storageclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["list", "watch", "create", "update", "patch"]
	}, {
		apiGroups: [storagev1.#GroupName]
		resources: ["volumeattachments"]
		verbs: ["get", "list", "watch", "patch"]
	}, {
		apiGroups: [storagev1.#GroupName]
		resources: ["volumeattachments/status"]
		verbs: ["patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumeclaims/status"]
		verbs: ["patch"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshots"]
		verbs: ["get", "list", "watch", "update", "patch", "create"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotcontents"]
		verbs: ["get", "list", "watch", "patch", "update", "create"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotcontents/status"]
		verbs: ["update", "patch"]
	}, {
		apiGroups: ["groupsnapshot.storage.k8s.io"]
		resources: ["volumegroupsnapshotclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["groupsnapshot.storage.k8s.io"]
		resources: ["volumegroupsnapshotcontents"]
		verbs: ["get", "list", "watch", "update", "patch"]
	}, {
		apiGroups: ["groupsnapshot.storage.k8s.io"]
		resources: ["volumegroupsnapshotcontents/status"]
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
		apiGroups: [v1.#GroupName]
		resources: ["secrets"]
		verbs: ["get", "list"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumes"]
		verbs: ["get", "list"]
	}, {
		apiGroups: [storagev1.#GroupName]
		resources: ["volumeattachments"]
		verbs: ["get", "list"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["configmaps"]
		verbs: ["get"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["serviceaccounts"]
		verbs: ["get"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["serviceaccounts/token"]
		verbs: ["create"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["nodes"]
		verbs: ["get"]
	}]
}, {
	metadata: name: "rbd-external-provisioner-runner"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["secrets"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumes"]
		verbs: ["get", "list", "watch", "create", "update", "delete", "patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumeclaims"]
		verbs: ["get", "list", "watch", "update"]
	}, {
		apiGroups: [storagev1.#GroupName]
		resources: ["storageclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["list", "watch", "create", "update", "patch"]
	}, {
		apiGroups: [storagev1.#GroupName]
		resources: ["volumeattachments"]
		verbs: ["get", "list", "watch", "patch"]
	}, {
		apiGroups: [storagev1.#GroupName]
		resources: ["volumeattachments/status"]
		verbs: ["patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["nodes"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [storagev1.#GroupName]
		resources: ["csinodes"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumeclaims/status"]
		verbs: ["patch"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshots"]
		verbs: ["get", "list", "watch", "update", "patch", "create"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotcontents"]
		verbs: ["get", "list", "watch", "patch", "update", "create"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotcontents/status"]
		verbs: ["update", "patch"]
	}, {
		apiGroups: ["groupsnapshot.storage.k8s.io"]
		resources: ["volumegroupsnapshotclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["groupsnapshot.storage.k8s.io"]
		resources: ["volumegroupsnapshotcontents"]
		verbs: ["get", "list", "watch", "update", "patch"]
	}, {
		apiGroups: ["groupsnapshot.storage.k8s.io"]
		resources: ["volumegroupsnapshotcontents/status"]
		verbs: ["update", "patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["configmaps"]
		verbs: ["get"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["serviceaccounts"]
		verbs: ["get"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["serviceaccounts/token"]
		verbs: ["create"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["nodes"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [storagev1.#GroupName]
		resources: ["csinodes"]
		verbs: ["get", "list", "watch"]
	}]
}, {
	// The cluster role for managing all the cluster-specific resources in a namespace
	metadata: {
		name: "rook-ceph-cluster-mgmt"
		labels: {
			operator:                    "rook"
			"storage-backend":           "ceph"
			"app.kubernetes.io/part-of": "rook-ceph-operator"
		}
	}
	rules: [{
		apiGroups: [v1.#GroupName, appsv1.#GroupName, extensionsv1beta1.#GroupName]
		resources: ["secrets", "pods", "pods/log", "services", "configmaps", "deployments", "daemonsets"]
		verbs: ["get", "list", "watch", "patch", "create", "update", "delete"]
	}]
}, {
	metadata: {
		name: "rook-ceph-global"
		labels: {
			operator:                    "rook"
			"storage-backend":           "ceph"
			"app.kubernetes.io/part-of": "rook-ceph-operator"
		}
	}
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["pods", "nodes", "nodes/proxy", "secrets", "configmaps"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events", "persistentvolumes", "persistentvolumeclaims", "endpoints", "services"]
		verbs: ["get", "list", "watch", "patch", "create", "update", "delete"]
	}, {
		apiGroups: [storagev1.#GroupName]
		resources: ["storageclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [batchv1.#GroupName]
		resources: ["jobs", "cronjobs"]
		verbs: ["get", "list", "watch", "create", "update", "delete", "deletecollection"]
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
			"cephcosidrivers",
		]
		verbs: ["get", "list", "watch", "update"]
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
		apiGroups: [policyv1.#GroupName, appsv1.#GroupName, extensionsv1beta1.#GroupName]
		resources: ["poddisruptionbudgets", "deployments", "replicasets"]
		verbs: ["get", "list", "watch", "create", "update", "delete", "deletecollection"]
	}, {
		apiGroups: [appsv1.#GroupName]
		resources: ["deployments/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["healthchecking.openshift.io"]
		resources: ["machinedisruptionbudgets"]
		verbs: ["get", "list", "watch", "create", "update", "delete"]
	}, {
		apiGroups: ["machine.openshift.io"]
		resources: ["machines"]
		verbs: ["get", "list", "watch", "create", "update", "delete"]
	}, {
		apiGroups: [storagev1.#GroupName]
		resources: ["csidrivers"]
		verbs: ["create", "delete", "get", "update"]
	}, {
		apiGroups: ["k8s.cni.cncf.io"]
		resources: ["network-attachment-definitions"]
		verbs: ["get"]
	}]
}, {
	metadata: {
		name: "rook-ceph-mgr-cluster"
		labels: {
			operator:                    "rook"
			"storage-backend":           "ceph"
			"app.kubernetes.io/part-of": "rook-ceph-operator"
		}
	}
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["configmaps", "nodes", "nodes/proxy", "persistentvolumes"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["create", "patch", "list", "get", "watch"]
	}, {
		apiGroups: [storagev1.#GroupName]
		resources: ["storageclasses"]
		verbs: ["get", "list", "watch"]
	}]
}, {
	metadata: name: "rook-ceph-mgr-system"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["configmaps"]
		verbs: ["get", "list", "watch"]
	}]
}, {
	metadata: {
		name: "rook-ceph-object-bucket"
		labels: {
			operator:                    "rook"
			"storage-backend":           "ceph"
			"app.kubernetes.io/part-of": "rook-ceph-operator"
		}
	}
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["secrets", "configmaps"]
		verbs:
		["get", "create", "update", "delete"]
	}, {
		apiGroups: [storagev1.#GroupName]
		resources: ["storageclasses"]
		verbs: ["get"]
	}, {
		apiGroups: ["objectbucket.io"]
		resources: ["objectbucketclaims"]
		verbs: ["list", "watch", "get", "update"]
	}, {
		apiGroups: ["objectbucket.io"]
		resources: ["objectbuckets"]
		verbs: ["list", "watch", "get", "create", "update", "delete"]
	}, {

		apiGroups: ["objectbucket.io"]
		resources: ["objectbucketclaims/status", "objectbuckets/status"]
		verbs: ["update"]
	}, {
		apiGroups: ["objectbucket.io"]
		resources: ["objectbucketclaims/finalizers", "objectbuckets/finalizers"]
		verbs: ["update"]
	}]
}, {
	metadata: name: "rook-ceph-osd"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["nodes"]
		verbs: ["get", "list"]
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
		apiGroups: [v1.#GroupName]
		resources: ["pods", "pods/log"]
		verbs: ["get", "list"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["pods/exec"]
		verbs: ["create"]
	}, {
		apiGroups: [admissionregistrationv1.#GroupName]
		resources: ["validatingwebhookconfigurations"]
		verbs: ["create", "get", "delete", "update"]
	}, {
		apiGroups: ["csiaddons.openshift.io"]
		resources: ["networkfences"]
		verbs: ["create", "get", "update", "delete", "watch", "list"]
	}, {
		apiGroups: ["apiextensions.k8s.io"]
		resources: ["customresourcedefinitions"]
		verbs: ["get"]
	}]
}, {
	metadata: {
		name: "objectstorage-provisioner-role"
		labels: {
			"app.kubernetes.io/name":      "cosi-driver-ceph"
			"app.kubernetes.io/component": "driver-ceph"
			"app.kubernetes.io/part-of":   "container-object-storage-interface"
		}
	}
	rules: [{
		apiGroups: ["objectstorage.k8s.io"]
		resources: ["buckets", "bucketaccesses", "bucketclaims", "bucketaccessclasses", "buckets/status", "bucketaccesses/status", "bucketclaims/status", "bucketaccessclasses/status"]
		verbs: ["get", "list", "watch", "update", "create", "delete"]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		verbs: ["get", "watch", "list", "delete", "update", "create"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["secrets", "events"]
		verbs: ["get", "delete", "update", "create"]
	}]
}]
