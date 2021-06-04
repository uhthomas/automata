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
