package grafana

import "k8s.io/api/core/v1"

#ConfigMapList: v1.#ConfigMapList & {
	apiVersion: "v1"
	kind:       "ConfigMapList"
	items: [...{
		apiVersion: "v1"
		kind:       "ConfigMap"
	}]
}

#ConfigMapList: items: [{
	data: "grafana.ini": """
		[analytics]
		check_for_updates = true

		[grafana_net]
		url = https://grafana.net

		[server]
		root_url = https://grafana-magiclove.hipparcos.net

		[log]
		mode = console

		[paths]
		data = /var/lib/grafana/
		logs = /var/log/grafana
		plugins = /var/lib/grafana/plugins

		[database]
		path = /var/lib/grafana/database/grafana.db

		[auth]
		oauth_auto_login = true

		[auth.generic_oauth]
		enabled = true
		name = Kanidm
		allow_sign_up = true
		scopes = openid profile email groups
		auth_url = https://kanidm-magiclove.hipparcos.net/ui/oauth2
		token_url = https://kanidm-magiclove.hipparcos.net/oauth2/token
		api_url = https://kanidm-magiclove.hipparcos.net/oauth2/openid/grafana/userinfo
		use_pkce = true
		role_attribute_path = contains(groups[*], 'admins') && 'Admin' || 'Viewer'

		"""
}]
