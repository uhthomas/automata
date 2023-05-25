package read

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
	spec: {
		selector: matchLabels: {
			"app.kubernetes.io/name":      "loki"
			"app.kubernetes.io/component": #Component
		}
		maxUnavailable: 1
	}
}]
