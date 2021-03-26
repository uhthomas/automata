package kipp

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
			name:       "kipp"
		}
		minReplicas:                    2
		maxReplicas:                    4
		targetCPUUtilizationPercentage: 75
	}
}]
