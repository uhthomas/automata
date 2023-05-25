package gateway

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
	data: "nginx.conf": """
		worker_processes  5;  ## Default: 1
		error_log  /dev/stderr;
		pid        /tmp/nginx.pid;
		worker_rlimit_nofile 8192;

		events {
		  worker_connections  4096;  ## Default: 1024
		}

		http {
		  client_body_temp_path /tmp/client_temp;
		  proxy_temp_path       /tmp/proxy_temp_path;
		  fastcgi_temp_path     /tmp/fastcgi_temp;
		  uwsgi_temp_path       /tmp/uwsgi_temp;
		  scgi_temp_path        /tmp/scgi_temp;

		  client_max_body_size 4M;

		  proxy_read_timeout    600; ## 6 minutes
		  proxy_send_timeout    600;
		  proxy_connect_timeout 600;

		  proxy_http_version    1.1;

		  default_type application/octet-stream;
		  log_format   main '$remote_addr - $remote_user [$time_local]  $status '
		        '\"$request\" $body_bytes_sent \"$http_referer\" '
		        '\"$http_user_agent\" \"$http_x_forwarded_for\"';
		  access_log   /dev/stderr  main;

		  sendfile     on;
		  tcp_nopush   on;
		  resolver kube-dns.kube-system.svc.cluster.local.;


		  server {
		    listen             8080;

		    location = / {
		      return 200 'OK';
		      auth_basic off;
		    }


		    # Distributor
		    location = /api/prom/push {
		      proxy_pass       http://loki-write.loki.svc.cluster.local:3100$request_uri;
		    }
		    location = /loki/api/v1/push {
		      proxy_pass       http://loki-write.loki.svc.cluster.local:3100$request_uri;
		    }
		    location = /distributor/ring {
		      proxy_pass       http://loki-write.loki.svc.cluster.local:3100$request_uri;
		    }

		    # Ingester
		    location = /flush {
		      proxy_pass       http://loki-write.loki.svc.cluster.local:3100$request_uri;
		    }
		    location ^~ /ingester/ {
		      proxy_pass       http://loki-write.loki.svc.cluster.local:3100$request_uri;
		    }
		    location = /ingester {
		      internal;        # to suppress 301
		    }

		    # Ring
		    location = /ring {
		      proxy_pass       http://loki-write.loki.svc.cluster.local:3100$request_uri;
		    }

		    # MemberListKV
		    location = /memberlist {
		      proxy_pass       http://loki-write.loki.svc.cluster.local:3100$request_uri;
		    }


		    # Ruler
		    location = /ruler/ring {
		      proxy_pass       http://loki-backend.loki.svc.cluster.local:3100$request_uri;
		    }
		    location = /api/prom/rules {
		      proxy_pass       http://loki-backend.loki.svc.cluster.local:3100$request_uri;
		    }
		    location ^~ /api/prom/rules/ {
		      proxy_pass       http://loki-backend.loki.svc.cluster.local:3100$request_uri;
		    }
		    location = /loki/api/v1/rules {
		      proxy_pass       http://loki-backend.loki.svc.cluster.local:3100$request_uri;
		    }
		    location ^~ /loki/api/v1/rules/ {
		      proxy_pass       http://loki-backend.loki.svc.cluster.local:3100$request_uri;
		    }
		    location = /prometheus/api/v1/alerts {
		      proxy_pass       http://loki-backend.loki.svc.cluster.local:3100$request_uri;
		    }
		    location = /prometheus/api/v1/rules {
		      proxy_pass       http://loki-backend.loki.svc.cluster.local:3100$request_uri;
		    }

		    # Compactor
		    location = /compactor/ring {
		      proxy_pass       http://loki-backend.loki.svc.cluster.local:3100$request_uri;
		    }
		    location = /loki/api/v1/delete {
		      proxy_pass       http://loki-backend.loki.svc.cluster.local:3100$request_uri;
		    }
		    location = /loki/api/v1/cache/generation_numbers {
		      proxy_pass       http://loki-backend.loki.svc.cluster.local:3100$request_uri;
		    }

		    # IndexGateway
		    location = /indexgateway/ring {
		      proxy_pass       http://loki-backend.loki.svc.cluster.local:3100$request_uri;
		    }

		    # QueryScheduler
		    location = /scheduler/ring {
		      proxy_pass       http://loki-backend.loki.svc.cluster.local:3100$request_uri;
		    }


		    # QueryFrontend, Querier
		    location = /api/prom/tail {
		      proxy_pass       http://loki-read.loki.svc.cluster.local:3100$request_uri;
		      proxy_set_header Upgrade $http_upgrade;
		      proxy_set_header Connection \"upgrade\";
		    }
		    location = /loki/api/v1/tail {
		      proxy_pass       http://loki-read.loki.svc.cluster.local:3100$request_uri;
		      proxy_set_header Upgrade $http_upgrade;
		      proxy_set_header Connection \"upgrade\";
		    }
		    location ^~ /api/prom/ {
		      proxy_pass       http://loki-read.loki.svc.cluster.local:3100$request_uri;
		    }
		    location = /api/prom {
		      internal;        # to suppress 301
		    }
		    location ^~ /loki/api/v1/ {
		      proxy_pass       http://loki-read.loki.svc.cluster.local:3100$request_uri;
		    }
		    location = /loki/api/v1 {
		      internal;        # to suppress 301
		    }
		  }
		}
		"""
}]
