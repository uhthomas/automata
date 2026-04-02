package grafana

import grafanav1beta1 "github.com/grafana/grafana-operator/v5/api/v1beta1"

#GrafanaDatasourceList: grafanav1beta1.#GrafanaDatasourceList & {
	apiVersion: "grafana.integreatly.org/v1beta1"
	kind:       "GrafanaDatasourceList"
	items: [...{
		apiVersion: "grafana.integreatly.org/v1beta1"
		kind:       "GrafanaDatasource"
	}]
}

#GrafanaDatasourceList: items: [{
	metadata: name: "\(#Name)-victoriametrics"
	spec: {
		datasource: {
			name:      "VictoriaMetrics"
			type:      "prometheus"
			access:    "proxy"
			url:       "http://vmsingle-vm.vm:8429"
			isDefault: true
		}
		instanceSelector: matchLabels: "app.kubernetes.io/name": #Name
	}
}, {
	metadata: name: "\(#Name)-alertmanager"
	spec: {
		datasource: {
			name:   "Alertmanager"
			type:   "alertmanager"
			access: "proxy"
			url:    "http://vmalertmanager-vm.vm:9093"
			jsonData: {
				implementation:             "prometheus"
				handleGrafanaManagedAlerts: true
			}
		}
		instanceSelector: matchLabels: "app.kubernetes.io/name": #Name
	}
}, {
	metadata: name: "\(#Name)-victorialogs"
	spec: {
		datasource: {
			name:   "VictoriaLogs"
			type:   "victoriametrics-logs-datasource"
			access: "proxy"
			url:    "http://victoria-logs.victoria-logs"
		}
		plugins: [{
			name:    "victoriametrics-logs-datasource"
			version: "v0.26.3"
		}]
		instanceSelector: matchLabels: "app.kubernetes.io/name": #Name
	}
}, {
	metadata: name: "\(#Name)-victoriametrics-ds"
	spec: {
		datasource: {
			name:   "VictoriaMetrics (ds)"
			type:   "victoriametrics-metrics-datasource"
			access: "proxy"
			url:    "http://vmsingle-vm.vm:8429"
		}
		plugins: [{
			name:    "victoriametrics-metrics-datasource"
			version: "v0.23.3"
		}]
		instanceSelector: matchLabels: "app.kubernetes.io/name": #Name
	}
}]
