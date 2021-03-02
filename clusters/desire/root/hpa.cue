package root

import autoscalingv1 "k8s.io/api/autoscaling/v1"

hpa: autoscalingv1.#HorizontalPodAutoscaler & {
	apiVersion: "autoscaling/v1"
	kind:       "HorizontalPodAutoscaler"
	metadata: name: "root"
	spec: {
		scaleTargetRef: {
			apiVersion: "apps/v1"
			kind:       "Deployment"
			name:       "root"
		}
		minReplicas:                    2
		maxReplicas:                    4
		targetCPUUtilizationPercentage: 75
	}
}
