package grafana_agent

import "k8s.io/api/core/v1"

#ServiceMonitorList: v1.#List & {
	apiVersion: "monitoring.coreos.com/v1"
	kind:       "ServiceMonitor"
	items: [...{
		apiVersion: "monitoring.coreos.com/v1"
		kind:       "ServiceMonitor"
	}]
}

#ServiceMonitorList: items: [{
	metadata: name: "\(#Name)-kubelet"
	spec: {
		endpoints: [{
			bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
			honorLabels:     true
			interval:        "60s"
			port:            "https-metrics"
			relabelings: [{
				sourceLabels: ["__metrics_path__"]
				targetLabel: "metrics_path"
			}, {
				action:      "replace"
				targetLabel: "job"
				replacement: "integrations/kubernetes/kubelet"
			}]
			scheme: "https"
			tlsConfig: insecureSkipVerify: true
		}]
		namespaceSelector: matchNames: ["grafana-agent-operator"]
		selector: matchLabels: "app.kubernetes.io/name": "kubelet"
	}

}, {
	metadata: name: "\(#Name)-cadvisor"
	spec: {
		endpoints: [{
			bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
			honorLabels:     true
			honorTimestamps: false
			interval:        "60s"
			path:            "/metrics/cadvisor"
			port:            "https-metrics"
			relabelings: [{
				sourceLabels: ["__metrics_path__"]
				targetLabel: "metrics_path"
			}, {
				action:      "replace"
				targetLabel: "job"
				replacement: "integrations/kubernetes/cadvisor"
			}]
			scheme: "https"
			tlsConfig: insecureSkipVerify: true
		}]
		namespaceSelector: matchNames: ["grafana-agent-operator"]
		selector: matchLabels: "app.kubernetes.io/name": "kubelet"
	}
}, {
	metadata: name: "\(#Name)-kube-state-metrics"
	spec: {
		endpoints: [{
			honorLabels: true
			interval:    "60s"
			metricRelabelings: [{
				action: "keep"
				regex:  "kube_node_status_allocatable|namespace_memory:kube_pod_container_resource_limits:sum|kube_pod_info|kube_statefulset_status_observed_generation|kube_statefulset_status_replicas_updated|kube_daemonset_status_desired_number_scheduled|container_network_transmit_packets_dropped_total|node_namespace_pod_container:container_memory_rss|container_network_receive_packets_total|volume_manager_total_volumes|kube_pod_status_reason|kube_pod_container_resource_requests|kubelet_cgroup_manager_duration_seconds_bucket|storage_operation_errors_total|kubelet_pleg_relist_interval_seconds_bucket|container_memory_cache|kube_job_failed|kubelet_certificate_manager_server_ttl_seconds|container_fs_reads_total|kube_resourcequota|node_filesystem_avail_bytes|kube_horizontalpodautoscaler_status_current_replicas|kube_horizontalpodautoscaler_status_desired_replicas|cluster:namespace:pod_cpu:active:kube_pod_container_resource_limits|kubelet_running_pods|kubelet_cgroup_manager_duration_seconds_count|kube_deployment_spec_replicas|kube_pod_container_resource_limits|kubelet_running_pod_count|node_namespace_pod_container:container_memory_swap|kube_statefulset_metadata_generation|kubelet_running_containers|node_namespace_pod_container:container_memory_cache|container_cpu_cfs_throttled_periods_total|process_resident_memory_bytes|kube_daemonset_status_current_number_scheduled|namespace_cpu:kube_pod_container_resource_limits:sum|kubelet_pod_worker_duration_seconds_count|kubelet_pod_worker_duration_seconds_bucket|kube_deployment_metadata_generation|kube_deployment_status_observed_generation|kubelet_runtime_operations_errors_total|rest_client_requests_total|node_filesystem_size_bytes|container_network_transmit_packets_total|container_network_receive_bytes_total|cluster:namespace:pod_memory:active:kube_pod_container_resource_limits|kube_replicaset_owner|namespace_cpu:kube_pod_container_resource_requests:sum|cluster:namespace:pod_cpu:active:kube_pod_container_resource_requests|kubelet_runtime_operations_total|kube_daemonset_status_updated_number_scheduled|kube_node_status_condition|machine_memory_bytes|container_memory_working_set_bytes|kube_namespace_status_phase|kube_daemonset_status_number_available|kubelet_certificate_manager_client_ttl_seconds|container_memory_swap|kube_deployment_status_replicas_updated|container_cpu_usage_seconds_total|kubelet_running_container_count|kubelet_node_config_error|kubelet_volume_stats_available_bytes|kube_persistentvolumeclaim_resource_requests_storage_bytes|kube_horizontalpodautoscaler_spec_max_replicas|kubelet_volume_stats_inodes_used|kubelet_certificate_manager_client_expiration_renew_errors|node_quantile:kubelet_pleg_relist_duration_seconds:histogram_quantile|container_fs_writes_bytes_total|kube_deployment_status_replicas_available|kube_pod_owner|container_network_receive_packets_dropped_total|namespace_memory:kube_pod_container_resource_requests:sum|kubelet_pod_start_duration_seconds_count|kube_daemonset_status_number_misscheduled|container_fs_reads_bytes_total|process_cpu_seconds_total|kubelet_pleg_relist_duration_seconds_count|go_goroutines|kube_statefulset_status_update_revision|kubelet_volume_stats_capacity_bytes|kube_job_status_start_time|kubelet_server_expiration_renew_errors|kubelet_pleg_relist_duration_seconds_bucket|kube_statefulset_status_replicas_ready|kube_statefulset_status_current_revision|container_memory_rss|node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate|storage_operation_duration_seconds_count|namespace_workload_pod|kube_node_info|container_fs_writes_total|container_network_transmit_bytes_total|kube_node_status_capacity|kube_node_spec_taint|kubelet_volume_stats_inodes|kube_horizontalpodautoscaler_spec_min_replicas|kube_statefulset_status_replicas|namespace_workload_pod:kube_pod_owner:relabel|node_namespace_pod_container:container_memory_working_set_bytes|container_cpu_cfs_periods_total|kubelet_node_name|kubelet_pod_start_duration_seconds_bucket|kubernetes_build_info|cluster:namespace:pod_memory:active:kube_pod_container_resource_requests|kube_job_status_active|kube_pod_status_phase|kube_statefulset_replicas|kube_pod_container_status_waiting_reason|kube_namespace_status_phase|container_cpu_usage_seconds_total|kube_pod_status_phase|kube_pod_start_time|kube_pod_container_status_restarts_total|kube_pod_container_info|kube_pod_container_status_waiting_reason|kube_daemonset.*|kube_replicaset.*|kube_statefulset.*|kube_job.*|kube_node.*|node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate|cluster:namespace:pod_cpu:active:kube_pod_container_resource_requests|namespace_cpu:kube_pod_container_resource_requests:sum|node_cpu.*|node_memory.*|node_filesystem.*"
				sourceLabels: ["__name__"]
			}]
			path: "/metrics"
			port: "http-metrics"
			relabelings: [{
				action:      "replace"
				replacement: "integrations/kubernetes/kube-state-metrics"
				targetLabel: "job"
			}]
		}]
		namespaceSelector: matchNames: ["kube-state-metrics"]
		selector: matchLabels: "app.kubernetes.io/name": "kube-state-metrics"
	}
}]

// {
//  spec: {
//   namespaceSelector: any: true
//   selector: matchLabels: {}
//  }
// },
