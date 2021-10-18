package cert_manager

import rbacv1 "k8s.io/api/rbac/v1"

clusterRoleList: rbacv1.#ClusterRoleList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRole"
	}]
}

clusterRoleList: items: [{
	metadata: {
		name: "cert-manager-cainjector"
		labels: {
			app:                           "cainjector"
			"app.kubernetes.io/name":      "cainjector"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "cainjector"
		}
	}
	rules: [{
		apiGroups: [
			"cert-manager.io",
		]
		resources: [
			"certificates",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [""]
		resources: [
			"secrets",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [""]
		resources: ["events"]
		verbs: [
			"get",
			"create",
			"update",
			"patch",
		]
	}, {
		apiGroups: [
			"admissionregistration.k8s.io",
		]
		resources: [
			"validatingwebhookconfigurations",
			"mutatingwebhookconfigurations",
		]
		verbs: [
			"get",
			"list",
			"watch",
			"update",
		]
	}, {
		apiGroups: [
			"apiregistration.k8s.io",
		]
		resources: [
			"apiservices",
		]
		verbs: [
			"get",
			"list",
			"watch",
			"update",
		]
	}, {
		apiGroups: [
			"apiextensions.k8s.io",
		]
		resources: [
			"customresourcedefinitions",
		]
		verbs: [
			"get",
			"list",
			"watch",
			"update",
		]
	}, {
		apiGroups: [
			"auditregistration.k8s.io",
		]
		resources: [
			"auditsinks",
		]
		verbs: [
			"get",
			"list",
			"watch",
			"update",
		]
	}]
}, {
	metadata: {
		name: "cert-manager-controller-issuers"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/component": "controller"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
		}
	}
	rules: [{
		apiGroups: [
			"cert-manager.io",
		]
		resources: [
			"issuers",
			"issuers/status",
		]
		verbs: ["update"]
	}, {
		apiGroups: [
			"cert-manager.io",
		]
		resources: [
			"issuers",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [""]
		resources: [
			"secrets",
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
		apiGroups: [""]
		resources: ["events"]
		verbs: [
			"create",
			"patch",
		]
	}]
}, {
	metadata: {
		name: "cert-manager-controller-clusterissuers"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/component": "controller"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
		}
	}
	rules: [{
		apiGroups: [
			"cert-manager.io",
		]
		resources: [
			"clusterissuers",
			"clusterissuers/status",
		]
		verbs: ["update"]
	}, {
		apiGroups: [
			"cert-manager.io",
		]
		resources: [
			"clusterissuers",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [""]
		resources: [
			"secrets",
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
		apiGroups: [""]
		resources: ["events"]
		verbs: [
			"create",
			"patch",
		]
	}]
}, {
	metadata: {
		name: "cert-manager-controller-certificates"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/component": "controller"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
		}
	}
	rules: [{
		apiGroups: [
			"cert-manager.io",
		]
		resources: [
			"certificates",
			"certificates/status",
			"certificaterequests",
			"certificaterequests/status",
		]
		verbs: ["update"]
	}, {
		apiGroups: [
			"cert-manager.io",
		]
		resources: [
			"certificates",
			"certificaterequests",
			"clusterissuers",
			"issuers",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"cert-manager.io",
		]
		resources: [
			"certificates/finalizers",
			"certificaterequests/finalizers",
		]
		verbs: ["update"]
	}, {
		apiGroups: [
			"acme.cert-manager.io",
		]
		resources: ["orders"]
		verbs: [
			"create",
			"delete",
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [""]
		resources: [
			"secrets",
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
		apiGroups: [""]
		resources: ["events"]
		verbs: [
			"create",
			"patch",
		]
	}]
}, {
	metadata: {
		name: "cert-manager-controller-orders"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/component": "controller"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
		}
	}
	rules: [{
		apiGroups: [
			"acme.cert-manager.io",
		]
		resources: [
			"orders",
			"orders/status",
		]
		verbs: ["update"]
	}, {
		apiGroups: [
			"acme.cert-manager.io",
		]
		resources: [
			"orders",
			"challenges",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"cert-manager.io",
		]
		resources: [
			"clusterissuers",
			"issuers",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"acme.cert-manager.io",
		]
		resources: [
			"challenges",
		]
		verbs: [
			"create",
			"delete",
		]
	}, {
		apiGroups: [
			"acme.cert-manager.io",
		]
		resources: [
			"orders/finalizers",
		]
		verbs: ["update"]
	}, {
		apiGroups: [""]
		resources: [
			"secrets",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [""]
		resources: ["events"]
		verbs: [
			"create",
			"patch",
		]
	}]
}, {
	metadata: {
		name: "cert-manager-controller-challenges"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/component": "controller"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
		}
	}
	rules: [{
		apiGroups: [
			"acme.cert-manager.io",
		]
		resources: [
			"challenges",
			"challenges/status",
		]
		verbs: ["update"]
	}, {
		apiGroups: [
			"acme.cert-manager.io",
		]
		resources: [
			"challenges",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"cert-manager.io",
		]
		resources: [
			"issuers",
			"clusterissuers",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [""]
		resources: [
			"secrets",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [""]
		resources: ["events"]
		verbs: [
			"create",
			"patch",
		]
	}, {
		apiGroups: [""]
		resources: [
			"pods",
			"services",
		]
		verbs: [
			"get",
			"list",
			"watch",
			"create",
			"delete",
		]
	}, {
		apiGroups: [
			"networking.k8s.io",
		]
		resources: [
			"ingresses",
		]
		verbs: [
			"get",
			"list",
			"watch",
			"create",
			"delete",
			"update",
		]
	}, {
		apiGroups: [
			"route.openshift.io",
		]
		resources: [
			"routes/custom-host",
		]
		verbs: ["create"]
	}, {
		apiGroups: [
			"acme.cert-manager.io",
		]
		resources: [
			"challenges/finalizers",
		]
		verbs: ["update"]
	}, {
		apiGroups: [""]
		resources: [
			"secrets",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}]
}, {
	metadata: {
		name: "cert-manager-controller-ingress-shim"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/component": "controller"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
		}
	}
	rules: [{
		apiGroups: [
			"cert-manager.io",
		]
		resources: [
			"certificates",
			"certificaterequests",
		]
		verbs: [
			"create",
			"update",
			"delete",
		]
	}, {
		apiGroups: [
			"cert-manager.io",
		]
		resources: [
			"certificates",
			"certificaterequests",
			"issuers",
			"clusterissuers",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"networking.k8s.io",
		]
		resources: [
			"ingresses",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"networking.k8s.io",
		]
		resources: [
			"ingresses/finalizers",
		]
		verbs: ["update"]
	}, {
		apiGroups: [""]
		resources: ["events"]
		verbs: [
			"create",
			"patch",
		]
	}]
}, {
	metadata: {
		name: "cert-manager-view"
		labels: {
			app:                                            "cert-manager"
			"app.kubernetes.io/component":                  "controller"
			"app.kubernetes.io/instance":                   "cert-manager"
			"app.kubernetes.io/name":                       "cert-manager"
			"rbac.authorization.k8s.io/aggregate-to-admin": "true"
			"rbac.authorization.k8s.io/aggregate-to-edit":  "true"
			"rbac.authorization.k8s.io/aggregate-to-view":  "true"
		}
	}
	rules: [{
		apiGroups: [
			"cert-manager.io",
		]
		resources: [
			"certificates",
			"certificaterequests",
			"issuers",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"acme.cert-manager.io",
		]
		resources: [
			"challenges",
			"orders",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}]
}, {
	metadata: {
		name: "cert-manager-edit"
		labels: {
			app:                                            "cert-manager"
			"app.kubernetes.io/component":                  "controller"
			"app.kubernetes.io/instance":                   "cert-manager"
			"app.kubernetes.io/name":                       "cert-manager"
			"rbac.authorization.k8s.io/aggregate-to-admin": "true"
			"rbac.authorization.k8s.io/aggregate-to-edit":  "true"
		}
	}
	rules: [{
		apiGroups: [
			"cert-manager.io",
		]
		resources: [
			"certificates",
			"certificaterequests",
			"issuers",
		]
		verbs: [
			"create",
			"delete",
			"deletecollection",
			"patch",
			"update",
		]
	}, {
		apiGroups: [
			"acme.cert-manager.io",
		]
		resources: [
			"challenges",
			"orders",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}]
}, {
	metadata: {
		name: "cert-manager-controller-approve:cert-manager-io"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/component": "cert-manager"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
		}
	}
	rules: [{
		apiGroups: ["cert-manager.io"]
		resources: ["signers"]
		verbs: ["approve"]
		resourceNames: ["issuers.cert-manager.io/*", "clusterissuers.cert-manager.io/*"]
	}]
}, {
	metadata: {
		name: "cert-manager-controller-certificatesigningrequests"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/component": "cert-manager"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
		}
	}
	rules: [{
		apiGroups: ["certificates.k8s.io"]
		resources: ["certificatesigningrequests"]
		verbs: ["get", "list", "watch", "update"]
	}, {
		apiGroups: ["certificates.k8s.io"]
		resources: ["certificatesigningrequests/status"]
		verbs: ["update"]
	}, {
		apiGroups: ["certificates.k8s.io"]
		resources: ["signers"]
		resourceNames: ["issuers.cert-manager.io/*", "clusterissuers.cert-manager.io/*"]
		verbs: ["sign"]
	}, {
		apiGroups: ["authorization.k8s.io"]
		resources: ["subjectaccessreviews"]
		verbs: ["create"]
	}]
}, {
	metadata: {
		name: "cert-manager-webhook:subjectaccessreviews"
		labels: {
			app:                           "webhook"
			"app.kubernetes.io/component": "webhook"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "webhook"
		}
	}
	rules: [{
		apiGroups: ["authorization.k8s.io"]
		resources: ["subjectaccessreviews"]
		verbs: ["create"]
	}]
}]
