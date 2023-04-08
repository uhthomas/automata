package cockroach_operator_system

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
	metadata: name: "cockroach-operator-role"
	rules: [{
		apiGroups: ["admissionregistration.k8s.io"]
		resources: ["mutatingwebhookconfigurations"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["admissionregistration.k8s.io"]
		resources: ["validatingwebhookconfigurations"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["apps"]
		resources: ["statefulsets"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["apps"]
		resources: ["statefulsets/finalizers"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["apps"]
		resources: ["statefulsets/scale"]
		verbs: ["get", "update", "watch"]
	}, {
		apiGroups: ["apps"]
		resources: ["statefulsets/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["batch"]
		resources: ["jobs"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["batch"]
		resources: ["jobs/finalizers"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["batch"]
		resources: ["jobs/status"]
		verbs: ["get"]
	}, {
		apiGroups: ["certificates.k8s.io"]
		resources: ["certificatesigningrequests"]
		verbs: ["create", "delete", "get", "list", "patch", "watch"]
	}, {
		apiGroups: ["certificates.k8s.io"]
		resources: ["certificatesigningrequests/approval"]
		verbs: ["update"]
	}, {
		apiGroups: ["certificates.k8s.io"]
		resources: ["certificatesigningrequests/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: [""]
		resources: ["configmaps"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [""]
		resources: ["configmaps/status"]
		verbs: ["get"]
	}, {
		apiGroups: [""]
		resources: ["nodes"]
		verbs: ["get", "list"]
	}, {
		apiGroups: [""]
		resources: ["persistentvolumeclaims"]
		verbs: ["list", "update"]
	}, {
		apiGroups: [""]
		resources: ["pods"]
		verbs: ["delete", "deletecollection", "get", "list"]
	}, {
		apiGroups: [""]
		resources: ["pods/exec"]
		verbs: ["create"]
	}, {
		apiGroups: [""]
		resources: ["pods/log"]
		verbs: ["get"]
	}, {
		apiGroups: [""]
		resources: ["secrets"]
		verbs: ["create", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: [""]
		resources: ["serviceaccounts"]
		verbs: ["create", "get", "list", "watch"]
	}, {
		apiGroups: [""]
		resources: ["services"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: [""]
		resources: ["services/finalizers"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [""]
		resources: ["services/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["crdb.cockroachlabs.com"]
		resources: ["crdbclusters"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["crdb.cockroachlabs.com"]
		resources: ["crdbclusters/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["crdb.cockroachlabs.com"]
		resources: ["crdbclusters/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["networking.k8s.io"]
		resources: ["ingresses"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["networking.k8s.io"]
		resources: ["ingresses/finalizers"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["networking.k8s.io"]
		resources: ["ingresses/status"]
		verbs: ["get"]
	}, {
		apiGroups: ["policy"]
		resources: ["poddisruptionbudgets"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["policy"]
		resources: ["poddisruptionbudgets/finalizers"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["policy"]
		resources: ["poddisruptionbudgets/status"]
		verbs: ["get"]
	}, {
		apiGroups: ["rbac.authorization.k8s.io"]
		resources: ["rolebindings"]
		verbs: ["create", "get", "list", "watch"]
	}, {
		apiGroups: ["rbac.authorization.k8s.io"]
		resources: ["roles"]
		verbs: ["create", "get", "list", "watch"]
	}, {
		apiGroups: ["security.openshift.io"]
		resources: ["securitycontextconstraints"]
		verbs: ["use"]
	}]
}]
