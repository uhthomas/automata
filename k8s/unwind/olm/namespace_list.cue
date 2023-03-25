package olm

import "k8s.io/api/core/v1"

#NamespaceList: v1.#NamespaceList & {
	apiVersion: "v1"
	kind:       "NamespaceList"
	items: [...{
		apiVersion: "v1"
		kind:       "Namespace"
	}]
}

#NamespaceList: items: [{metadata: labels: {
	"pod-security.kubernetes.io/enforce":         "restricted"
	"pod-security.kubernetes.io/enforce-version": "latest"
	"pod-security.kubernetes.io/audit":           "restricted"
	"pod-security.kubernetes.io/audit-version":   "latest"
	"pod-security.kubernetes.io/warn":            "restricted"
	"pod-security.kubernetes.io/warn-version":    "latest"
}}]
