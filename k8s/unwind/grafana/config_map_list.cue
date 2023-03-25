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
		"datasources.yaml": yaml.Marshal({})
		// "datasources.yaml": yaml.Marshal({
		//  apiVersion: 1
		//  datasources: [{
		//   access: "proxy"
		//   name:   "Loki"
		//   type:   "loki"
		//   url:    "http://loki.loki.svc:3100"
		//  }, {
		//   access: "proxy"
		//   name:   "Thanos"
		//   type:   "prometheus"
		//   url:    "http://query-frontend.thanos.svc"
		//  }, {
		//   access: "proxy"
		//   name:   "Prometheus"
		//   type:   "prometheus"
		//   url:    "http://prometheus-operated.prometheus.svc:9090"
		//  }]
		// })
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
