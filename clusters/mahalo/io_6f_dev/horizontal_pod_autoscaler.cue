package io_6f_dev

import autoscalingv1 "k8s.io/api/autoscaling/v1"

horizontal_pod_autoscaler: [...autoscalingv1.#HorizontalPodAutoscaler]

horizontal_pod_autoscaler: [{
	apiVersion: "autoscaling/v1"
	kind:       "HorizontalPodAutoscaler"
	metadata: name: "io-6f"
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
