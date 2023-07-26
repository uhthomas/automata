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
				url:       "http://vmselect-vm.vm.svc:8481/select/0/prometheus"
				isDefault: true
			}, {
				name:   "Alertmanager"
				type:   "alertmanager"
				access: "proxy"
				url:    "http://vmalertmanager-vm.vm.svc:9093"
			}, {
				name:   "Loki"
				type:   "loki"
				access: "proxy"
				url:    "http://loki-gateway.loki.svc"
			}, {
				name:      "VictoriaMetrics 4697"
				type:      "prometheus"
				access:    "proxy"
				url:       "http://vmselect-vm4697.vm4697.svc:8481/select/0/prometheus"
				isDefault: true
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
			"""
	}
}]
