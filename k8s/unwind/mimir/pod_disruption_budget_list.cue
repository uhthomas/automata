package mimir

import policyv1 "k8s.io/api/policy/v1"

#PodDisruptionBudgetList: policyv1.#PodDisruptionBudgetList & {
	apiVersion: "policy/v1"
	kind:       "PodDisruptionBudgetList"
	items: [...{
		apiVersion: "policy/v1"
		kind:       "PodDisruptionBudget"
	}]
}

#PodDisruptionBudgetList: items: [{
	metadata: {
		name: "mimir-ingester"
		labels: "app.kubernetes.io/component": "ingester"
	}
	spec: {
		selector: matchLabels: {
			"app.kubernetes.io/name":      "mimir"
			"app.kubernetes.io/instance":  "mimir"
			"app.kubernetes.io/component": "ingester"
		}
		maxUnavailable: 1
	}
}, {
	metadata: {
		name: "mimir-store-gateway"
		labels: "app.kubernetes.io/component": "store-gateway"
	}
	spec: {
		selector: matchLabels: {
			"app.kubernetes.io/name":      "mimir"
			"app.kubernetes.io/instance":  "mimir"
			"app.kubernetes.io/component": "store-gateway"
		}
		maxUnavailable: 1
	}
}]
