package grafana

import (
	"encoding/yaml"

	"k8s.io/api/core/v1"
)

config_map: [...v1.#ConfigMap]

config_map: [{
	apiVersion: "v1"
	kind:       "ConfigMap"
	metadata: {
		name: "grafana"
		labels: {
			"app.kubernetes.io/name":      "grafana"
			"app.kubernetes.io/instance":  "grafana"
			"app.kubernetes.io/version":   "7.4.2"
			"app.kubernetes.io/component": "grafana"
		}
	}
	data: {
		"datasources.yaml": yaml.Marshal({
			apiVersion: 1
			datasources: [{
				access: "proxy"
				name:   "Loki"
				type:   "loki"
				url:    "http://loki.loki.svc:3100"
			}, {
				access: "proxy"
				name:   "Thanos"
				type:   "prometheus"
				url:    "http://query-frontend.thanos.svc"
			}]
		})
		"grafana.ini": """
				[auth.anonymous]
				enabled = true
				org_role = Admin

				[database]
				type = postgres
				ssl_mode = require

				[security]
				cookie_secure = true
				cookie_samesite = strict 
				
				[log]
				mode = console
			"""
	}
}]
