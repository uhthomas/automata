package trivy_system

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
	rules: [{
		apiGroups: [""]
		resources: ["configmaps"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [""]
		resources: ["limitranges"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [""]
		resources: ["nodes"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [""]
		resources: ["pods"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [""]
		resources: ["pods/log"]
		verbs: ["get", "list"]
	}, {
		apiGroups: [""]
		resources: ["replicationcontrollers"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [""]
		resources: ["resourcequotas"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [""]
		resources: ["services"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["apiextensions.k8s.io"]
		resources: ["customresourcedefinitions"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["apps"]
		resources: ["daemonsets"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["apps"]
		resources: ["deployments"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["apps"]
		resources: ["replicasets"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["apps"]
		resources: ["statefulsets"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["apps.openshift.io"]
		resources: ["deploymentconfigs"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["aquasecurity.github.io"]
		resources: ["clustercompliancedetailreports"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["aquasecurity.github.io"]
		resources: ["clustercompliancereports"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["aquasecurity.github.io"]
		resources: ["clustercompliancereports/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["aquasecurity.github.io"]
		resources: ["clusterconfigauditreports"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["aquasecurity.github.io"]
		resources: ["clusterinfraassessmentreports"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["aquasecurity.github.io"]
		resources: ["clusterrbacassessmentreports"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["aquasecurity.github.io"]
		resources: ["clustersbomreports"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["aquasecurity.github.io"]
		resources: ["clustervulnerabilityreports"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["aquasecurity.github.io"]
		resources: ["configauditreports"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["aquasecurity.github.io"]
		resources: ["exposedsecretreports"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["aquasecurity.github.io"]
		resources: ["infraassessmentreports"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["aquasecurity.github.io"]
		resources: ["rbacassessmentreports"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["aquasecurity.github.io"]
		resources: ["sbomreports"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["aquasecurity.github.io"]
		resources: ["vulnerabilityreports"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["batch"]
		resources: ["cronjobs"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["batch"]
		resources: ["jobs"]
		verbs: ["create", "delete", "get", "list", "watch"]
	}, {
		apiGroups: ["networking.k8s.io"]
		resources: ["ingresses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["networking.k8s.io"]
		resources: ["networkpolicies"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["rbac.authorization.k8s.io"]
		resources: ["clusterrolebindings"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["rbac.authorization.k8s.io"]
		resources: ["clusterroles"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["rbac.authorization.k8s.io"]
		resources: ["rolebindings"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["rbac.authorization.k8s.io"]
		resources: ["roles"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [""]
		resources: ["secrets"]
		verbs: ["create", "get", "update"]
	}, {
		apiGroups: [""]
		resources: ["serviceaccounts"]
		verbs: ["get"]
	}, {
		apiGroups: [""]
		resources: ["nodes/proxy"]
		verbs: ["get"]
	}]
}, {
	metadata: {
		name: "aggregate-config-audit-reports-view"
		labels: {
			"rbac.authorization.k8s.io/aggregate-to-view":           "true"
			"rbac.authorization.k8s.io/aggregate-to-edit":           "true"
			"rbac.authorization.k8s.io/aggregate-to-admin":          "true"
			"rbac.authorization.k8s.io/aggregate-to-cluster-reader": "true"
		}
	}
	rules: [{
		apiGroups: ["aquasecurity.github.io"]
		resources: ["configauditreports"]
		verbs: ["get", "list", "watch"]
	}]
}, {
	metadata: {
		name: "aggregate-exposed-secret-reports-view"
		labels: {
			"rbac.authorization.k8s.io/aggregate-to-view":           "true"
			"rbac.authorization.k8s.io/aggregate-to-edit":           "true"
			"rbac.authorization.k8s.io/aggregate-to-admin":          "true"
			"rbac.authorization.k8s.io/aggregate-to-cluster-reader": "true"
		}
	}
	rules: [{
		apiGroups: ["aquasecurity.github.io"]
		resources: ["exposedsecretreports"]
		verbs: ["get", "list", "watch"]
	}]
}, {
	metadata: {
		name: "aggregate-vulnerability-reports-view"
		labels: {
			"rbac.authorization.k8s.io/aggregate-to-view":           "true"
			"rbac.authorization.k8s.io/aggregate-to-edit":           "true"
			"rbac.authorization.k8s.io/aggregate-to-admin":          "true"
			"rbac.authorization.k8s.io/aggregate-to-cluster-reader": "true"
		}
	}
	rules: [{
		apiGroups: ["aquasecurity.github.io"]
		resources: ["vulnerabilityreports"]
		verbs: ["get", "list", "watch"]
	}]
}]
