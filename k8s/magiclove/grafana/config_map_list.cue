package grafana

import (
	"encoding/yaml"

	"k8s.io/api/core/v1"
)

#ConfigMapList: v1.#ConfigMapList & {
	apiVersion: "v1"
	kind:       "ConfigMapList"
	items: [...{
		apiVersion: "v1"
		kind:       "ConfigMap"
	}]
}

#ConfigMapList: items: [{
	data: {
		"datasources.yaml": yaml.Marshal({
			apiVersion: 1
			datasources: [{
				name:      "VictoriaMetrics"
				type:      "prometheus"
				access:    "proxy"
				url:       "http://vmsingle-vm.vm:8429"
				isDefault: true
			}, {
				name:                       "Alertmanager"
				type:                       "alertmanager"
				access:                     "proxy"
				url:                        "http://vmalertmanager-vm.vm:9093"
				implementation:             "prometheus"
				handleGrafanaManagedAlerts: true
			}, {
				name:   "VictoriaLogs"
				type:   "victoriametrics-logs-datasource"
				access: "proxy"
				url:    "http://victoria-logs.victoria-logs"
			}, {
				name:   "VictoriaMetrics (ds)"
				type:   "victoriametrics-metrics-datasource"
				access: "proxy"
				url:    "http://vmsingle-vm.vm:8429"
			}]
		})
		"grafana.ini": """
			[analytics]
			check_for_updates = true

			[grafana_net]
			url = https://grafana.net

			[log]
			mode = console

			[paths]
			data = /var/lib/grafana/
			logs = /var/log/grafana
			plugins = /var/lib/grafana/plugins
			provisioning = /etc/grafana/provisioning

			[database]
			path = /var/lib/grafana/database/grafana.db

			[auth.anonymous]
			enabled = true
			org_role = Admin

			[log]
			mode = console

			[plugins]
			preinstall = victoriametrics-logs-datasource,victoriametrics-metrics-datasource
			"""
	}
}]
