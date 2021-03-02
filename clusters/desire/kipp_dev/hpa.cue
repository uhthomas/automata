package kipp_dev

import autoscalingv1 "k8s.io/api/autoscaling/v1"

hpa: autoscalingv1.#HorizontalPodAutoscaler & {
	apiVersion: "autoscaling/v1"
	kind:       "HorizontalPodAutoscaler"
	metadata: {
		name:      "kipp"
		namespace: "kipp-dev"
	}
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
}
