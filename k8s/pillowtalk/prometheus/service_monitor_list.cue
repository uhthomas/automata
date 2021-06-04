package prometheus

import "k8s.io/api/core/v1"

serviceMonitorList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "monitoring.coreos.com/v1"
		kind:       "ServiceMonitor"
	}]
}

serviceMonitorList: items: [{
	spec: {
		endpoints: [{port: "web"}]
		selector: matchLabels: {
			"app.kubernetes.io/name":      "prometheus"
			"app.kubernetes.io/instance":  "prometheus"
			"app.kubernetes.io/component": "prometheus"
		}
	}
}, {
	metadata: name: "prometheus-operator"
	spec: {
		endpoints: [{port: "http"}]
		selector: matchLabels: {
			"app.kubernetes.io/name":      "prometheus-operator"
			"app.kubernetes.io/instance":  "prometheus-operator"
			"app.kubernetes.io/component": "controller"
		}
		namespaceSelector: matchNames: ["prometheus-operator"]
	}
}, {
	metadata: name: "kube-state-metrics"
	spec: {
		endpoints: [{
			port: "http-metrics"
			relabelings: [{
				action: "labeldrop"
				regex:  "(pod|service|endpoint|namespace)"
			}]
		}, {port: "telemetry"}]
		jobLabel: "app.kubernetes.io/name"
		selector: matchLabels: {
			"app.kubernetes.io/name":      "kube-state-metrics"
			"app.kubernetes.io/instance":  "kube-state-metrics"
			"app.kubernetes.io/component": "kube-state-metrics"
		}
		namespaceSelector: matchNames: ["kube-state-metrics"]
	}
}, {
	metadata: name: "node-exporter"
	spec: {
		endpoints: [{
			port: "metrics"
			relabelings: [{
				action:      "replace"
				regex:       "(.*)"
				replacement: "$1"
				sourceLabels: ["__meta_kubernetes_pod_node_name"]
				targetLabel: "instance"
			}]
		}]
		jobLabel: "app.kubernetes.io/name"
		selector: matchLabels: {
			"app.kubernetes.io/name":      "node-exporter"
			"app.kubernetes.io/instance":  "node-exporter"
			"app.kubernetes.io/component": "exporter"
		}
		namespaceSelector: matchNames: ["node-exporter"]
	}
}, {
	metadata: {
		name: "rook-ceph-mgr"
		labels: team: "rook"
	}
	spec: {
		namespaceSelector: matchNames: ["rook-ceph"]
		selector: matchLabels: {
			app:            "rook-ceph-mgr"
			rook_cluster:   "rook-ceph"
			ceph_daemon_id: "a"
		}
		endpoints: [{
			port:     "http-metrics"
			path:     "/metrics"
			interval: "5s"
		}]
	}
}, {
	metadata: {
		name: "csi-metrics"
		labels: team: "rook"
	}
	spec: {
		namespaceSelector: matchNames: ["rook-ceph"]
		selector: matchLabels: app: "csi-metrics"
		endpoints: [{
			port:     "csi-http-metrics"
			path:     "/metrics"
			interval: "5s"
		}]
	}
}, {
	metadata: {
		name:      "kube-apiserver"
		labels: "app.kubernetes.io/name": "apiserver"
	}
	spec: {
		endpoints: [{
			bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
			interval:        "30s"
			metricRelabelings: [{
				action: "drop"
				regex:  "kubelet_(pod_worker_latency_microseconds|pod_start_latency_microseconds|cgroup_manager_latency_microseconds|pod_worker_start_latency_microseconds|pleg_relist_latency_microseconds|pleg_relist_interval_microseconds|runtime_operations|runtime_operations_latency_microseconds|runtime_operations_errors|eviction_stats_age_microseconds|device_plugin_registration_count|device_plugin_alloc_latency_microseconds|network_plugin_operations_latency_microseconds)"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "scheduler_(e2e_scheduling_latency_microseconds|scheduling_algorithm_predicate_evaluation|scheduling_algorithm_priority_evaluation|scheduling_algorithm_preemption_evaluation|scheduling_algorithm_latency_microseconds|binding_latency_microseconds|scheduling_latency_seconds)"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "apiserver_(request_count|request_latencies|request_latencies_summary|dropped_requests|storage_data_key_generation_latencies_microseconds|storage_transformation_failures_total|storage_transformation_latencies_microseconds|proxy_tunnel_sync_latency_secs)"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "kubelet_docker_(operations|operations_latency_microseconds|operations_errors|operations_timeout)"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "reflector_(items_per_list|items_per_watch|list_duration_seconds|lists_total|short_watches_total|watch_duration_seconds|watches_total)"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "etcd_(helper_cache_hit_count|helper_cache_miss_count|helper_cache_entry_count|request_cache_get_latencies_summary|request_cache_add_latencies_summary|request_latencies_summary)"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "transformation_(transformation_latencies_microseconds|failures_total)"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "(admission_quota_controller_adds|admission_quota_controller_depth|admission_quota_controller_longest_running_processor_microseconds|admission_quota_controller_queue_latency|admission_quota_controller_unfinished_work_seconds|admission_quota_controller_work_duration|APIServiceOpenAPIAggregationControllerQueue1_adds|APIServiceOpenAPIAggregationControllerQueue1_depth|APIServiceOpenAPIAggregationControllerQueue1_longest_running_processor_microseconds|APIServiceOpenAPIAggregationControllerQueue1_queue_latency|APIServiceOpenAPIAggregationControllerQueue1_retries|APIServiceOpenAPIAggregationControllerQueue1_unfinished_work_seconds|APIServiceOpenAPIAggregationControllerQueue1_work_duration|APIServiceRegistrationController_adds|APIServiceRegistrationController_depth|APIServiceRegistrationController_longest_running_processor_microseconds|APIServiceRegistrationController_queue_latency|APIServiceRegistrationController_retries|APIServiceRegistrationController_unfinished_work_seconds|APIServiceRegistrationController_work_duration|autoregister_adds|autoregister_depth|autoregister_longest_running_processor_microseconds|autoregister_queue_latency|autoregister_retries|autoregister_unfinished_work_seconds|autoregister_work_duration|AvailableConditionController_adds|AvailableConditionController_depth|AvailableConditionController_longest_running_processor_microseconds|AvailableConditionController_queue_latency|AvailableConditionController_retries|AvailableConditionController_unfinished_work_seconds|AvailableConditionController_work_duration|crd_autoregistration_controller_adds|crd_autoregistration_controller_depth|crd_autoregistration_controller_longest_running_processor_microseconds|crd_autoregistration_controller_queue_latency|crd_autoregistration_controller_retries|crd_autoregistration_controller_unfinished_work_seconds|crd_autoregistration_controller_work_duration|crdEstablishing_adds|crdEstablishing_depth|crdEstablishing_longest_running_processor_microseconds|crdEstablishing_queue_latency|crdEstablishing_retries|crdEstablishing_unfinished_work_seconds|crdEstablishing_work_duration|crd_finalizer_adds|crd_finalizer_depth|crd_finalizer_longest_running_processor_microseconds|crd_finalizer_queue_latency|crd_finalizer_retries|crd_finalizer_unfinished_work_seconds|crd_finalizer_work_duration|crd_naming_condition_controller_adds|crd_naming_condition_controller_depth|crd_naming_condition_controller_longest_running_processor_microseconds|crd_naming_condition_controller_queue_latency|crd_naming_condition_controller_retries|crd_naming_condition_controller_unfinished_work_seconds|crd_naming_condition_controller_work_duration|crd_openapi_controller_adds|crd_openapi_controller_depth|crd_openapi_controller_longest_running_processor_microseconds|crd_openapi_controller_queue_latency|crd_openapi_controller_retries|crd_openapi_controller_unfinished_work_seconds|crd_openapi_controller_work_duration|DiscoveryController_adds|DiscoveryController_depth|DiscoveryController_longest_running_processor_microseconds|DiscoveryController_queue_latency|DiscoveryController_retries|DiscoveryController_unfinished_work_seconds|DiscoveryController_work_duration|kubeproxy_sync_proxy_rules_latency_microseconds|non_structural_schema_condition_controller_adds|non_structural_schema_condition_controller_depth|non_structural_schema_condition_controller_longest_running_processor_microseconds|non_structural_schema_condition_controller_queue_latency|non_structural_schema_condition_controller_retries|non_structural_schema_condition_controller_unfinished_work_seconds|non_structural_schema_condition_controller_work_duration|rest_client_request_latency_seconds|storage_operation_errors_total|storage_operation_status_count)"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "etcd_(debugging|disk|server).*"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "apiserver_admission_controller_admission_latencies_seconds_.*"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "apiserver_admission_step_admission_latencies_seconds_.*"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "apiserver_request_duration_seconds_bucket;(0.15|0.25|0.3|0.35|0.4|0.45|0.6|0.7|0.8|0.9|1.25|1.5|1.75|2.5|3|3.5|4.5|6|7|8|9|15|25|30|50)"
				sourceLabels: [
					"__name__",
					"le",
				]
			}]
			port:   "https"
			scheme: "https"
			tlsConfig: {
				caFile:     "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
				serverName: "kubernetes"
			}
		}]
		jobLabel: "component"
		namespaceSelector: matchNames: [
			"default",
		]
		selector: matchLabels: {
			component: "apiserver"
			provider:  "kubernetes"
		}
	}
}, {
	metadata: {
		name:      "coredns"
		labels: "app.kubernetes.io/name": "coredns"
	}
	spec: {
		endpoints: [{
			bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
			interval:        "15s"
			port:            "metrics"
		}]
		jobLabel: "app.kubernetes.io/name"
		namespaceSelector: matchNames: [
			"kube-system",
		]
		selector: matchLabels: "app.kubernetes.io/name": "kube-dns"
	}
}, {
	metadata: {
		name:      "kube-controller-manager"
		labels: "app.kubernetes.io/name": "kube-controller-manager"
	}
	spec: {
		endpoints: [{
			bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
			interval:        "30s"
			metricRelabelings: [{
				action: "drop"
				regex:  "kubelet_(pod_worker_latency_microseconds|pod_start_latency_microseconds|cgroup_manager_latency_microseconds|pod_worker_start_latency_microseconds|pleg_relist_latency_microseconds|pleg_relist_interval_microseconds|runtime_operations|runtime_operations_latency_microseconds|runtime_operations_errors|eviction_stats_age_microseconds|device_plugin_registration_count|device_plugin_alloc_latency_microseconds|network_plugin_operations_latency_microseconds)"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "scheduler_(e2e_scheduling_latency_microseconds|scheduling_algorithm_predicate_evaluation|scheduling_algorithm_priority_evaluation|scheduling_algorithm_preemption_evaluation|scheduling_algorithm_latency_microseconds|binding_latency_microseconds|scheduling_latency_seconds)"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "apiserver_(request_count|request_latencies|request_latencies_summary|dropped_requests|storage_data_key_generation_latencies_microseconds|storage_transformation_failures_total|storage_transformation_latencies_microseconds|proxy_tunnel_sync_latency_secs)"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "kubelet_docker_(operations|operations_latency_microseconds|operations_errors|operations_timeout)"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "reflector_(items_per_list|items_per_watch|list_duration_seconds|lists_total|short_watches_total|watch_duration_seconds|watches_total)"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "etcd_(helper_cache_hit_count|helper_cache_miss_count|helper_cache_entry_count|request_cache_get_latencies_summary|request_cache_add_latencies_summary|request_latencies_summary)"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "transformation_(transformation_latencies_microseconds|failures_total)"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "(admission_quota_controller_adds|admission_quota_controller_depth|admission_quota_controller_longest_running_processor_microseconds|admission_quota_controller_queue_latency|admission_quota_controller_unfinished_work_seconds|admission_quota_controller_work_duration|APIServiceOpenAPIAggregationControllerQueue1_adds|APIServiceOpenAPIAggregationControllerQueue1_depth|APIServiceOpenAPIAggregationControllerQueue1_longest_running_processor_microseconds|APIServiceOpenAPIAggregationControllerQueue1_queue_latency|APIServiceOpenAPIAggregationControllerQueue1_retries|APIServiceOpenAPIAggregationControllerQueue1_unfinished_work_seconds|APIServiceOpenAPIAggregationControllerQueue1_work_duration|APIServiceRegistrationController_adds|APIServiceRegistrationController_depth|APIServiceRegistrationController_longest_running_processor_microseconds|APIServiceRegistrationController_queue_latency|APIServiceRegistrationController_retries|APIServiceRegistrationController_unfinished_work_seconds|APIServiceRegistrationController_work_duration|autoregister_adds|autoregister_depth|autoregister_longest_running_processor_microseconds|autoregister_queue_latency|autoregister_retries|autoregister_unfinished_work_seconds|autoregister_work_duration|AvailableConditionController_adds|AvailableConditionController_depth|AvailableConditionController_longest_running_processor_microseconds|AvailableConditionController_queue_latency|AvailableConditionController_retries|AvailableConditionController_unfinished_work_seconds|AvailableConditionController_work_duration|crd_autoregistration_controller_adds|crd_autoregistration_controller_depth|crd_autoregistration_controller_longest_running_processor_microseconds|crd_autoregistration_controller_queue_latency|crd_autoregistration_controller_retries|crd_autoregistration_controller_unfinished_work_seconds|crd_autoregistration_controller_work_duration|crdEstablishing_adds|crdEstablishing_depth|crdEstablishing_longest_running_processor_microseconds|crdEstablishing_queue_latency|crdEstablishing_retries|crdEstablishing_unfinished_work_seconds|crdEstablishing_work_duration|crd_finalizer_adds|crd_finalizer_depth|crd_finalizer_longest_running_processor_microseconds|crd_finalizer_queue_latency|crd_finalizer_retries|crd_finalizer_unfinished_work_seconds|crd_finalizer_work_duration|crd_naming_condition_controller_adds|crd_naming_condition_controller_depth|crd_naming_condition_controller_longest_running_processor_microseconds|crd_naming_condition_controller_queue_latency|crd_naming_condition_controller_retries|crd_naming_condition_controller_unfinished_work_seconds|crd_naming_condition_controller_work_duration|crd_openapi_controller_adds|crd_openapi_controller_depth|crd_openapi_controller_longest_running_processor_microseconds|crd_openapi_controller_queue_latency|crd_openapi_controller_retries|crd_openapi_controller_unfinished_work_seconds|crd_openapi_controller_work_duration|DiscoveryController_adds|DiscoveryController_depth|DiscoveryController_longest_running_processor_microseconds|DiscoveryController_queue_latency|DiscoveryController_retries|DiscoveryController_unfinished_work_seconds|DiscoveryController_work_duration|kubeproxy_sync_proxy_rules_latency_microseconds|non_structural_schema_condition_controller_adds|non_structural_schema_condition_controller_depth|non_structural_schema_condition_controller_longest_running_processor_microseconds|non_structural_schema_condition_controller_queue_latency|non_structural_schema_condition_controller_retries|non_structural_schema_condition_controller_unfinished_work_seconds|non_structural_schema_condition_controller_work_duration|rest_client_request_latency_seconds|storage_operation_errors_total|storage_operation_status_count)"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "etcd_(debugging|disk|request|server).*"
				sourceLabels: [
					"__name__",
				]
			}]
			port:   "https-metrics"
			scheme: "https"
			tlsConfig: insecureSkipVerify: true
		}]
		jobLabel: "app.kubernetes.io/name"
		namespaceSelector: matchNames: [
			"kube-system",
		]
		selector: matchLabels: "app.kubernetes.io/name": "kube-controller-manager"
	}
}, {
	metadata: {
		name:      "kube-scheduler"
		labels: "app.kubernetes.io/name": "kube-scheduler"
	}
	spec: {
		endpoints: [{
			bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
			interval:        "30s"
			port:            "https-metrics"
			scheme:          "https"
			tlsConfig: insecureSkipVerify: true
		}]
		jobLabel: "app.kubernetes.io/name"
		namespaceSelector: matchNames: [
			"kube-system",
		]
		selector: matchLabels: "app.kubernetes.io/name": "kube-scheduler"
	}
}, {
	apiVersion: "monitoring.coreos.com/v1"
	kind:       "ServiceMonitor"
	metadata: {
		name:      "kubelet"
		labels: "app.kubernetes.io/name": "kubelet"
	}
	spec: {
		endpoints: [{
			bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
			honorLabels:     true
			interval:        "30s"
			metricRelabelings: [{
				action: "drop"
				regex:  "kubelet_(pod_worker_latency_microseconds|pod_start_latency_microseconds|cgroup_manager_latency_microseconds|pod_worker_start_latency_microseconds|pleg_relist_latency_microseconds|pleg_relist_interval_microseconds|runtime_operations|runtime_operations_latency_microseconds|runtime_operations_errors|eviction_stats_age_microseconds|device_plugin_registration_count|device_plugin_alloc_latency_microseconds|network_plugin_operations_latency_microseconds)"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "scheduler_(e2e_scheduling_latency_microseconds|scheduling_algorithm_predicate_evaluation|scheduling_algorithm_priority_evaluation|scheduling_algorithm_preemption_evaluation|scheduling_algorithm_latency_microseconds|binding_latency_microseconds|scheduling_latency_seconds)"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "apiserver_(request_count|request_latencies|request_latencies_summary|dropped_requests|storage_data_key_generation_latencies_microseconds|storage_transformation_failures_total|storage_transformation_latencies_microseconds|proxy_tunnel_sync_latency_secs)"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "kubelet_docker_(operations|operations_latency_microseconds|operations_errors|operations_timeout)"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "reflector_(items_per_list|items_per_watch|list_duration_seconds|lists_total|short_watches_total|watch_duration_seconds|watches_total)"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "etcd_(helper_cache_hit_count|helper_cache_miss_count|helper_cache_entry_count|request_cache_get_latencies_summary|request_cache_add_latencies_summary|request_latencies_summary)"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "transformation_(transformation_latencies_microseconds|failures_total)"
				sourceLabels: [
					"__name__",
				]
			}, {
				action: "drop"
				regex:  "(admission_quota_controller_adds|admission_quota_controller_depth|admission_quota_controller_longest_running_processor_microseconds|admission_quota_controller_queue_latency|admission_quota_controller_unfinished_work_seconds|admission_quota_controller_work_duration|APIServiceOpenAPIAggregationControllerQueue1_adds|APIServiceOpenAPIAggregationControllerQueue1_depth|APIServiceOpenAPIAggregationControllerQueue1_longest_running_processor_microseconds|APIServiceOpenAPIAggregationControllerQueue1_queue_latency|APIServiceOpenAPIAggregationControllerQueue1_retries|APIServiceOpenAPIAggregationControllerQueue1_unfinished_work_seconds|APIServiceOpenAPIAggregationControllerQueue1_work_duration|APIServiceRegistrationController_adds|APIServiceRegistrationController_depth|APIServiceRegistrationController_longest_running_processor_microseconds|APIServiceRegistrationController_queue_latency|APIServiceRegistrationController_retries|APIServiceRegistrationController_unfinished_work_seconds|APIServiceRegistrationController_work_duration|autoregister_adds|autoregister_depth|autoregister_longest_running_processor_microseconds|autoregister_queue_latency|autoregister_retries|autoregister_unfinished_work_seconds|autoregister_work_duration|AvailableConditionController_adds|AvailableConditionController_depth|AvailableConditionController_longest_running_processor_microseconds|AvailableConditionController_queue_latency|AvailableConditionController_retries|AvailableConditionController_unfinished_work_seconds|AvailableConditionController_work_duration|crd_autoregistration_controller_adds|crd_autoregistration_controller_depth|crd_autoregistration_controller_longest_running_processor_microseconds|crd_autoregistration_controller_queue_latency|crd_autoregistration_controller_retries|crd_autoregistration_controller_unfinished_work_seconds|crd_autoregistration_controller_work_duration|crdEstablishing_adds|crdEstablishing_depth|crdEstablishing_longest_running_processor_microseconds|crdEstablishing_queue_latency|crdEstablishing_retries|crdEstablishing_unfinished_work_seconds|crdEstablishing_work_duration|crd_finalizer_adds|crd_finalizer_depth|crd_finalizer_longest_running_processor_microseconds|crd_finalizer_queue_latency|crd_finalizer_retries|crd_finalizer_unfinished_work_seconds|crd_finalizer_work_duration|crd_naming_condition_controller_adds|crd_naming_condition_controller_depth|crd_naming_condition_controller_longest_running_processor_microseconds|crd_naming_condition_controller_queue_latency|crd_naming_condition_controller_retries|crd_naming_condition_controller_unfinished_work_seconds|crd_naming_condition_controller_work_duration|crd_openapi_controller_adds|crd_openapi_controller_depth|crd_openapi_controller_longest_running_processor_microseconds|crd_openapi_controller_queue_latency|crd_openapi_controller_retries|crd_openapi_controller_unfinished_work_seconds|crd_openapi_controller_work_duration|DiscoveryController_adds|DiscoveryController_depth|DiscoveryController_longest_running_processor_microseconds|DiscoveryController_queue_latency|DiscoveryController_retries|DiscoveryController_unfinished_work_seconds|DiscoveryController_work_duration|kubeproxy_sync_proxy_rules_latency_microseconds|non_structural_schema_condition_controller_adds|non_structural_schema_condition_controller_depth|non_structural_schema_condition_controller_longest_running_processor_microseconds|non_structural_schema_condition_controller_queue_latency|non_structural_schema_condition_controller_retries|non_structural_schema_condition_controller_unfinished_work_seconds|non_structural_schema_condition_controller_work_duration|rest_client_request_latency_seconds|storage_operation_errors_total|storage_operation_status_count)"
				sourceLabels: [
					"__name__",
				]
			}]
			port: "https-metrics"
			relabelings: [{
				sourceLabels: [
					"__metrics_path__",
				]
				targetLabel: "metrics_path"
			}]
			scheme: "https"
			tlsConfig: insecureSkipVerify: true
		}, {
			bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
			honorLabels:     true
			honorTimestamps: false
			interval:        "30s"
			metricRelabelings: [{
				action: "drop"
				regex:  "container_(network_tcp_usage_total|network_udp_usage_total|tasks_state|cpu_load_average_10s)"
				sourceLabels: [
					"__name__",
				]
			}]
			path: "/metrics/cadvisor"
			port: "https-metrics"
			relabelings: [{
				sourceLabels: [
					"__metrics_path__",
				]
				targetLabel: "metrics_path"
			}]
			scheme: "https"
			tlsConfig: insecureSkipVerify: true
		}, {
			bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
			honorLabels:     true
			interval:        "30s"
			path:            "/metrics/probes"
			port:            "https-metrics"
			relabelings: [{
				sourceLabels: [
					"__metrics_path__",
				]
				targetLabel: "metrics_path"
			}]
			scheme: "https"
			tlsConfig: insecureSkipVerify: true
		}]
		jobLabel: "app.kubernetes.io/name"
		namespaceSelector: matchNames: [
			"kube-system",
		]
		selector: matchLabels: "app.kubernetes.io/name": "kubelet"
	}
}]
