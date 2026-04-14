package kaniop

import operatorv1beta1 "github.com/VictoriaMetrics/operator/api/operator/v1beta1"

#VMRuleList: operatorv1beta1.#VMRuleList & {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMRuleList"
	items: [...{
		apiVersion: "operator.victoriametrics.com/v1beta1"
		kind:       "VMRule"
	}]
}

#VMRuleList: items: [{
	spec: groups: [{
		name: "kaniop-operator.rules"
		rules: [{
			alert: "KaniopControllerNotReady"
			annotations: {
				description: "Controller {{$labels.controller}} is not ready (kaniop_ready=0)."
				summary:     "Kaniop controller is not ready"
			}
			expr:  "kaniop_ready == 0"
			"for": "2m"
			labels: severity: "critical"
		}, {
			alert: "KaniopReconcileFailures"
			annotations: {
				description: "{{$labels.controller}} had reconcile failures in the last 5 minutes."
				summary:     "Kaniop reconcile failures detected"
			}
			expr:  "increase(kaniop_reconcile_failures_total[5m]) > 0"
			"for": "1m"
			labels: severity: "warning"
		}, {
			alert: "KaniopStatusUpdateErrors"
			annotations: {
				description: "{{$labels.controller}} had status update errors in the last 5 minutes."
				summary:     "Kaniop status update errors"
			}
			expr:  "increase(kaniop_status_update_errors_total[5m]) > 0"
			"for": "1m"
			labels: severity: "warning"
		}, {
			alert: "KaniopReconcileDurationHigh"
			annotations: {
				description: "p99 reconcile duration for {{$labels.controller}} is over 2s."
				summary:     "Kaniop reconcile duration high"
			}
			expr:  "histogram_quantile(0.99, sum by(controller, le) (rate(kaniop_reconcile_duration_seconds_bucket[5m]))) > 2"
			"for": "5m"
			labels: severity: "warning"
		}, {
			alert: "KaniopFrequentDeployDeleteCreate"
			annotations: {
				description: "{{$labels.controller}} deleted/recreated deployments more than twice in 10 minutes."
				summary:     "Kaniop frequent deployment delete/recreate"
			}
			expr:  "increase(kaniop_reconcile_deploy_delete_create_total[10m]) > 2"
			"for": "2m"
			labels: severity: "warning"
		}, {
			alert: "KaniopK8sApiErrors"
			annotations: {
				description: "4|5xx API responses detected in the last 5 minutes."
				summary:     "Kaniop Kubernetes API errors"
			}
			expr:  #"sum by(status) (increase(kaniop_kubernetes_client_http_requests_total{status=~"[4-5].."}[5m])) > 0"#
			"for": "2m"
			labels: severity: "warning"
		}]
	}]
}]
