package grafana

import (
	"encoding/yaml"

	"k8s.io/api/core/v1"
)

configMapList: v1.#ConfigMapList & {
	apiVersion: "v1"
	kind:       "ConfigMapList"
	items: [...{
		apiVersion: "v1"
		kind:       "ConfigMap"
	}]
}

configMapList: items: [{
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
			}, {
				access: "proxy"
				name:   "Prometheus"
				type:   "prometheus"
				url:    "http://prometheus-operated.prometheus.svc:9090"
			}]
		})
		"grafana.ini": """
			[database]
			path = /etc/grafana/database/grafana.db

			[auth.anonymous]
			enabled = true
			org_role = Admin

			[log]
			mode = console
			"""
	}
}]
