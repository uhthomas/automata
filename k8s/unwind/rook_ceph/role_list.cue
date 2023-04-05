package rook_ceph

import rbacv1 "k8s.io/api/rbac/v1"

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
		apiGroups: ["coordination.k8s.io"]
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
		apiGroups: ["coordination.k8s.io"]
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
		apiGroups: [""]
		resources: ["pods", "configmaps"]
		verbs: ["get", "list", "watch", "create", "update", "delete"]
	}]
}, {
	// Aspects of ceph-mgr that operate within the cluster's namespace
	metadata: name: "rook-ceph-mgr"
	rules: [{
		apiGroups: [""]
		resources: ["pods", "services", "pods/log"]
		verbs: ["get", "list", "watch", "create", "update", "delete"]
	}, {
		apiGroups: ["batch"]
		resources: ["jobs"]
		verbs: ["get", "list", "watch", "create", "update", "delete"]
	}, {
		apiGroups: ["ceph.rook.io"]
		resources: ["cephclients", "cephclusters", "cephblockpools", "cephfilesystems", "cephnfses", "cephobjectstores", "cephobjectstoreusers", "cephobjectrealms", "cephobjectzonegroups", "cephobjectzones", "cephbuckettopics", "cephbucketnotifications", "cephrbdmirrors", "cephfilesystemmirrors", "cephfilesystemsubvolumegroups", "cephblockpoolradosnamespaces"]
		verbs: ["get", "list", "watch", "create", "update", "delete", "patch"]
	}, {
		apiGroups: ["apps"]
		resources: ["deployments/scale", "deployments"]
		verbs: ["patch", "delete"]
	}, {
		apiGroups: [""]
		resources: ["persistentvolumeclaims"]
		verbs: ["delete"]
	}]
}, {
	metadata: name: "rook-ceph-osd"
	rules: [{
		// this is needed for rook's "key-management" CLI to fetch the vault token from the secret when
		// validating the connection details
		apiGroups: [""]
		resources: ["secrets"]
		verbs: ["get"]
	}, {
		apiGroups: [""]
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
		apiGroups: [""]
		resources: ["configmaps"]
		verbs: ["get"]
	}, {
		apiGroups: ["apps"]
		resources: ["deployments"]
		verbs: ["get", "delete"]
	}, {
		apiGroups: ["batch"]
		resources: ["jobs"]
		verbs: ["get", "list", "delete"]
	}, {
		apiGroups: [""]
		resources: ["persistentvolumeclaims"]
		verbs: ["get", "update", "delete", "list"]
	}]
}, {
	metadata: name: "rook-ceph-rgw"
	rules: [{
		// Placeholder role so the rgw service account will
		// be generated in the csv. Remove this role and role binding
		// when fixing https://github.com/rook/rook/issues/10141.
		apiGroups: [""]
		resources: ["configmaps"]
		verbs: ["get"]
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
		apiGroups: [""]
		resources: ["pods", "configmaps", "services"]
		verbs: ["get", "list", "watch", "patch", "create", "update", "delete"]
	}, {
		apiGroups: ["apps", "extensions"]
		resources: ["daemonsets", "statefulsets", "deployments"]
		verbs: ["get", "list", "watch", "create", "update", "delete"]
	}, {
		apiGroups: ["batch"]
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
		apiGroups: [""]
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
