package cert_manager

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
		name: "cert-manager-cainjector"
		labels: {
			app:                           "cainjector"
			"app.kubernetes.io/name":      "cainjector"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "cainjector"
		}
	}
	rules: [{
		apiGroups: ["cert-manager.io"]
		resources: ["certificates"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["secrets"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["get", "create", "update", "patch"]
	}, {
		apiGroups: ["admissionregistration.k8s.io"]
		resources: ["validatingwebhookconfigurations", "mutatingwebhookconfigurations"]
		verbs: ["get", "list", "watch", "update"]
	}, {
		apiGroups: ["apiregistration.k8s.io"]
		resources: ["apiservices"]
		verbs: ["get", "list", "watch", "update"]
	}, {
		apiGroups: ["apiextensions.k8s.io"]
		resources: ["customresourcedefinitions"]
		verbs: ["get", "list", "watch", "update"]
	}]
}, {
	metadata: {
		name: "cert-manager-controller-issuers"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "controller"
		}
	}
	rules: [{
		apiGroups: ["cert-manager.io"]
		resources: ["issuers", "issuers/status"]
		verbs: ["update", "patch"]
	}, {
		apiGroups: ["cert-manager.io"]
		resources: ["issuers"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["secrets"]
		verbs: ["get", "list", "watch", "create", "update", "delete"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["create", "patch"]
	}]
}, {
	metadata: {
		name: "cert-manager-controller-clusterissuers"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "controller"
		}
	}
	rules: [{
		apiGroups: ["cert-manager.io"]
		resources: ["clusterissuers", "clusterissuers/status"]
		verbs: ["update", "patch"]
	}, {
		apiGroups: ["cert-manager.io"]
		resources: ["clusterissuers"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["secrets"]
		verbs: ["get", "list", "watch", "create", "update", "delete"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["create", "patch"]
	}]
}, {
	metadata: {
		name: "cert-manager-controller-certificates"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "controller"
		}
	}
	rules: [{
		apiGroups: ["cert-manager.io"]
		resources: ["certificates", "certificates/status", "certificaterequests", "certificaterequests/status"]
		verbs: ["update", "patch"]
	}, {
		apiGroups: ["cert-manager.io"]
		resources: ["certificates", "certificaterequests", "clusterissuers", "issuers"]
		verbs: ["get", "list", "watch"]
	}, {
		// We require these rules to support users with the OwnerReferencesPermissionEnforcement
		// admission controller enabled:
		// https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#ownerreferencespermissionenforcement
		apiGroups: ["cert-manager.io"]
		resources: ["certificates/finalizers", "certificaterequests/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["acme.cert-manager.io"]
		resources: ["orders"]
		verbs: ["create", "delete", "get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["secrets"]
		verbs: ["get", "list", "watch", "create", "update", "delete", "patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["create", "patch"]
	}]
}, {
	metadata: {
		name: "cert-manager-controller-orders"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "controller"
		}
	}
	rules: [{
		apiGroups: ["acme.cert-manager.io"]
		resources: ["orders", "orders/status"]
		verbs: ["update", "patch"]
	}, {
		apiGroups: ["acme.cert-manager.io"]
		resources: ["orders", "challenges"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["cert-manager.io"]
		resources: ["clusterissuers", "issuers"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["acme.cert-manager.io"]
		resources: ["challenges"]
		verbs: ["create", "delete"]
	}, {
		// We require these rules to support users with the OwnerReferencesPermissionEnforcement
		// admission controller enabled:
		// https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#ownerreferencespermissionenforcement
		apiGroups: ["acme.cert-manager.io"]
		resources: ["orders/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["secrets"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["create", "patch"]
	}]
}, {
	metadata: {
		name: "cert-manager-controller-challenges"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "controller"
		}
	}
	rules: [{
		// Use to update challenge resource status
		apiGroups: ["acme.cert-manager.io"]
		resources: ["challenges", "challenges/status"]
		verbs: ["update", "patch"]
	}, {
		// Used to watch challenge resources
		apiGroups: ["acme.cert-manager.io"]
		resources: ["challenges"]
		verbs: ["get", "list", "watch"]
	}, {
		// Used to watch challenges, issuer and clusterissuer resources
		apiGroups: ["cert-manager.io"]
		resources: ["issuers", "clusterissuers"]
		verbs: ["get", "list", "watch"]
	}, {
		// Need to be able to retrieve ACME account private key to complete challenges
		apiGroups: [v1.#GroupName]
		resources: ["secrets"]
		verbs: ["get", "list", "watch"]
	}, {
		// Used to create events
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["create", "patch"]
	}, {
		// HTTP01 rules
		apiGroups: [v1.#GroupName]
		resources: ["pods", "services"]
		verbs: ["get", "list", "watch", "create", "delete"]
	}, {
		apiGroups: ["networking.k8s.io"]
		resources: ["ingresses"]
		verbs: ["get", "list", "watch", "create", "delete", "update"]
	}, {
		apiGroups: ["gateway.networking.k8s.io"]
		resources: ["httproutes"]
		verbs: ["get", "list", "watch", "create", "delete", "update"]
	}, {
		// We require the ability to specify a custom hostname when we are creating
		// new ingress resources.
		// See: https://github.com/openshift/origin/blob/21f191775636f9acadb44fa42beeb4f75b255532/pkg/route/apiserver/admission/ingress_admission.go#L84-L148
		apiGroups: ["route.openshift.io"]
		resources: ["routes/custom-host"]
		verbs: ["create"]
	}, {
		// We require these rules to support users with the OwnerReferencesPermissionEnforcement
		// admission controller enabled:
		// https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#ownerreferencespermissionenforcement
		apiGroups: ["acme.cert-manager.io"]
		resources: ["challenges/finalizers"]
		verbs: ["update"]
	}, {
		// DNS01 rules (duplicated above)
		apiGroups: [v1.#GroupName]
		resources: ["secrets"]
		verbs: ["get", "list", "watch"]
	}]
}, {
	metadata: {
		name: "cert-manager-controller-ingress-shim"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "controller"
		}
	}
	rules: [{
		apiGroups: ["cert-manager.io"]
		resources: ["certificates", "certificaterequests"]
		verbs: ["create", "update", "delete"]
	}, {
		apiGroups: ["cert-manager.io"]
		resources: ["certificates", "certificaterequests", "issuers", "clusterissuers"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["networking.k8s.io"]
		resources: ["ingresses"]
		verbs: ["get", "list", "watch"]
	}, {
		// We require these rules to support users with the OwnerReferencesPermissionEnforcement
		// admission controller enabled:
		// https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#ownerreferencespermissionenforcement
		apiGroups: ["networking.k8s.io"]
		resources: ["ingresses/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["gateway.networking.k8s.io"]
		resources: ["gateways", "httproutes"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["gateway.networking.k8s.io"]
		resources: ["gateways/finalizers", "httproutes/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["create", "patch"]
	}]
}, {
	metadata: {
		name: "cert-manager-view"
		labels: {
			app:                                            "cert-manager"
			"app.kubernetes.io/name":                       "cert-manager"
			"app.kubernetes.io/instance":                   "cert-manager"
			"app.kubernetes.io/component":                  "controller"
			"app.kubernetes.io/version":                    "v1.11.0"
			"rbac.authorization.k8s.io/aggregate-to-view":  "true"
			"rbac.authorization.k8s.io/aggregate-to-edit":  "true"
			"rbac.authorization.k8s.io/aggregate-to-admin": "true"
		}
	}
	rules: [{
		apiGroups: ["cert-manager.io"]
		resources: ["certificates", "certificaterequests", "issuers"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["acme.cert-manager.io"]
		resources: ["challenges", "orders"]
		verbs: ["get", "list", "watch"]
	}]
}, {
	metadata: {
		name: "cert-manager-edit"
		labels: {
			app:                                            "cert-manager"
			"app.kubernetes.io/name":                       "cert-manager"
			"app.kubernetes.io/instance":                   "cert-manager"
			"app.kubernetes.io/component":                  "controller"
			"app.kubernetes.io/version":                    "v1.11.0"
			"rbac.authorization.k8s.io/aggregate-to-edit":  "true"
			"rbac.authorization.k8s.io/aggregate-to-admin": "true"
		}
	}
	rules: [{
		apiGroups: ["cert-manager.io"]
		resources: ["certificates", "certificaterequests", "issuers"]
		verbs: ["create", "delete", "deletecollection", "patch", "update"]
	}, {
		apiGroups: ["cert-manager.io"]
		resources: ["certificates/status"]
		verbs: ["update"]
	}, {
		apiGroups: ["acme.cert-manager.io"]
		resources: ["challenges", "orders"]
		verbs: ["create", "delete", "deletecollection", "patch", "update"]
	}]
}, {
	metadata: {
		name: "cert-manager-controller-approve:cert-manager-io"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "cert-manager"
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
			"app.kubernetes.io/name":      "cert-manager"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "cert-manager"
		}
	}
	rules: [{
		apiGroups: ["certificates.k8s.io"]
		resources: ["certificatesigningrequests"]
		verbs: ["get", "list", "watch", "update"]
	}, {
		apiGroups: ["certificates.k8s.io"]
		resources: ["certificatesigningrequests/status"]
		verbs: ["update", "patch"]
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
			"app.kubernetes.io/name":      "webhook"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "webhook"
		}
	}
	rules: [{
		apiGroups: ["authorization.k8s.io"]
		resources: ["subjectaccessreviews"]
		verbs: ["create"]
	}]
}]
