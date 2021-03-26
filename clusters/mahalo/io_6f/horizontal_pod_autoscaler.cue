package io_6f

import autoscalingv1 "k8s.io/api/autoscaling/v1"

horizontalPodAutoscalerList: autoscalingv1.#HorizontalPodAutoscalerList & {
	apiVersion: "v1"
	kind:       "List"
}

horizontalPodAutoscalerList: items: [{
	apiVersion: "autoscaling/v1"
	kind:       "HorizontalPodAutoscaler"
	spec: {
		scaleTargetRef: {
			apiVersion: "apps/v1"
			kind:       "Deployment"
			name:       "io-6f"
		}
		minReplicas:                    2
		maxReplicas:                    4
		targetCPUUtilizationPercentage: 75
	}
}]
