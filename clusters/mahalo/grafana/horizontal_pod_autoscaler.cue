package grafana

import autoscalingv1 "k8s.io/api/autoscaling/v1"

horizontal_pod_autoscaler: [...autoscalingv1.#HorizontalPodAutoscaler]

horizontal_pod_autoscaler: [{
	apiVersion: "autoscaling/v1"
	kind:       "HorizontalPodAutoscaler"
	metadata: {
		name: "grafana"
		labels: {
			"app.kubernetes.io/name":      "grafana"
			"app.kubernetes.io/instance":  "grafana"
			"app.kubernetes.io/version":   "7.4.2"
			"app.kubernetes.io/component": "grafana"
		}
	}
	spec: {
		scaleTargetRef: {
			apiVersion: "apps/v1"
			kind:       "Deployment"
			name:       "grafana"
		}
		minReplicas:                    2
		maxReplicas:                    4
		targetCPUUtilizationPercentage: 75
	}
}]
