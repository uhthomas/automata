package kubevirt

import schedulingv1 "k8s.io/api/scheduling/v1"

#PriorityClassList: schedulingv1.#PriorityClassList & {
	apiVersion: "scheduling.k8s.io/v1"
	kind:       "PriorityClassList"
	items: [...{
		apiVersion: "scheduling.k8s.io/v1"
		kind:       "PriorityClass"
	}]
}

#PriorityClassList: items: [{
	metadata: name: "kubevirt-cluster-critical"
	value:         1000000000
	globalDefault: false
	description:   "This priority class should be used for core kubevirt components only."
}]
