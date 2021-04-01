package ingress_nginx

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
	metadata: {
		name: "ingress-nginx-controller"
		labels: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/version":   "0.44.0"
			"app.kubernetes.io/component": "controller"
		}
	}
	spec: {
		scaleTargetRef: {
			apiVersion: "apps/v1"
			kind:       "Deployment"
			name:       "ingress-nginx"
		}
		minReplicas: 3
		maxReplicas: 5
		metrics: [{
			type: autoscalingv2beta2.#ResourceMetricSourceType
			resource: {
				name: "cpu"
				target: {
					type:               autoscalingv2beta2.#UtilizationMetricType
					averageUtilization: 75
				}
			}
		}, {
			type: autoscalingv2beta2.#ResourceMetricSourceType
			resource: {
				name: "memory"
				target: {
					type:               autoscalingv2beta2.#UtilizationMetricType
					averageUtilization: 75
				}
			}
		}]
	}
}]
