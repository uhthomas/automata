package livesync

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
	data: "local.ini": """
		[couchdb]
		single_node = true
		max_document_size = 50000000

		[cluster]
		n = 1

		[chttpd]
		bind_address = 0.0.0.0
		require_valid_user = true
		require_valid_user_except_for_up = true
		enable_cors = true
		max_http_request_size = 4294967296

		[chttpd_auth]
		require_valid_user = true

		[httpd]
		WWW-Authenticate = Basic realm="couchdb"
		enable_cors = true

		[cors]
		credentials = true
		origins = app://obsidian.md,capacitor://localhost,http://localhost
		"""
}]
