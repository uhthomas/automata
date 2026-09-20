package flux_system

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
		name: "flux.rules"
		rules: [{
			alert: "FluxResourceNotReady"
			expr:  "gotk_resource_info{exported_namespace=\"flux-system\",customresource_kind=~\"Kustomization|OCIRepository\",ready!=\"True\"} == 1"
			"for": "10m"
			labels: severity: "warning"
			annotations: {
				description: "Flux {{ $labels.customresource_kind }} {{ $labels.exported_namespace }}/{{ $labels.name }} has not been Ready for 10 minutes."
				summary:     "A Flux resource is not ready"
			}
		}, {
			alert: "FluxReconciliationFailures"
			expr:  "sum by(controller) (rate(controller_runtime_reconcile_total{namespace=\"flux-system\",controller=~\"kustomization|ocirepository\",result=\"error\"}[5m])) > 0"
			"for": "15m"
			labels: severity: "warning"
			annotations: {
				description: "Flux controller {{ $labels.controller }} has continuously reported reconciliation errors for 15 minutes."
				summary:     "Flux reconciliation is repeatedly failing"
			}
		}]
	}]
}]
