package kipp_dev

import autoscalingv1 "k8s.io/api/autoscaling/v1"

horizontal_pod_autoscaler: [...autoscalingv1.#HorizontalPodAutoscaler]

horizontal_pod_autoscaler: [{
	apiVersion: "autoscaling/v1"
	kind:       "HorizontalPodAutoscaler"
	spec: {
		scaleTargetRef: {
			apiVersion: "apps/v1"
			kind:       "Deployment"
			name:       "kipp"
		}
		minReplicas:                    1
		maxReplicas:                    2
		targetCPUUtilizationPercentage: 75
	}
}]
