package hubble_ui

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
	metadata: name: "hubble-ui-nginx"
	data: "nginx.conf": """
		server {
		    listen       8081;
		    listen       [::]:8081;
		    server_name  localhost;
		    root /app;
		    index index.html;
		    client_max_body_size 1G;

		    location / {
		        proxy_set_header Host $host;
		        proxy_set_header X-Real-IP $remote_addr;

		        location /api {
		            proxy_http_version 1.1;
		            proxy_pass_request_headers on;
		            proxy_pass http://127.0.0.1:8090;
		        }
		        location / {
		            if ($http_user_agent ~* "kube-probe") { access_log off; }
		            # double `/index.html` is required here
		            try_files $uri $uri/ /index.html /index.html;
		        }

			# Liveness probe
		        location /healthz {
		            access_log off;
		            add_header Content-Type text/plain;
		            return 200 'ok';
		        }
		    }
		}
		"""
}]
