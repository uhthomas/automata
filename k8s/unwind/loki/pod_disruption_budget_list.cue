package loki

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
		name: "loki-read"
		labels: "app.kubernetes.io/component": "read"
	}
	spec: {
		selector: matchLabels: {
			"app.kubernetes.io/name":      "loki"
			"app.kubernetes.io/instance":  "loki"
			"app.kubernetes.io/component": "read"
		}
		maxUnavailable: 1
	}
}, {
	metadata: {
		name: "loki-write"
		labels: "app.kubernetes.io/component": "write"
	}
	spec: {
		selector: matchLabels: {
			"app.kubernetes.io/name":      "loki"
			"app.kubernetes.io/instance":  "loki"
			"app.kubernetes.io/component": "write"
		}
		maxUnavailable: 1
	}
}]
