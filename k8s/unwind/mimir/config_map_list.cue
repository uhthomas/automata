package mimir

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
	metadata: name:     "\(#Name)-config"
	data: "mimir.yaml": yaml.Marshal({
		common: storage: {
			backend: "s3"
			s3: {
				region:   ""
				insecure: true
			}
		}
		activity_tracker: filepath: "/active-query-tracker/activity.log"
		alertmanager: {
			data_dir:             "/data"
			enable_api:           true
			external_url:         "/alertmanager"
			fallback_config_file: "/configs/alertmanager_fallback_config.yaml"
		}
		blocks_storage: {
			backend: "s3"
			bucket_store: {
				max_chunk_pool_bytes: 12884901888
				sync_dir:             "/data/tsdb-sync"
			}
			tsdb: dir: "/data/tsdb"
			s3: {
				endpoint:          "${MIMIR_BLOCKS_BUCKET_HOST}"
				bucket_name:       "${MIMIR_BLOCKS_BUCKET_NAME}"
				access_key_id:     "${MIMIR_BLOCKS_AWS_ACCESS_KEY_ID}"
				secret_access_key: "${MIMIR_BLOCKS_AWS_SECRET_ACCESS_KEY}"
			}
		}
		compactor: {
			compaction_interval:            "30m"
			data_dir:                       "/data"
			deletion_delay:                 "2h"
			max_closing_blocks_concurrency: 2
			max_opening_blocks_concurrency: 4
			sharding_ring: wait_stability_min_duration: "1m"
			symbols_flushers_concurrency: 4
		}
		frontend: {
			parallelize_shardable_queries: true
			scheduler_address:             "mimir-query-scheduler-headless.mimir.svc:9095"
		}
		frontend_worker: {
			grpc_client_config: max_send_msg_size: 419430400
			scheduler_address: "mimir-query-scheduler-headless.mimir.svc:9095"
		}
		ingester: ring: {
			final_sleep:            "0s"
			num_tokens:             512
			tokens_file_path:       "/data/tokens"
			unregister_on_shutdown: false
			zone_awareness_enabled: true
		}
		ingester_client: grpc_client_config: {
			max_recv_msg_size: 104857600
			max_send_msg_size: 104857600
		}
		limits: {
			max_cache_freshness:        "10m"
			max_global_series_per_user: 1_000_000
			max_query_parallelism:      240
			max_total_query_length:     "12000h"
		}
		memberlist: {
			abort_if_cluster_join_fails: false
			compression_enabled:         false
			join_members: ["dns+mimir-gossip-ring.mimir.svc.cluster.local:7946"]
		}
		querier: max_concurrent:                              16
		query_scheduler: max_outstanding_requests_per_tenant: 800
		ruler: {
			alertmanager_url: "dnssrvnoa+http://_http-metrics._tcp.mimir-alertmanager-headless.mimir.svc.cluster.local/alertmanager"
			enable_api:       true
			rule_path:        "/data"
		}
		ruler_storage: s3: {
			endpoint:          "${MIMIR_RULER_BUCKET_HOST}"
			bucket_name:       "${MIMIR_RULER_BUCKET_NAME}"
			access_key_id:     "${MIMIR_RULER_AWS_ACCESS_KEY_ID}"
			secret_access_key: "${MIMIR_RULER_AWS_SECRET_ACCESS_KEY}"
		}
		runtime_config: file: "/var/mimir/runtime.yaml"
		server: {
			grpc_server_max_concurrent_streams:   1000
			grpc_server_max_connection_age:       "2m"
			grpc_server_max_connection_age_grace: "5m"
			grpc_server_max_connection_idle:      "1m"
		}
		store_gateway: sharding_ring: {
			kvstore: prefix: "multi-zone/"
			tokens_file_path:            "/data/tokens"
			wait_stability_min_duration: "1m"
			zone_awareness_enabled:      true
		}
	})
}, {
	metadata: {
		name: "\(#Name)-nginx"
		labels: "app.kubernetes.io/component": "nginx"
	}
	data: "nginx.conf": """
		worker_processes  5;  ## Default: 1
		error_log  /dev/stderr error;
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

		  default_type application/octet-stream;
		  log_format   main '$remote_addr - $remote_user [$time_local]  $status '
		        '\"$request\" $body_bytes_sent \"$http_referer\" '
		        '\"$http_user_agent\" \"$http_x_forwarded_for\"';
		  access_log   /dev/stderr  main;

		  sendfile     on;
		  tcp_nopush   on;
		  resolver kube-dns.kube-system.svc.cluster.local;

		  # Ensure that X-Scope-OrgID is always present, default to the no_auth_tenant for backwards compatibility when multi-tenancy was turned off.
		  map $http_x_scope_orgid $ensured_x_scope_orgid {
		    default $http_x_scope_orgid;
		    \"\" \"anonymous\";
		  }

		  server {
		    listen 8080;

		    location = / {
		      return 200 'OK';
		      auth_basic off;
		    }

		    proxy_set_header X-Scope-OrgID $ensured_x_scope_orgid;

		    # Distributor endpoints
		    location /distributor {
		      set $distributor mimir-distributor-headless.mimir.svc.cluster.local;
		      proxy_pass      http://$distributor:8080$request_uri;
		    }
		    location = /api/v1/push {
		      set $distributor mimir-distributor-headless.mimir.svc.cluster.local;
		      proxy_pass      http://$distributor:8080$request_uri;
		    }
		    location /otlp/v1/metrics {
		      set $distributor mimir-distributor-headless.mimir.svc.cluster.local;
		      proxy_pass      http://$distributor:8080$request_uri;
		    }

		    # Alertmanager endpoints
		    location /alertmanager {
		      set $alertmanager mimir-alertmanager-headless.mimir.svc.cluster.local;
		      proxy_pass      http://$alertmanager:8080$request_uri;
		    }
		    location = /multitenant_alertmanager/status {
		      set $alertmanager mimir-alertmanager-headless.mimir.svc.cluster.local;
		      proxy_pass      http://$alertmanager:8080$request_uri;
		    }
		    location = /api/v1/alerts {
		      set $alertmanager mimir-alertmanager-headless.mimir.svc.cluster.local;
		      proxy_pass      http://$alertmanager:8080$request_uri;
		    }

		    # Ruler endpoints
		    location /prometheus/config/v1/rules {
		      set $ruler mimir-ruler.mimir.svc.cluster.local;
		      proxy_pass      http://$ruler:8080$request_uri;
		    }
		    location /prometheus/api/v1/rules {
		      set $ruler mimir-ruler.mimir.svc.cluster.local;
		      proxy_pass      http://$ruler:8080$request_uri;
		    }

		    location /prometheus/api/v1/alerts {
		      set $ruler mimir-ruler.mimir.svc.cluster.local;
		      proxy_pass      http://$ruler:8080$request_uri;
		    }
		    location = /ruler/ring {
		      set $ruler mimir-ruler.mimir.svc.cluster.local;
		      proxy_pass      http://$ruler:8080$request_uri;
		    }

		    # Rest of /prometheus goes to the query frontend
		    location /prometheus {
		      set $query_frontend mimir-query-frontend.mimir.svc.cluster.local;
		      proxy_pass      http://$query_frontend:8080$request_uri;
		    }

		    # Buildinfo endpoint can go to any component
		    location = /api/v1/status/buildinfo {
		      set $query_frontend mimir-query-frontend.mimir.svc.cluster.local;
		      proxy_pass      http://$query_frontend:8080$request_uri;
		    }

		    # Compactor endpoint for uploading blocks
		    location /api/v1/upload/block/ {
		      set $compactor mimir-compactor.mimir.svc.cluster.local;
		      proxy_pass      http://$compactor:8080$request_uri;
		    }
		  }
		}

		"""
}, {
	metadata: name:       "mimir-runtime"
	data: "runtime.yaml": yaml.Marshal({})
}]
