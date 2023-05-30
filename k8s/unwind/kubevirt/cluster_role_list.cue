package kubevirt

import (
	rbacv1 "k8s.io/api/rbac/v1"
	"k8s.io/api/core/v1"
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
		name: "kubevirt.io:operator"
		labels: {
			"operator.kubevirt.io":                         ""
			"rbac.authorization.k8s.io/aggregate-to-admin": "true"
		}
	}
	rules: [{
		apiGroups: ["kubevirt.io"]
		resources: ["kubevirts"]
		verbs: ["get", "delete", "create", "update", "patch", "list", "watch", "deletecollection"]
	}]
}, {
	metadata: {
		name: "kubevirt-operator"
		labels: "kubevirt.io": ""
	}
	rules: [{
		apiGroups: ["kubevirt.io"]
		resources: ["kubevirts"]
		verbs: ["get", "list", "watch", "patch", "update", "patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["serviceaccounts", "services", "endpoints", "pods/exec"]
		verbs: ["get", "list", "watch", "create", "update", "delete", "patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["configmaps"]
		verbs: ["patch", "delete"]
	}, {
		apiGroups: ["batch"]
		resources: ["jobs"]
		verbs: ["get", "list", "watch", "create", "delete", "patch"]
	}, {
		apiGroups: ["apps"]
		resources: ["controllerrevisions"]
		verbs: ["watch", "list", "create", "delete", "patch"]
	}, {
		apiGroups: ["apps"]
		resources: ["deployments", "daemonsets"]
		verbs: ["get", "list", "watch", "create", "delete", "patch"]
	}, {
		apiGroups: ["rbac.authorization.k8s.io"]
		resources: ["clusterroles", "clusterrolebindings", "roles", "rolebindings"]
		verbs: ["get", "list", "watch", "create", "delete", "patch", "update"]
	}, {
		apiGroups: ["apiextensions.k8s.io"]
		resources: ["customresourcedefinitions"]
		verbs: ["get", "list", "watch", "create", "delete", "patch"]
	}, {
		apiGroups: ["security.openshift.io"]
		resources: ["securitycontextconstraints"]
		verbs: ["create", "get", "list", "watch"]
	}, {
		apiGroups: ["security.openshift.io"]
		resourceNames: ["privileged"]
		resources: ["securitycontextconstraints"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["security.openshift.io"]
		resourceNames: ["kubevirt-handler", "kubevirt-controller"]
		resources: ["securitycontextconstraints"]
		verbs: ["get", "list", "watch", "update", "delete"]
	}, {
		apiGroups: ["admissionregistration.k8s.io"]
		resources: ["validatingwebhookconfigurations", "mutatingwebhookconfigurations"]
		verbs: ["get", "list", "watch", "create", "delete", "update", "patch"]
	}, {
		apiGroups: ["apiregistration.k8s.io"]
		resources: ["apiservices"]
		verbs: ["get", "list", "watch", "create", "delete", "update", "patch"]
	}, {
		apiGroups: ["monitoring.coreos.com"]
		resources: ["servicemonitors", "prometheusrules"]
		verbs: ["get", "list", "watch", "create", "delete", "update", "patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["namespaces"]
		verbs: ["get", "list", "watch", "patch"]
	}, {
		apiGroups: ["flavor.kubevirt.io"]
		resources: ["virtualmachineflavors", "virtualmachineclusterflavors", "virtualmachinepreferences", "virtualmachineclusterpreferences"]
		verbs: ["get", "delete", "create", "update", "patch", "list", "watch", "deletecollection"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["pods"]
		verbs: ["get", "list", "delete", "patch"]
	}, {
		apiGroups: ["kubevirt.io"]
		resources: ["virtualmachines", "virtualmachineinstances"]
		verbs: ["get", "list", "watch", "patch", "update"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumeclaims"]
		verbs: ["get"]
	}, {
		apiGroups: ["kubevirt.io"]
		resources: ["virtualmachines/status"]
		verbs: ["patch"]
	}, {
		apiGroups: ["kubevirt.io"]
		resources: ["virtualmachineinstancemigrations"]
		verbs: ["create", "get", "list", "watch", "patch"]
	}, {
		apiGroups: ["kubevirt.io"]
		resources: ["virtualmachineinstancepresets"]
		verbs: ["watch", "list"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["configmaps"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["limitranges"]
		verbs: ["watch", "list"]
	}, {
		apiGroups: ["apiextensions.k8s.io"]
		resources: ["customresourcedefinitions"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["kubevirt.io"]
		resources: ["kubevirts"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["snapshot.kubevirt.io"]
		resources: ["virtualmachinesnapshots", "virtualmachinerestores", "virtualmachinesnapshotcontents"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["cdi.kubevirt.io"]
		resources: ["datasources", "datavolumes"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["instancetype.kubevirt.io"]
		resources: ["virtualmachineinstancetypes", "virtualmachineclusterinstancetypes", "virtualmachinepreferences", "virtualmachineclusterpreferences"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["migrations.kubevirt.io"]
		resources: ["migrationpolicies"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["apps"]
		resources: ["controllerrevisions"]
		verbs: ["create", "list", "get"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["configmaps"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["namespaces"]
		verbs: ["get", "list", "watch", "patch"]
	}, {
		apiGroups: ["policy"]
		resources: ["poddisruptionbudgets"]
		verbs: ["get", "list", "watch", "delete", "create", "patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["pods", "configmaps", "endpoints", "services"]
		verbs: ["get", "list", "watch", "delete", "update", "create", "patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["update", "create", "patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["secrets"]
		verbs: ["create"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["pods/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["pods/eviction"]
		verbs: ["create"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["pods/status"]
		verbs: ["patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["nodes"]
		verbs: ["get", "list", "watch", "update", "patch"]
	}, {
		apiGroups: ["apps"]
		resources: ["daemonsets"]
		verbs: ["list"]
	}, {
		apiGroups: ["apps"]
		resources: ["controllerrevisions"]
		verbs: ["watch", "list", "create", "delete", "get", "update"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumeclaims"]
		verbs: ["get", "list", "watch", "create", "update", "delete", "patch"]
	}, {
		apiGroups: ["snapshot.kubevirt.io"]
		resources: ["*"]
		verbs: ["*"]
	}, {
		apiGroups: ["export.kubevirt.io"]
		resources: ["*"]
		verbs: ["*"]
	}, {
		apiGroups: ["pool.kubevirt.io"]
		resources: ["virtualmachinepools", "virtualmachinepools/finalizers", "virtualmachinepools/status", "virtualmachinepools/scale"]
		verbs: ["watch", "list", "create", "delete", "update", "patch", "get"]
	}, {
		apiGroups: ["kubevirt.io"]
		resources: ["*"]
		verbs: ["*"]
	}, {
		apiGroups: ["subresources.kubevirt.io"]
		resources: ["virtualmachineinstances/addvolume", "virtualmachineinstances/removevolume", "virtualmachineinstances/freeze", "virtualmachineinstances/unfreeze", "virtualmachineinstances/softreboot"]
		verbs: ["update"]
	}, {
		apiGroups: ["cdi.kubevirt.io"]
		resources: ["*"]
		verbs: ["*"]
	}, {
		apiGroups: ["k8s.cni.cncf.io"]
		resources: ["network-attachment-definitions"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["apiextensions.k8s.io"]
		resources: ["customresourcedefinitions"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["authorization.k8s.io"]
		resources: ["subjectaccessreviews"]
		verbs: ["create"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshots"]
		verbs: ["get", "list", "watch", "create", "update", "delete"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["storageclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["instancetype.kubevirt.io"]
		resources: ["virtualmachineinstancetypes", "virtualmachineclusterinstancetypes", "virtualmachinepreferences", "virtualmachineclusterpreferences"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["migrations.kubevirt.io"]
		resources: ["migrationpolicies"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["clone.kubevirt.io"]
		resources: ["virtualmachineclones", "virtualmachineclones/status", "virtualmachineclones/finalizers"]
		verbs: ["get", "list", "watch", "update", "patch", "delete"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["namespaces"]
		verbs: ["get"]
	}, {
		apiGroups: ["route.openshift.io"]
		resources: ["routes"]
		verbs: ["list", "get", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["secrets"]
		verbs: ["list", "get", "watch"]
	}, {
		apiGroups: ["networking.k8s.io"]
		resources: ["ingresses"]
		verbs: ["list", "get", "watch"]
	}, {
		apiGroups: ["kubevirt.io"]
		resources: ["virtualmachineinstances"]
		verbs: ["update", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["nodes"]
		verbs: ["patch", "list", "watch", "get"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["configmaps"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["create", "patch"]
	}, {
		apiGroups: ["apiextensions.k8s.io"]
		resources: ["customresourcedefinitions"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["kubevirt.io"]
		resources: ["kubevirts"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["migrations.kubevirt.io"]
		resources: ["migrationpolicies"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["configmaps"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["export.kubevirt.io"]
		resources: ["virtualmachineexports"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["kubevirt.io"]
		resources: ["kubevirts"]
		verbs: ["list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resourceNames: ["kubevirt-export-ca"]
		resources: ["configmaps"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["subresources.kubevirt.io"]
		resources: ["version", "guestfs"]
		verbs: ["get", "list"]
	}, {
		apiGroups: ["subresources.kubevirt.io"]
		resources: ["virtualmachineinstances/console", "virtualmachineinstances/vnc", "virtualmachineinstances/vnc/screenshot", "virtualmachineinstances/portforward", "virtualmachineinstances/guestosinfo", "virtualmachineinstances/filesystemlist", "virtualmachineinstances/userlist"]
		verbs: ["get"]
	}, {
		apiGroups: ["subresources.kubevirt.io"]
		resources: ["virtualmachineinstances/pause", "virtualmachineinstances/unpause", "virtualmachineinstances/addvolume", "virtualmachineinstances/removevolume", "virtualmachineinstances/freeze", "virtualmachineinstances/unfreeze", "virtualmachineinstances/softreboot"]
		verbs: ["update"]
	}, {
		apiGroups: ["subresources.kubevirt.io"]
		resources: ["virtualmachines/expand-spec", "virtualmachines/portforward"]
		verbs: ["get"]
	}, {
		apiGroups: ["subresources.kubevirt.io"]
		resources: ["virtualmachines/start", "virtualmachines/stop", "virtualmachines/restart", "virtualmachines/addvolume", "virtualmachines/removevolume", "virtualmachines/migrate", "virtualmachines/memorydump"]
		verbs: ["update"]
	}, {
		apiGroups: ["subresources.kubevirt.io"]
		resources: ["expand-vm-spec"]
		verbs: ["update"]
	}, {
		apiGroups: ["kubevirt.io"]
		resources: ["virtualmachines", "virtualmachineinstances", "virtualmachineinstancepresets", "virtualmachineinstancereplicasets", "virtualmachineinstancemigrations"]
		verbs: ["get", "delete", "create", "update", "patch", "list", "watch", "deletecollection"]
	}, {
		apiGroups: ["snapshot.kubevirt.io"]
		resources: ["virtualmachinesnapshots", "virtualmachinesnapshotcontents", "virtualmachinerestores"]
		verbs: ["get", "delete", "create", "update", "patch", "list", "watch", "deletecollection"]
	}, {
		apiGroups: ["instancetype.kubevirt.io"]
		resources: ["virtualmachineinstancetypes", "virtualmachineclusterinstancetypes", "virtualmachinepreferences", "virtualmachineclusterpreferences"]
		verbs: ["get", "delete", "create", "update", "patch", "list", "watch", "deletecollection"]
	}, {
		apiGroups: ["pool.kubevirt.io"]
		resources: ["virtualmachinepools"]
		verbs: ["get", "delete", "create", "update", "patch", "list", "watch", "deletecollection"]
	}, {
		apiGroups: ["migrations.kubevirt.io"]
		resources: ["migrationpolicies"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["subresources.kubevirt.io"]
		resources: ["virtualmachineinstances/console", "virtualmachineinstances/vnc", "virtualmachineinstances/vnc/screenshot", "virtualmachineinstances/portforward", "virtualmachineinstances/guestosinfo", "virtualmachineinstances/filesystemlist", "virtualmachineinstances/userlist"]
		verbs: ["get"]
	}, {
		apiGroups: ["subresources.kubevirt.io"]
		resources: ["virtualmachineinstances/pause", "virtualmachineinstances/unpause", "virtualmachineinstances/addvolume", "virtualmachineinstances/removevolume", "virtualmachineinstances/freeze", "virtualmachineinstances/unfreeze", "virtualmachineinstances/softreboot"]
		verbs: ["update"]
	}, {
		apiGroups: ["subresources.kubevirt.io"]
		resources: ["virtualmachines/expand-spec", "virtualmachines/portforward"]
		verbs: ["get"]
	}, {
		apiGroups: ["subresources.kubevirt.io"]
		resources: ["virtualmachines/start", "virtualmachines/stop", "virtualmachines/restart", "virtualmachines/addvolume", "virtualmachines/removevolume", "virtualmachines/migrate", "virtualmachines/memorydump"]
		verbs: ["update"]
	}, {
		apiGroups: ["subresources.kubevirt.io"]
		resources: ["expand-vm-spec"]
		verbs: ["update"]
	}, {
		apiGroups: ["kubevirt.io"]
		resources: ["virtualmachines", "virtualmachineinstances", "virtualmachineinstancepresets", "virtualmachineinstancereplicasets", "virtualmachineinstancemigrations"]
		verbs: ["get", "delete", "create", "update", "patch", "list", "watch"]
	}, {
		apiGroups: ["snapshot.kubevirt.io"]
		resources: ["virtualmachinesnapshots", "virtualmachinesnapshotcontents", "virtualmachinerestores"]
		verbs: ["get", "delete", "create", "update", "patch", "list", "watch"]
	}, {
		apiGroups: ["instancetype.kubevirt.io"]
		resources: ["virtualmachineinstancetypes", "virtualmachineclusterinstancetypes", "virtualmachinepreferences", "virtualmachineclusterpreferences"]
		verbs: ["get", "delete", "create", "update", "patch", "list", "watch"]
	}, {
		apiGroups: ["pool.kubevirt.io"]
		resources: ["virtualmachinepools"]
		verbs: ["get", "delete", "create", "update", "patch", "list", "watch"]
	}, {
		apiGroups: ["kubevirt.io"]
		resources: ["kubevirts"]
		verbs: ["get", "list"]
	}, {
		apiGroups: ["migrations.kubevirt.io"]
		resources: ["migrationpolicies"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["subresources.kubevirt.io"]
		resources: ["virtualmachines/expand-spec", "virtualmachineinstances/guestosinfo", "virtualmachineinstances/filesystemlist", "virtualmachineinstances/userlist"]
		verbs: ["get"]
	}, {
		apiGroups: ["subresources.kubevirt.io"]
		resources: ["expand-vm-spec"]
		verbs: ["update"]
	}, {
		apiGroups: ["kubevirt.io"]
		resources: ["virtualmachines", "virtualmachineinstances", "virtualmachineinstancepresets", "virtualmachineinstancereplicasets", "virtualmachineinstancemigrations"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["snapshot.kubevirt.io"]
		resources: ["virtualmachinesnapshots", "virtualmachinesnapshotcontents", "virtualmachinerestores"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["instancetype.kubevirt.io"]
		resources: ["virtualmachineinstancetypes", "virtualmachineclusterinstancetypes", "virtualmachinepreferences", "virtualmachineclusterpreferences"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["pool.kubevirt.io"]
		resources: ["virtualmachinepools"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["migrations.kubevirt.io"]
		resources: ["migrationpolicies"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["authentication.k8s.io"]
		resources: ["tokenreviews"]
		verbs: ["create"]
	}, {
		apiGroups: ["authorization.k8s.io"]
		resources: ["subjectaccessreviews"]
		verbs: ["create"]
	}]
}]
