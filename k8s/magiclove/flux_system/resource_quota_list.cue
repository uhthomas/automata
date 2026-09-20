package flux_system

import "k8s.io/api/core/v1"

#ResourceQuotaList: v1.#ResourceQuotaList & {
	apiVersion: "v1"
	kind:       "ResourceQuotaList"
	items: [...{
		apiVersion: "v1"
		kind:       "ResourceQuota"
	}]
}

#ResourceQuotaList: items: [{
	metadata: name: "critical-pods-flux-system"
	spec: {
		hard: pods: "1000"
		scopeSelector: matchExpressions: [{
			scopeName: "PriorityClass"
			operator:  "In"
			values: ["system-node-critical", "system-cluster-critical"]
		}]
	}
}]
