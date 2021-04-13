package rasmus

import autoscalingv2beta2 "k8s.io/api/autoscaling/v2beta2"

horizontalPodAutoscalerList: autoscalingv2beta2.#HorizontalPodAutoscalerList & {
	apiVersion: "autoscaling/v2beta2"
	kind:       "HorizontalPodAutoscalerList"
	items: [...{
		apiVersion: "autoscaling/v2beta2"
		kind:       "HorizontalPodAutoscaler"
	}]
}

horizontalPodAutoscalerList: items: [{
	spec: {
		scaleTargetRef: {
			apiVersion: "apps/v1"
			kind:       "Deployment"
			name:       "rasmus"
		}
		minReplicas: 3
		maxReplicas: 5
		metrics: [{
			type: autoscalingv2beta2.#ResourceMetricSourceType
			resource: {
				name: "cpu"
				target: {
					type:               autoscalingv2beta2.#UtilizationMetricType
					averageUtilization: 80
				}
			}
		}, {
			type: autoscalingv2beta2.#ResourceMetricSourceType
			resource: {
				name: "memory"
				target: {
					type:               autoscalingv2beta2.#UtilizationMetricType
					averageUtilization: 80
				}
			}
		}]
	}
}]
