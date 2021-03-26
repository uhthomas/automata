package io_6f_dev

import autoscalingv1 "k8s.io/api/autoscaling/v1"

horizontalPodAutoscalerList: autoscalingv1.#HorizontalPodAutoscalerList & {
	apiVersion: "autoscaling/v1"
	kind:       "HorizontalPodAutoscalerList"
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
		minReplicas:                    1
		maxReplicas:                    3
		targetCPUUtilizationPercentage: 75
	}
}]
