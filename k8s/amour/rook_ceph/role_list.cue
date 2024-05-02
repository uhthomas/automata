package rook_ceph

import (
	appsv1 "k8s.io/api/apps/v1"
	batchv1 "k8s.io/api/batch/v1"
	coordinationv1 "k8s.io/api/coordination/v1"
	"k8s.io/api/core/v1"
	rbacv1 "k8s.io/api/rbac/v1"
)

#RoleList: rbacv1.#RoleList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "Role"
	}]
}

#RoleList: items: [{
	metadata: name: "cephfs-external-provisioner-cfg"
	rules: [{
		apiGroups: [coordinationv1.#GroupName]
		resources: ["leases"]
		verbs: ["get", "watch", "list", "delete", "update", "create"]
	}]
}, {
	metadata: name: "rbd-csi-nodeplugin"
	rules: [{
		apiGroups: ["csiaddons.openshift.io"]
		resources: ["csiaddonsnodes"]
		verbs: ["create"]
	}]
}, {
	metadata: name: "rbd-external-provisioner-cfg"
	rules: [{
		apiGroups: [coordinationv1.#GroupName]
		resources: ["leases"]
		verbs: ["get", "watch", "list", "delete", "update", "create"]
	}, {
		apiGroups: ["csiaddons.openshift.io"]
		resources: ["csiaddonsnodes"]
		verbs: ["create"]
	}]
}, {
	metadata: name: "rook-ceph-cmd-reporter"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["pods", "configmaps"]
		verbs: ["get", "list", "watch", "create", "update", "delete"]
	}]
}, {
	// Aspects of ceph-mgr that operate within the cluster's namespace
	metadata: name: "rook-ceph-mgr"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["pods", "services", "pods/log"]
		verbs: ["get", "list", "watch", "create", "update", "delete"]
	}, {
		apiGroups: [batchv1.#GroupName]
		resources: ["jobs"]
		verbs: ["get", "list", "watch", "create", "update", "delete"]
	}, {
		apiGroups: ["ceph.rook.io"]
		resources: ["cephclients", "cephclusters", "cephblockpools", "cephfilesystems", "cephnfses", "cephobjectstores", "cephobjectstoreusers", "cephobjectrealms", "cephobjectzonegroups", "cephobjectzones", "cephbuckettopics", "cephbucketnotifications", "cephrbdmirrors", "cephfilesystemmirrors", "cephfilesystemsubvolumegroups", "cephblockpoolradosnamespaces"]
		verbs: ["get", "list", "watch", "create", "update", "delete", "patch"]
	}, {
		apiGroups: [appsv1.#GroupName]
		resources: ["deployments/scale", "deployments"]
		verbs: ["patch", "delete"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumeclaims"]
		verbs: ["delete"]
	}]
}, {
	metadata: name: "rook-ceph-osd"
	rules: [{
		// this is needed for rook's "key-management" CLI to fetch the vault token from the secret when
		// validating the connection details
		apiGroups: [v1.#GroupName]
		resources: ["secrets"]
		verbs: ["get"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["configmaps"]
		verbs: ["get", "list", "watch", "create", "update", "delete"]
	}, {
		apiGroups: ["ceph.rook.io"]
		resources: ["cephclusters", "cephclusters/finalizers"]
		verbs: ["get", "list", "create", "update", "delete"]
	}]
}, {
	// Aspects of ceph osd purge job that require access to the cluster namespace
	metadata: name: "rook-ceph-purge-osd"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["configmaps"]
		verbs: ["get"]
	}, {
		apiGroups: [appsv1.#GroupName]
		resources: ["deployments"]
		verbs: ["get", "delete"]
	}, {
		apiGroups: [batchv1.#GroupName]
		resources: ["jobs"]
		verbs: ["get", "list", "delete"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumeclaims"]
		verbs: ["get", "update", "delete", "list"]
	}]
}, {
	// Allow the operator to manage resources in its own namespace
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
		resources: ["pods", "configmaps", "services"]
		verbs: ["get", "list", "watch", "patch", "create", "update", "delete"]
	}, {
		apiGroups: [appsv1.#GroupName, "extensions"]
		resources: ["daemonsets", "statefulsets", "deployments"]
		verbs: ["get", "list", "watch", "create", "update", "delete"]
	}, {
		apiGroups: [batchv1.#GroupName]
		resources: ["cronjobs"]
		verbs: ["delete", "deletecollection"]
	}, {
		apiGroups: ["cert-manager.io"]
		resources: ["certificates", "issuers"]
		verbs: ["get", "create", "delete"]
	}]
}, {
	metadata: name: "rook-ceph-monitor"
	rules: [{
		apiGroups: ["monitoring.coreos.com"]
		resources: ["servicemonitors"]
		verbs: ["get", "list", "watch", "create", "update", "delete"]
	}]
}, {
	metadata: name: "rook-ceph-metrics"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["services", "endpoints", "pods"]
		verbs: ["get", "list", "watch"]
	}]
}, {
	metadata: name: "rook-ceph-monitor-mgr"
	rules: [{
		apiGroups: ["monitoring.coreos.com"]
		resources: ["servicemonitors"]
		verbs: ["get", "list", "create", "update"]
	}]
}]
