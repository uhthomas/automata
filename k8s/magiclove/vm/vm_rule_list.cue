package vm

import operatorv1beta1 "github.com/VictoriaMetrics/operator/api/operator/v1beta1"

#VMRuleList: operatorv1beta1.#VMRuleList & {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMRuleList"
	items: [...{
		apiVersion: "operator.victoriametrics.com/v1beta1"
		kind:       "VMRule"
	}]
}

#VMRuleList: items: [{
	metadata: name: "alertmanager.rules"
	spec: groups: [{
		name: "alertmanager.rules"
		rules: [{
			alert: "AlertmanagerFailedReload"
			annotations: {
				description: "Configuration has failed to load for {{ $labels.namespace }}/{{ $labels.pod}}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/alertmanager/alertmanagerfailedreload"
				summary:     "Reloading an Alertmanager configuration has failed."
			}
			expr: "max_over_time(alertmanager_config_last_reload_successful{job=\"vmalertmanager-vm\",container=\"alertmanager\",namespace=\"vm\"}[5m]) == 0"
			for:  "10m"
			labels: severity: "critical"
		}, {
			alert: "AlertmanagerMembersInconsistent"
			annotations: {
				description: "Alertmanager {{ $labels.namespace }}/{{ $labels.pod}} has only found {{ $value }} members of the {{$labels.job}} cluster."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/alertmanager/alertmanagermembersinconsistent"
				summary:     "A member of an Alertmanager cluster has not found all other cluster members."
			}
			expr: "max_over_time(alertmanager_cluster_members{job=\"vmalertmanager-vm\",container=\"alertmanager\",namespace=\"vm\"}[5m]) < on(namespace,service,cluster) group_left() count(max_over_time(alertmanager_cluster_members{job=\"vmalertmanager-vm\",container=\"alertmanager\",namespace=\"vm\"}[5m])) by(namespace,service,cluster)"
			for:  "15m"
			labels: severity: "critical"
		}, {
			alert: "AlertmanagerFailedToSendAlerts"
			annotations: {
				description: "Alertmanager {{ $labels.namespace }}/{{ $labels.pod}} failed to send {{ $value | humanizePercentage }} of notifications to {{ $labels.integration }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/alertmanager/alertmanagerfailedtosendalerts"
				summary:     "An Alertmanager instance failed to send notifications."
			}
			expr: "(rate(alertmanager_notifications_failed_total{job=\"vmalertmanager-vm\",container=\"alertmanager\",namespace=\"vm\"}[15m]) / ignoring(reason) group_left() rate(alertmanager_notifications_total{job=\"vmalertmanager-vm\",container=\"alertmanager\",namespace=\"vm\"}[15m])) > 0.01"
			for:  "5m"
			labels: severity: "warning"
		}, {
			alert: "AlertmanagerClusterFailedToSendAlerts"
			annotations: {
				description: "The minimum notification failure rate to {{ $labels.integration }} sent from any instance in the {{$labels.job}} cluster is {{ $value | humanizePercentage }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/alertmanager/alertmanagerclusterfailedtosendalerts"
				summary:     "All Alertmanager instances in a cluster failed to send notifications to a critical integration."
			}
			expr: "min((rate(alertmanager_notifications_failed_total{job=\"vmalertmanager-vm\",container=\"alertmanager\",namespace=\"vm\",integration=~\".*\"}[15m]) / ignoring(reason) group_left() rate(alertmanager_notifications_total{job=\"vmalertmanager-vm\",container=\"alertmanager\",namespace=\"vm\",integration=~\".*\"}[15m])) > 0) by(namespace,service,integration,cluster) > 0.01"
			for:  "5m"
			labels: severity: "critical"
		}, {
			alert: "AlertmanagerClusterFailedToSendAlerts"
			annotations: {
				description: "The minimum notification failure rate to {{ $labels.integration }} sent from any instance in the {{$labels.job}} cluster is {{ $value | humanizePercentage }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/alertmanager/alertmanagerclusterfailedtosendalerts"
				summary:     "All Alertmanager instances in a cluster failed to send notifications to a non-critical integration."
			}
			expr: "min((rate(alertmanager_notifications_failed_total{job=\"vmalertmanager-vm\",container=\"alertmanager\",namespace=\"vm\",integration!~\".*\"}[15m]) / ignoring(reason) group_left() rate(alertmanager_notifications_total{job=\"vmalertmanager-vm\",container=\"alertmanager\",namespace=\"vm\",integration!~\".*\"}[15m])) > 0) by(namespace,service,integration,cluster) > 0.01"
			for:  "5m"
			labels: severity: "warning"
		}, {
			alert: "AlertmanagerConfigInconsistent"
			annotations: {
				description: "Alertmanager instances within the {{$labels.job}} cluster have different configurations."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/alertmanager/alertmanagerconfiginconsistent"
				summary:     "Alertmanager instances within the same cluster have different configurations."
			}
			expr: "count(count_values(\"config_hash\", alertmanager_config_hash{job=\"vmalertmanager-vm\",container=\"alertmanager\",namespace=\"vm\"}) by(namespace,service,cluster)) by(namespace,service,cluster) != 1"
			for:  "20m"
			labels: severity: "critical"
		}, {
			alert: "AlertmanagerClusterDown"
			annotations: {
				description: "{{ $value | humanizePercentage }} of Alertmanager instances within the {{$labels.job}} cluster have been up for less than half of the last 5m."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/alertmanager/alertmanagerclusterdown"
				summary:     "Half or more of the Alertmanager instances within the same cluster are down."
			}
			expr: "(count(avg_over_time(up{job=\"vmalertmanager-vm\",container=\"alertmanager\",namespace=\"vm\"}[5m]) < 0.5) by(namespace,service,cluster) / count(up{job=\"vmalertmanager-vm\",container=\"alertmanager\",namespace=\"vm\"}) by(namespace,service,cluster)) >= 0.5"
			for:  "5m"
			labels: severity: "critical"
		}, {
			alert: "AlertmanagerClusterCrashlooping"
			annotations: {
				description: "{{ $value | humanizePercentage }} of Alertmanager instances within the {{$labels.job}} cluster have restarted at least 5 times in the last 10m."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/alertmanager/alertmanagerclustercrashlooping"
				summary:     "Half or more of the Alertmanager instances within the same cluster are crashlooping."
			}
			expr: "(count(changes(process_start_time_seconds{job=\"vmalertmanager-vm\",container=\"alertmanager\",namespace=\"vm\"}[10m]) > 4) by(namespace,service,cluster) / count(up{job=\"vmalertmanager-vm\",container=\"alertmanager\",namespace=\"vm\"}) by(namespace,service,cluster)) >= 0.5"
			for:  "5m"
			labels: severity: "critical"
		}]
	}]
}, {
	metadata: name: "etcd"
	spec: groups: [{
		name: "etcd"
		rules: [{
			alert: "etcdMembersDown"
			annotations: {
				description: "etcd cluster \"{{ $labels.job }}\": members are down ({{ $value }})."
				summary:     "etcd cluster members are down."
			}
			expr: "max(sum(up{job=~\".*etcd.*\"} ==bool 0) without(instance) or count(sum(rate(etcd_network_peer_sent_failures_total{job=~\".*etcd.*\"}[120s])) without(instance) > 0.01) without(To)) without(endpoint) > 0"
		}, {
			alert: "etcdInsufficientMembers"
			annotations: {
				description: "etcd cluster \"{{ $labels.job }}\": insufficient members ({{ $value }})."
				summary:     "etcd cluster has insufficient number of members."
			}
			expr: "sum(up{job=~\".*etcd.*\"} ==bool 1) without(instance) < ((count(up{job=~\".*etcd.*\"}) without(instance) + 1) / 2)"
		}, {
			alert: "etcdNoLeader"
			annotations: {
				description: "etcd cluster \"{{ $labels.job }}\": member {{ $labels.instance }} has no leader."
				summary:     "etcd cluster has no leader."
			}
			expr: "etcd_server_has_leader{job=~\".*etcd.*\"} == 0"
		}, {
			alert: "etcdHighNumberOfLeaderChanges"
			annotations: {
				description: "etcd cluster \"{{ $labels.job }}\": {{ $value }} leader changes within the last 15 minutes. Frequent elections may be a sign of insufficient resources, high network latency, or disruptions by other components and should be investigated."
				summary:     "etcd cluster has high number of leader changes."
			}
			expr: "increase((max(etcd_server_leader_changes_seen_total{job=~\".*etcd.*\"}) without(instance) or (0 * absent(etcd_server_leader_changes_seen_total{job=~\".*etcd.*\"})))[15m:1m]) >= 4"
		}, {
			alert: "etcdHighNumberOfFailedGRPCRequests"
			annotations: {
				description: "etcd cluster \"{{ $labels.job }}\": {{ $value }}% of requests for {{ $labels.grpc_method }} failed on etcd instance {{ $labels.instance }}."
				summary:     "etcd cluster has high number of failed grpc requests."
			}
			expr: "((100 * sum(rate(grpc_server_handled_total{job=~\".*etcd.*\",grpc_code=~\"Unknown|FailedPrecondition|ResourceExhausted|Internal|Unavailable|DataLoss|DeadlineExceeded\"}[5m])) without(grpc_type,grpc_code)) / sum(rate(grpc_server_handled_total{job=~\".*etcd.*\"}[5m])) without(grpc_type,grpc_code)) > 1"
		}, {
			alert: "etcdHighNumberOfFailedGRPCRequests"
			annotations: {
				description: "etcd cluster \"{{ $labels.job }}\": {{ $value }}% of requests for {{ $labels.grpc_method }} failed on etcd instance {{ $labels.instance }}."
				summary:     "etcd cluster has high number of failed grpc requests."
			}
			expr: "((100 * sum(rate(grpc_server_handled_total{job=~\".*etcd.*\",grpc_code=~\"Unknown|FailedPrecondition|ResourceExhausted|Internal|Unavailable|DataLoss|DeadlineExceeded\"}[5m])) without(grpc_type,grpc_code)) / sum(rate(grpc_server_handled_total{job=~\".*etcd.*\"}[5m])) without(grpc_type,grpc_code)) > 5"
		}, {
			alert: "etcdGRPCRequestsSlow"
			annotations: {
				description: "etcd cluster \"{{ $labels.job }}\": 99th percentile of gRPC requests is {{ $value }}s on etcd instance {{ $labels.instance }} for {{ $labels.grpc_method }} method."
				summary:     "etcd grpc requests are slow"
			}
			expr: "histogram_quantile(0.99, sum(rate(grpc_server_handling_seconds_bucket{job=~\".*etcd.*\",grpc_method!=\"Defragment\",grpc_type=\"unary\"}[5m])) without(grpc_type)) > 0.15"
		}, {
			alert: "etcdMemberCommunicationSlow"
			annotations: {
				description: "etcd cluster \"{{ $labels.job }}\": member communication with {{ $labels.To }} is taking {{ $value }}s on etcd instance {{ $labels.instance }}."
				summary:     "etcd cluster member communication is slow."
			}
			expr: "histogram_quantile(0.99, rate(etcd_network_peer_round_trip_time_seconds_bucket{job=~\".*etcd.*\"}[5m])) > 0.15"
		}, {
			alert: "etcdHighNumberOfFailedProposals"
			annotations: {
				description: "etcd cluster \"{{ $labels.job }}\": {{ $value }} proposal failures within the last 30 minutes on etcd instance {{ $labels.instance }}."
				summary:     "etcd cluster has high number of proposal failures."
			}
			expr: "rate(etcd_server_proposals_failed_total{job=~\".*etcd.*\"}[15m]) > 5"
		}, {
			alert: "etcdHighFsyncDurations"
			annotations: {
				description: "etcd cluster \"{{ $labels.job }}\": 99th percentile fsync durations are {{ $value }}s on etcd instance {{ $labels.instance }}."
				summary:     "etcd cluster 99th percentile fsync durations are too high."
			}
			expr: "histogram_quantile(0.99, rate(etcd_disk_wal_fsync_duration_seconds_bucket{job=~\".*etcd.*\"}[5m])) > 0.5"
		}, {
			alert: "etcdHighFsyncDurations"
			annotations: {
				description: "etcd cluster \"{{ $labels.job }}\": 99th percentile fsync durations are {{ $value }}s on etcd instance {{ $labels.instance }}."
				summary:     "etcd cluster 99th percentile fsync durations are too high."
			}
			expr: "histogram_quantile(0.99, rate(etcd_disk_wal_fsync_duration_seconds_bucket{job=~\".*etcd.*\"}[5m])) > 1"
		}, {
			alert: "etcdHighCommitDurations"
			annotations: {
				description: "etcd cluster \"{{ $labels.job }}\": 99th percentile commit durations {{ $value }}s on etcd instance {{ $labels.instance }}."
				summary:     "etcd cluster 99th percentile commit durations are too high."
			}
			expr: "histogram_quantile(0.99, rate(etcd_disk_backend_commit_duration_seconds_bucket{job=~\".*etcd.*\"}[5m])) > 0.25"
		}, {
			alert: "etcdDatabaseQuotaLowSpace"
			annotations: {
				description: "etcd cluster \"{{ $labels.job }}\": database size exceeds the defined quota on etcd instance {{ $labels.instance }}, please defrag or increase the quota as the writes to etcd will be disabled when it is full."
				summary:     "etcd cluster database is running full."
			}
			expr: "((last_over_time(etcd_mvcc_db_total_size_in_bytes{job=~\".*etcd.*\"}[5m]) / last_over_time(etcd_server_quota_backend_bytes{job=~\".*etcd.*\"}[5m])) * 100) > 95"
		}, {
			alert: "etcdExcessiveDatabaseGrowth"
			annotations: {
				description: "etcd cluster \"{{ $labels.job }}\": Predicting running out of disk space in the next four hours, based on write observations within the past four hours on etcd instance {{ $labels.instance }}, please check as it might be disruptive."
				summary:     "etcd cluster database growing very fast."
			}
			expr: "predict_linear(etcd_mvcc_db_total_size_in_bytes{job=~\".*etcd.*\"}[4h], 14400) > etcd_server_quota_backend_bytes{job=~\".*etcd.*\"}"
		}, {
			alert: "etcdDatabaseHighFragmentationRatio"
			annotations: {
				description: "etcd cluster \"{{ $labels.job }}\": database size in use on instance {{ $labels.instance }} is {{ $value | humanizePercentage }} of the actual allocated disk space, please run defragmentation (e.g. etcdctl defrag) to retrieve the unused fragmented disk space."
				runbook_url: "https://etcd.io/docs/v3.5/op-guide/maintenance/#defragmentation"
				summary:     "etcd database size in use is less than 50% of the actual allocated storage."
			}
			expr: "((last_over_time(etcd_mvcc_db_total_size_in_use_in_bytes{job=~\".*etcd.*\"}[5m]) / last_over_time(etcd_mvcc_db_total_size_in_bytes{job=~\".*etcd.*\"}[5m])) < 0.5) and (etcd_mvcc_db_total_size_in_use_in_bytes{job=~\".*etcd.*\"} > 104857600)"
		}]
	}]
}, {
	metadata: name: "general.rules"
	spec: groups: [{
		name: "general.rules"
		rules: [{
			alert: "TargetDown"
			annotations: {
				description: "{{ printf \"%.4g\" $value }}% of the {{ $labels.job }}/{{ $labels.service }} targets in {{ $labels.namespace }} namespace are down."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/general/targetdown"
				summary:     "One or more targets are unreachable."
			}
			expr: "(100 * (count(up == 0) by(cluster,job,namespace,service) / count(up) by(cluster,job,namespace,service))) > 10"
			for:  "10m"
			labels: severity: "warning"
		}, {
			alert: "Watchdog"
			annotations: {
				description: """
					This is an alert meant to ensure that the entire alerting pipeline is functional.
					This alert is always firing, therefore it should always be firing in Alertmanager
					and always fire against a receiver. There are integrations with various notification
					mechanisms that send a notification when this alert is not firing. For example the
					"DeadMansSnitch" integration in PagerDuty.

					"""
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/general/watchdog"
				summary:     "An alert that should always be firing to certify that Alertmanager is working properly."
			}
			expr: "vector(1)"
			labels: severity: "none"
		}, {
			alert: "InfoInhibitor"
			annotations: {
				description: """
					This is an alert that is used to inhibit info alerts.
					By themselves, the info-level alerts are sometimes very noisy, but they are relevant when combined with
					other alerts.
					This alert fires whenever there's a severity="info" alert, and stops firing when another alert with a
					severity of 'warning' or 'critical' starts firing on the same namespace.
					This alert should be routed to a null receiver and configured to inhibit alerts with severity="info".

					"""
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/general/infoinhibitor"
				summary:     "Info-level alert inhibition."
			}
			expr: "group(ALERTS{severity=\"info\"} == 1) by(namespace,cluster) unless on(namespace,cluster) group(ALERTS{alertname!=\"InfoInhibitor\",alertstate=\"firing\",severity=~\"warning|critical\"} == 1) by(namespace,cluster)"
			labels: severity: "none"
		}]
	}]
}, {
	metadata: name: "k8s.rules.containercpulimits"
	spec: groups: [{
		name: "k8s.rules.container_cpu_limits"
		rules: [{
			expr: "kube_pod_container_resource_limits{resource=\"cpu\",job=\"kube-state-metrics\"} * on(namespace,pod,cluster) group_left() max(kube_pod_status_phase{phase=~\"Pending|Running\"} == 1) by(namespace,pod,cluster)"
			record: "cluster:namespace:pod_cpu:active:kube_pod_container_resource_limits"
		}, {
			expr: "sum(sum(max(kube_pod_container_resource_limits{resource=\"cpu\",job=\"kube-state-metrics\"}) by(namespace,pod,container,cluster) * on(namespace,pod,cluster) group_left() max(kube_pod_status_phase{phase=~\"Pending|Running\"} == 1) by(namespace,pod,cluster)) by(namespace,pod,cluster)) by(namespace,cluster)"
			record: "namespace_cpu:kube_pod_container_resource_limits:sum"
		}]
	}]
}, {
	metadata: name: "k8s.rules.containercpurequests"
	spec: groups: [{
		name: "k8s.rules.container_cpu_requests"
		rules: [{
			expr: "kube_pod_container_resource_requests{resource=\"cpu\",job=\"kube-state-metrics\"} * on(namespace,pod,cluster) group_left() max(kube_pod_status_phase{phase=~\"Pending|Running\"} == 1) by(namespace,pod,cluster)"
			record: "cluster:namespace:pod_cpu:active:kube_pod_container_resource_requests"
		}, {
			expr: "sum(sum(max(kube_pod_container_resource_requests{resource=\"cpu\",job=\"kube-state-metrics\"}) by(namespace,pod,container,cluster) * on(namespace,pod,cluster) group_left() max(kube_pod_status_phase{phase=~\"Pending|Running\"} == 1) by(namespace,pod,cluster)) by(namespace,pod,cluster)) by(namespace,cluster)"
			record: "namespace_cpu:kube_pod_container_resource_requests:sum"
		}]
	}]
}, {
	metadata: name: "k8s.rules.containercpuusagesecondstotal"
	spec: groups: [{
		name: "k8s.rules.container_cpu_usage_seconds_total"
		rules: [{
			expr: "sum(rate(container_cpu_usage_seconds_total{job=\"kubelet\",metrics_path=\"/metrics/cadvisor\",image!=\"\"}[5m])) by(cluster,namespace,pod,container) * on(cluster,namespace,pod) group_left(node) topk(1, max(kube_pod_info{node!=\"\"}) by(cluster,namespace,pod,node)) by(cluster,namespace,pod)"
			record: "node_namespace_pod_container:container_cpu_usage_seconds_total:sum_rate5m"
		}, {
			expr: "sum(irate(container_cpu_usage_seconds_total{job=\"kubelet\",metrics_path=\"/metrics/cadvisor\",image!=\"\"}[5m])) by(cluster,namespace,pod,container) * on(cluster,namespace,pod) group_left(node) topk(1, max(kube_pod_info{node!=\"\"}) by(cluster,namespace,pod,node)) by(cluster,namespace,pod)"
			record: "node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate"
		}]
	}]
}, {
	metadata: name: "k8s.rules.containermemorycache"
	spec: groups: [{
		name: "k8s.rules.container_memory_cache"
		rules: [{
			expr: "container_memory_cache{job=\"kubelet\",metrics_path=\"/metrics/cadvisor\",image!=\"\"} * on(cluster,namespace,pod) group_left(node) topk(1, max(kube_pod_info{node!=\"\"}) by(cluster,namespace,pod,node)) by(cluster,namespace,pod)"
			record: "node_namespace_pod_container:container_memory_cache"
		}]
	}]
}, {
	metadata: name: "k8s.rules.containermemorylimits"
	spec: groups: [{
		name: "k8s.rules.container_memory_limits"
		rules: [{
			expr: "kube_pod_container_resource_limits{resource=\"memory\",job=\"kube-state-metrics\"} * on(namespace,pod,cluster) group_left() max(kube_pod_status_phase{phase=~\"Pending|Running\"} == 1) by(namespace,pod,cluster)"
			record: "cluster:namespace:pod_memory:active:kube_pod_container_resource_limits"
		}, {
			expr: "sum(sum(max(kube_pod_container_resource_limits{resource=\"memory\",job=\"kube-state-metrics\"}) by(namespace,pod,container,cluster) * on(namespace,pod,cluster) group_left() max(kube_pod_status_phase{phase=~\"Pending|Running\"} == 1) by(namespace,pod,cluster)) by(namespace,pod,cluster)) by(namespace,cluster)"
			record: "namespace_memory:kube_pod_container_resource_limits:sum"
		}]
	}]
}, {
	metadata: name: "k8s.rules.containermemoryrequests"
	spec: groups: [{
		name: "k8s.rules.container_memory_requests"
		rules: [{
			expr: "kube_pod_container_resource_requests{resource=\"memory\",job=\"kube-state-metrics\"} * on(namespace,pod,cluster) group_left() max(kube_pod_status_phase{phase=~\"Pending|Running\"} == 1) by(namespace,pod,cluster)"
			record: "cluster:namespace:pod_memory:active:kube_pod_container_resource_requests"
		}, {
			expr: "sum(sum(max(kube_pod_container_resource_requests{resource=\"memory\",job=\"kube-state-metrics\"}) by(namespace,pod,container,cluster) * on(namespace,pod,cluster) group_left() max(kube_pod_status_phase{phase=~\"Pending|Running\"} == 1) by(namespace,pod,cluster)) by(namespace,pod,cluster)) by(namespace,cluster)"
			record: "namespace_memory:kube_pod_container_resource_requests:sum"
		}]
	}]
}, {
	metadata: name: "k8s.rules.containermemoryrss"
	spec: groups: [{
		name: "k8s.rules.container_memory_rss"
		rules: [{
			expr: "container_memory_rss{job=\"kubelet\",metrics_path=\"/metrics/cadvisor\",image!=\"\"} * on(cluster,namespace,pod) group_left(node) topk(1, max(kube_pod_info{node!=\"\"}) by(cluster,namespace,pod,node)) by(cluster,namespace,pod)"
			record: "node_namespace_pod_container:container_memory_rss"
		}]
	}]
}, {
	metadata: name: "k8s.rules.containermemoryswap"
	spec: groups: [{
		name: "k8s.rules.container_memory_swap"
		rules: [{
			expr: "container_memory_swap{job=\"kubelet\",metrics_path=\"/metrics/cadvisor\",image!=\"\"} * on(cluster,namespace,pod) group_left(node) topk(1, max(kube_pod_info{node!=\"\"}) by(cluster,namespace,pod,node)) by(cluster,namespace,pod)"
			record: "node_namespace_pod_container:container_memory_swap"
		}]
	}]
}, {
	metadata: name: "k8s.rules.containermemoryworkingsetbytes"
	spec: groups: [{
		name: "k8s.rules.container_memory_working_set_bytes"
		rules: [{
			expr: "container_memory_working_set_bytes{job=\"kubelet\",metrics_path=\"/metrics/cadvisor\",image!=\"\"} * on(cluster,namespace,pod) group_left(node) topk(1, max(kube_pod_info{node!=\"\"}) by(cluster,namespace,pod,node)) by(cluster,namespace,pod)"
			record: "node_namespace_pod_container:container_memory_working_set_bytes"
		}]
	}]
}, {
	metadata: name: "k8s.rules.podowner"
	spec: groups: [{
		name: "k8s.rules.pod_owner"
		rules: [{
			expr: "max(label_replace(label_replace(kube_pod_owner{job=\"kube-state-metrics\",owner_kind=\"ReplicaSet\"}, \"replicaset\", \"$1\", \"owner_name\", \"(.*)\") * on(cluster,replicaset,namespace) group_left(owner_name) topk(1, max(kube_replicaset_owner{job=\"kube-state-metrics\",owner_kind=\"\"}) by(cluster,replicaset,namespace,owner_name)) by(cluster,replicaset,namespace), \"workload\", \"$1\", \"replicaset\", \"(.*)\")) by(cluster,namespace,workload,pod)"
			labels: workload_type: "replicaset"
			record: "namespace_workload_pod:kube_pod_owner:relabel"
		}, {
			expr: "max(label_replace(label_replace(kube_pod_owner{job=\"kube-state-metrics\",owner_kind=\"ReplicaSet\"}, \"replicaset\", \"$1\", \"owner_name\", \"(.*)\") * on(replicaset,namespace,cluster) group_left(owner_name) topk(1, max(kube_replicaset_owner{job=\"kube-state-metrics\",owner_kind=\"Deployment\"}) by(cluster,replicaset,namespace,owner_name)) by(cluster,replicaset,namespace), \"workload\", \"$1\", \"owner_name\", \"(.*)\")) by(cluster,namespace,workload,pod)"
			labels: workload_type: "deployment"
			record: "namespace_workload_pod:kube_pod_owner:relabel"
		}, {
			expr: "max(label_replace(kube_pod_owner{job=\"kube-state-metrics\",owner_kind=\"DaemonSet\"}, \"workload\", \"$1\", \"owner_name\", \"(.*)\")) by(cluster,namespace,workload,pod)"
			labels: workload_type: "daemonset"
			record: "namespace_workload_pod:kube_pod_owner:relabel"
		}, {
			expr: "max(label_replace(kube_pod_owner{job=\"kube-state-metrics\",owner_kind=\"StatefulSet\"}, \"workload\", \"$1\", \"owner_name\", \"(.*)\")) by(cluster,namespace,workload,pod)"
			labels: workload_type: "statefulset"
			record: "namespace_workload_pod:kube_pod_owner:relabel"
		}, {
			expr: "group(label_join(group(label_join(kube_pod_owner{job=\"kube-state-metrics\",owner_kind=\"Job\"}, \"job_name\", \"\", \"owner_name\")) by(cluster,namespace,job_name,pod,owner_name) * on(cluster,namespace,job_name) group_left() group(kube_job_owner{job=\"kube-state-metrics\",owner_kind=~\"Pod|\"}) by(cluster,namespace,job_name), \"workload\", \"\", \"owner_name\")) by(cluster,namespace,workload,pod)"
			labels: workload_type: "job"
			record: "namespace_workload_pod:kube_pod_owner:relabel"
		}, {
			expr: "max(label_replace(kube_pod_owner{job=\"kube-state-metrics\",owner_kind=\"\",owner_name=\"\"}, \"workload\", \"$1\", \"pod\", \"(.+)\")) by(cluster,namespace,workload,pod)"
			labels: workload_type: "barepod"
			record: "namespace_workload_pod:kube_pod_owner:relabel"
		}, {
			expr: "max(label_replace(kube_pod_owner{job=\"kube-state-metrics\",owner_kind=\"Node\"}, \"workload\", \"$1\", \"pod\", \"(.+)\")) by(cluster,namespace,workload,pod)"
			labels: workload_type: "staticpod"
			record: "namespace_workload_pod:kube_pod_owner:relabel"
		}, {
			expr: "group(label_join(label_join(group(label_join(kube_pod_owner{job=\"kube-state-metrics\",owner_kind=\"Job\"}, \"job_name\", \"\", \"owner_name\")) by(cluster,namespace,job_name,pod) * on(cluster,namespace,job_name) group_left(owner_kind,owner_name) group(kube_job_owner{job=\"kube-state-metrics\",owner_kind!=\"Pod\",owner_kind!=\"\"}) by(cluster,namespace,job_name,owner_kind,owner_name), \"workload\", \"\", \"owner_name\"), \"workload_type\", \"\", \"owner_kind\") or label_replace(label_replace(label_replace(kube_pod_owner{job=\"kube-state-metrics\",owner_kind=\"ReplicaSet\"}, \"replicaset\", \"$1\", \"owner_name\", \"(.+)\") * on(cluster,namespace,replicaset) group_left(owner_kind,owner_name) group(kube_replicaset_owner{job=\"kube-state-metrics\",owner_kind!=\"Deployment\",owner_kind!=\"\"}) by(cluster,namespace,replicaset,owner_kind,owner_name), \"workload\", \"$1\", \"owner_name\", \"(.+)\") or label_replace(group(kube_pod_owner{job=\"kube-state-metrics\",owner_kind!=\"ReplicaSet\",owner_kind!=\"DaemonSet\",owner_kind!=\"StatefulSet\",owner_kind!=\"Job\",owner_kind!=\"Node\",owner_kind!=\"\"}) by(cluster,namespace,pod,owner_name,owner_kind), \"workload\", \"$1\", \"owner_name\", \"(.+)\"), \"workload_type\", \"$1\", \"owner_kind\", \"(.+)\")) by(cluster,namespace,workload,workload_type,pod)"
			record: "namespace_workload_pod:kube_pod_owner:relabel"
		}]
	}]
}, {
	metadata: name: "kube-apiserver-availability.rules"
	spec: groups: [{
		interval: "3m"
		name:     "kube-apiserver-availability.rules"
		rules: [{
			expr: "(avg_over_time(code_verb:apiserver_request_total:increase1h[30d]) * 24) * 30"
			record: "code_verb:apiserver_request_total:increase30d"
		}, {
			expr: "sum(code_verb:apiserver_request_total:increase30d{verb=~\"LIST|GET\"}) by(cluster,code)"
			labels: verb: "read"
			record: "code:apiserver_request_total:increase30d"
		}, {
			expr: "sum(code_verb:apiserver_request_total:increase30d{verb=~\"POST|PUT|PATCH|DELETE\"}) by(cluster,code)"
			labels: verb: "write"
			record: "code:apiserver_request_total:increase30d"
		}, {
			expr: "sum(increase(apiserver_request_sli_duration_seconds_bucket[1h])) by(cluster,verb,scope,le)"
			record: "cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase1h"
		}, {
			expr: "sum((avg_over_time(cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase1h[30d]) * 24) * 30) by(cluster,verb,scope,le)"
			record: "cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase30d"
		}, {
			expr: "sum(cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase1h{le=\"+Inf\"}) by(cluster,verb,scope)"
			record: "cluster_verb_scope:apiserver_request_sli_duration_seconds_count:increase1h"
		}, {
			expr: "sum(cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase30d{le=\"+Inf\"}) by(cluster,verb,scope)"
			record: "cluster_verb_scope:apiserver_request_sli_duration_seconds_count:increase30d"
		}, {
			expr: "1 - ((((sum(cluster_verb_scope:apiserver_request_sli_duration_seconds_count:increase30d{verb=~\"POST|PUT|PATCH|DELETE\"}) by(cluster) - sum(cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase30d{verb=~\"POST|PUT|PATCH|DELETE\",le=~\"1(\\\\.0)?\"} or vector(0)) by(cluster)) + (sum(cluster_verb_scope:apiserver_request_sli_duration_seconds_count:increase30d{verb=~\"LIST|GET\"}) by(cluster) - ((sum(cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase30d{verb=~\"LIST|GET\",scope=~\"resource|\",le=~\"1(\\\\.0)?\"} or vector(0)) by(cluster) + sum(cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase30d{verb=~\"LIST|GET\",scope=\"namespace\",le=~\"5(\\\\.0)?\"} or vector(0)) by(cluster)) + sum(cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase30d{verb=~\"LIST|GET\",scope=\"cluster\",le=~\"30(\\\\.0)?\"} or vector(0)) by(cluster)))) + sum(code:apiserver_request_total:increase30d{code=~\"5..\"} or vector(0)) by(cluster)) / sum(code:apiserver_request_total:increase30d) by(cluster))"
			labels: verb: "all"
			record: "apiserver_request:availability30d"
		}, {
			expr: "1 - (((sum(cluster_verb_scope:apiserver_request_sli_duration_seconds_count:increase30d{verb=~\"LIST|GET\"}) by(cluster) - ((sum(cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase30d{verb=~\"LIST|GET\",scope=~\"resource|\",le=~\"1(\\\\.0)?\"} or vector(0)) by(cluster) + sum(cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase30d{verb=~\"LIST|GET\",scope=\"namespace\",le=~\"5(\\\\.0)?\"} or vector(0)) by(cluster)) + sum(cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase30d{verb=~\"LIST|GET\",scope=\"cluster\",le=~\"30(\\\\.0)?\"} or vector(0)) by(cluster))) + sum(code:apiserver_request_total:increase30d{verb=\"read\",code=~\"5..\"} or vector(0)) by(cluster)) / sum(code:apiserver_request_total:increase30d{verb=\"read\"}) by(cluster))"
			labels: verb: "read"
			record: "apiserver_request:availability30d"
		}, {
			expr: "1 - (((sum(cluster_verb_scope:apiserver_request_sli_duration_seconds_count:increase30d{verb=~\"POST|PUT|PATCH|DELETE\"}) by(cluster) - sum(cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase30d{verb=~\"POST|PUT|PATCH|DELETE\",le=~\"1(\\\\.0)?\"} or vector(0)) by(cluster)) + sum(code:apiserver_request_total:increase30d{verb=\"write\",code=~\"5..\"} or vector(0)) by(cluster)) / sum(code:apiserver_request_total:increase30d{verb=\"write\"}) by(cluster))"
			labels: verb: "write"
			record: "apiserver_request:availability30d"
		}, {
			expr: "sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\"}[5m])) by(cluster,code,resource)"
			labels: verb: "read"
			record: "code_resource:apiserver_request_total:rate5m"
		}, {
			expr: "sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[5m])) by(cluster,code,resource)"
			labels: verb: "write"
			record: "code_resource:apiserver_request_total:rate5m"
		}, {
			expr: "sum(increase(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET|POST|PUT|PATCH|DELETE\",code=~\"2..\"}[1h])) by(cluster,code,verb)"
			record: "code_verb:apiserver_request_total:increase1h"
		}, {
			expr: "sum(increase(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET|POST|PUT|PATCH|DELETE\",code=~\"3..\"}[1h])) by(cluster,code,verb)"
			record: "code_verb:apiserver_request_total:increase1h"
		}, {
			expr: "sum(increase(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET|POST|PUT|PATCH|DELETE\",code=~\"4..\"}[1h])) by(cluster,code,verb)"
			record: "code_verb:apiserver_request_total:increase1h"
		}, {
			expr: "sum(increase(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET|POST|PUT|PATCH|DELETE\",code=~\"5..\"}[1h])) by(cluster,code,verb)"
			record: "code_verb:apiserver_request_total:increase1h"
		}]
	}]
}, {
	metadata: name: "kube-apiserver-burnrate.rules"
	spec: groups: [{
		name: "kube-apiserver-burnrate.rules"
		rules: [{
			expr: "((sum(rate(apiserver_request_sli_duration_seconds_count{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\"}[1d])) by(cluster) - (((sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=~\"resource|\",le=~\"1(\\\\.0)?\"}[1d])) by(cluster) or vector(0)) + sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"namespace\",le=~\"5(\\\\.0)?\"}[1d])) by(cluster)) + sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"cluster\",le=~\"30(\\\\.0)?\"}[1d])) by(cluster))) + sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\",code=~\"5..\"}[1d])) by(cluster)) / sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\"}[1d])) by(cluster)"
			labels: verb: "read"
			record: "apiserver_request:burnrate1d"
		}, {
			expr: "((sum(rate(apiserver_request_sli_duration_seconds_count{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\"}[1h])) by(cluster) - (((sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=~\"resource|\",le=~\"1(\\\\.0)?\"}[1h])) by(cluster) or vector(0)) + sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"namespace\",le=~\"5(\\\\.0)?\"}[1h])) by(cluster)) + sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"cluster\",le=~\"30(\\\\.0)?\"}[1h])) by(cluster))) + sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\",code=~\"5..\"}[1h])) by(cluster)) / sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\"}[1h])) by(cluster)"
			labels: verb: "read"
			record: "apiserver_request:burnrate1h"
		}, {
			expr: "((sum(rate(apiserver_request_sli_duration_seconds_count{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\"}[2h])) by(cluster) - (((sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=~\"resource|\",le=~\"1(\\\\.0)?\"}[2h])) by(cluster) or vector(0)) + sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"namespace\",le=~\"5(\\\\.0)?\"}[2h])) by(cluster)) + sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"cluster\",le=~\"30(\\\\.0)?\"}[2h])) by(cluster))) + sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\",code=~\"5..\"}[2h])) by(cluster)) / sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\"}[2h])) by(cluster)"
			labels: verb: "read"
			record: "apiserver_request:burnrate2h"
		}, {
			expr: "((sum(rate(apiserver_request_sli_duration_seconds_count{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\"}[30m])) by(cluster) - (((sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=~\"resource|\",le=~\"1(\\\\.0)?\"}[30m])) by(cluster) or vector(0)) + sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"namespace\",le=~\"5(\\\\.0)?\"}[30m])) by(cluster)) + sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"cluster\",le=~\"30(\\\\.0)?\"}[30m])) by(cluster))) + sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\",code=~\"5..\"}[30m])) by(cluster)) / sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\"}[30m])) by(cluster)"
			labels: verb: "read"
			record: "apiserver_request:burnrate30m"
		}, {
			expr: "((sum(rate(apiserver_request_sli_duration_seconds_count{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\"}[3d])) by(cluster) - (((sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=~\"resource|\",le=~\"1(\\\\.0)?\"}[3d])) by(cluster) or vector(0)) + sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"namespace\",le=~\"5(\\\\.0)?\"}[3d])) by(cluster)) + sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"cluster\",le=~\"30(\\\\.0)?\"}[3d])) by(cluster))) + sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\",code=~\"5..\"}[3d])) by(cluster)) / sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\"}[3d])) by(cluster)"
			labels: verb: "read"
			record: "apiserver_request:burnrate3d"
		}, {
			expr: "((sum(rate(apiserver_request_sli_duration_seconds_count{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\"}[5m])) by(cluster) - (((sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=~\"resource|\",le=~\"1(\\\\.0)?\"}[5m])) by(cluster) or vector(0)) + sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"namespace\",le=~\"5(\\\\.0)?\"}[5m])) by(cluster)) + sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"cluster\",le=~\"30(\\\\.0)?\"}[5m])) by(cluster))) + sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\",code=~\"5..\"}[5m])) by(cluster)) / sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\"}[5m])) by(cluster)"
			labels: verb: "read"
			record: "apiserver_request:burnrate5m"
		}, {
			expr: "((sum(rate(apiserver_request_sli_duration_seconds_count{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\"}[6h])) by(cluster) - (((sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=~\"resource|\",le=~\"1(\\\\.0)?\"}[6h])) by(cluster) or vector(0)) + sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"namespace\",le=~\"5(\\\\.0)?\"}[6h])) by(cluster)) + sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"cluster\",le=~\"30(\\\\.0)?\"}[6h])) by(cluster))) + sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\",code=~\"5..\"}[6h])) by(cluster)) / sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\"}[6h])) by(cluster)"
			labels: verb: "read"
			record: "apiserver_request:burnrate6h"
		}, {
			expr: "((sum(rate(apiserver_request_sli_duration_seconds_count{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\"}[1d])) by(cluster) - sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\",le=~\"1(\\\\.0)?\"}[1d])) by(cluster)) + sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",code=~\"5..\"}[1d])) by(cluster)) / sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[1d])) by(cluster)"
			labels: verb: "write"
			record: "apiserver_request:burnrate1d"
		}, {
			expr: "((sum(rate(apiserver_request_sli_duration_seconds_count{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\"}[1h])) by(cluster) - sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\",le=~\"1(\\\\.0)?\"}[1h])) by(cluster)) + sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",code=~\"5..\"}[1h])) by(cluster)) / sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[1h])) by(cluster)"
			labels: verb: "write"
			record: "apiserver_request:burnrate1h"
		}, {
			expr: "((sum(rate(apiserver_request_sli_duration_seconds_count{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\"}[2h])) by(cluster) - sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\",le=~\"1(\\\\.0)?\"}[2h])) by(cluster)) + sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",code=~\"5..\"}[2h])) by(cluster)) / sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[2h])) by(cluster)"
			labels: verb: "write"
			record: "apiserver_request:burnrate2h"
		}, {
			expr: "((sum(rate(apiserver_request_sli_duration_seconds_count{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\"}[30m])) by(cluster) - sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\",le=~\"1(\\\\.0)?\"}[30m])) by(cluster)) + sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",code=~\"5..\"}[30m])) by(cluster)) / sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[30m])) by(cluster)"
			labels: verb: "write"
			record: "apiserver_request:burnrate30m"
		}, {
			expr: "((sum(rate(apiserver_request_sli_duration_seconds_count{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\"}[3d])) by(cluster) - sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\",le=~\"1(\\\\.0)?\"}[3d])) by(cluster)) + sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",code=~\"5..\"}[3d])) by(cluster)) / sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[3d])) by(cluster)"
			labels: verb: "write"
			record: "apiserver_request:burnrate3d"
		}, {
			expr: "((sum(rate(apiserver_request_sli_duration_seconds_count{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\"}[5m])) by(cluster) - sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\",le=~\"1(\\\\.0)?\"}[5m])) by(cluster)) + sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",code=~\"5..\"}[5m])) by(cluster)) / sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[5m])) by(cluster)"
			labels: verb: "write"
			record: "apiserver_request:burnrate5m"
		}, {
			expr: "((sum(rate(apiserver_request_sli_duration_seconds_count{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\"}[6h])) by(cluster) - sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\",le=~\"1(\\\\.0)?\"}[6h])) by(cluster)) + sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",code=~\"5..\"}[6h])) by(cluster)) / sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[6h])) by(cluster)"
			labels: verb: "write"
			record: "apiserver_request:burnrate6h"
		}]
	}]
}, {
	metadata: name: "kube-apiserver-histogram.rules"
	spec: groups: [{
		name: "kube-apiserver-histogram.rules"
		rules: [{
			expr: "histogram_quantile(0.99, sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\"}[5m])) by(cluster,le,resource)) > 0"
			labels: {
				quantile: "0.99"
				verb:     "read"
			}
			record: "cluster_quantile:apiserver_request_sli_duration_seconds:histogram_quantile"
		}, {
			expr: "histogram_quantile(0.99, sum(rate(apiserver_request_sli_duration_seconds_bucket{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\"}[5m])) by(cluster,le,resource)) > 0"
			labels: {
				quantile: "0.99"
				verb:     "write"
			}
			record: "cluster_quantile:apiserver_request_sli_duration_seconds:histogram_quantile"
		}]
	}]
}, {
	metadata: name: "kube-apiserver-slos"
	spec: groups: [{
		name: "kube-apiserver-slos"
		rules: [{
			alert: "KubeAPIErrorBudgetBurn"
			annotations: {
				description: "The API server is burning too much error budget on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeapierrorbudgetburn"
				summary:     "The API server is burning too much error budget."
			}
			expr: "(sum(apiserver_request:burnrate1h) by(cluster) > 0.14400000000000002) and on(cluster) (sum(apiserver_request:burnrate5m) by(cluster) > 0.14400000000000002)"
			for:  "2m"
			labels: {
				long:     "1h"
				severity: "critical"
				short:    "5m"
			}
		}, {
			alert: "KubeAPIErrorBudgetBurn"
			annotations: {
				description: "The API server is burning too much error budget on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeapierrorbudgetburn"
				summary:     "The API server is burning too much error budget."
			}
			expr: "(sum(apiserver_request:burnrate6h) by(cluster) > 0.06) and on(cluster) (sum(apiserver_request:burnrate30m) by(cluster) > 0.06)"
			for:  "15m"
			labels: {
				long:     "6h"
				severity: "critical"
				short:    "30m"
			}
		}, {
			alert: "KubeAPIErrorBudgetBurn"
			annotations: {
				description: "The API server is burning too much error budget on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeapierrorbudgetburn"
				summary:     "The API server is burning too much error budget."
			}
			expr: "(sum(apiserver_request:burnrate1d) by(cluster) > 0.03) and on(cluster) (sum(apiserver_request:burnrate2h) by(cluster) > 0.03)"
			for:  "1h"
			labels: {
				long:     "1d"
				severity: "warning"
				short:    "2h"
			}
		}, {
			alert: "KubeAPIErrorBudgetBurn"
			annotations: {
				description: "The API server is burning too much error budget on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeapierrorbudgetburn"
				summary:     "The API server is burning too much error budget."
			}
			expr: "(sum(apiserver_request:burnrate3d) by(cluster) > 0.01) and on(cluster) (sum(apiserver_request:burnrate6h) by(cluster) > 0.01)"
			for:  "3h"
			labels: {
				long:     "3d"
				severity: "warning"
				short:    "6h"
			}
		}]
	}]
}, {
	metadata: name: "kube-prometheus-node-recording.rules"
	spec: groups: [{
		name: "kube-prometheus-node-recording.rules"
		rules: [{
			expr: "sum(rate(node_cpu_seconds_total{mode!=\"idle\",mode!=\"iowait\",mode!=\"steal\"}[3m])) by(instance,cluster)"
			record: "instance:node_cpu:rate:sum"
		}, {
			expr: "sum(rate(node_network_receive_bytes_total[3m])) by(instance,cluster)"
			record: "instance:node_network_receive_bytes:rate:sum"
		}, {
			expr: "sum(rate(node_network_transmit_bytes_total[3m])) by(instance,cluster)"
			record: "instance:node_network_transmit_bytes:rate:sum"
		}, {
			expr: "sum(rate(node_cpu_seconds_total{mode!=\"idle\",mode!=\"iowait\",mode!=\"steal\"}[5m])) without(cpu,mode) / on(instance,cluster) group_left() count(sum(node_cpu_seconds_total) by(instance,cpu,cluster)) by(instance,cluster)"
			record: "instance:node_cpu:ratio"
		}, {
			expr: "sum(rate(node_cpu_seconds_total{mode!=\"idle\",mode!=\"iowait\",mode!=\"steal\"}[5m])) by(cluster)"
			record: "cluster:node_cpu:sum_rate5m"
		}, {
			expr: "cluster:node_cpu:sum_rate5m / count(sum(node_cpu_seconds_total) by(instance,cpu,cluster)) by(cluster)"
			record: "cluster:node_cpu:ratio"
		}]
	}]
}, {
	metadata: name: "kube-scheduler.rules"
	spec: groups: [{
		name: "kube-scheduler.rules"
		rules: [{
			expr: "histogram_quantile(0.99, sum(rate(scheduler_scheduling_attempt_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance,pod))"
			labels: quantile: "0.99"
			record: "cluster_quantile:scheduler_scheduling_attempt_duration_seconds:histogram_quantile"
		}, {
			expr: "histogram_quantile(0.99, sum(rate(scheduler_pod_scheduling_sli_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance,pod))"
			labels: quantile: "0.99"
			record: "cluster_quantile:scheduler_pod_scheduling_sli_duration_seconds:histogram_quantile"
		}, {
			expr: "histogram_quantile(0.9, sum(rate(scheduler_scheduling_attempt_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance,pod))"
			labels: quantile: "0.9"
			record: "cluster_quantile:scheduler_scheduling_attempt_duration_seconds:histogram_quantile"
		}, {
			expr: "histogram_quantile(0.9, sum(rate(scheduler_pod_scheduling_sli_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance,pod))"
			labels: quantile: "0.9"
			record: "cluster_quantile:scheduler_pod_scheduling_sli_duration_seconds:histogram_quantile"
		}, {
			expr: "histogram_quantile(0.5, sum(rate(scheduler_scheduling_attempt_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance,pod))"
			labels: quantile: "0.5"
			record: "cluster_quantile:scheduler_scheduling_attempt_duration_seconds:histogram_quantile"
		}, {
			expr: "histogram_quantile(0.5, sum(rate(scheduler_pod_scheduling_sli_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance,pod))"
			labels: quantile: "0.5"
			record: "cluster_quantile:scheduler_pod_scheduling_sli_duration_seconds:histogram_quantile"
		}]
	}]
}, {
	metadata: name: "kubelet.rules"
	spec: groups: [{
		name: "kubelet.rules"
		rules: [{
			expr: "histogram_quantile(0.99, sum(rate(kubelet_pleg_relist_duration_seconds_bucket{job=\"kubelet\",metrics_path=\"/metrics\"}[5m])) by(cluster,instance,le) * on(cluster,instance) group_left(node) max(kubelet_node_name{job=\"kubelet\",metrics_path=\"/metrics\"}) by(cluster,instance,node))"
			labels: quantile: "0.99"
			record: "node_quantile:kubelet_pleg_relist_duration_seconds:histogram_quantile"
		}, {
			expr: "histogram_quantile(0.9, sum(rate(kubelet_pleg_relist_duration_seconds_bucket{job=\"kubelet\",metrics_path=\"/metrics\"}[5m])) by(cluster,instance,le) * on(cluster,instance) group_left(node) max(kubelet_node_name{job=\"kubelet\",metrics_path=\"/metrics\"}) by(cluster,instance,node))"
			labels: quantile: "0.9"
			record: "node_quantile:kubelet_pleg_relist_duration_seconds:histogram_quantile"
		}, {
			expr: "histogram_quantile(0.5, sum(rate(kubelet_pleg_relist_duration_seconds_bucket{job=\"kubelet\",metrics_path=\"/metrics\"}[5m])) by(cluster,instance,le) * on(cluster,instance) group_left(node) max(kubelet_node_name{job=\"kubelet\",metrics_path=\"/metrics\"}) by(cluster,instance,node))"
			labels: quantile: "0.5"
			record: "node_quantile:kubelet_pleg_relist_duration_seconds:histogram_quantile"
		}]
	}]
}, {
	metadata: name: "kubernetes-apps"
	spec: groups: [{
		name: "kubernetes-apps"
		rules: [{
			alert: "KubePodCrashLooping"
			annotations: {
				description: "Pod {{ $labels.namespace }}/{{ $labels.pod }} ({{ $labels.container }}) is in waiting state (reason: \"CrashLoopBackOff\") on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepodcrashlooping"
				summary:     "Pod is crash looping."
			}
			expr: "max_over_time(kube_pod_container_status_waiting_reason{reason=\"CrashLoopBackOff\",namespace=~\".*\",job=\"kube-state-metrics\"}[5m]) >= 1"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubePodNotReady"
			annotations: {
				description: "Pod {{ $labels.namespace }}/{{ $labels.pod }} has been in a non-ready state for longer than 15 minutes on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepodnotready"
				summary:     "Pod has been in a non-ready state for more than 15 minutes."
			}
			expr: "sum(max(kube_pod_status_phase{namespace=~\".*\",job=\"kube-state-metrics\",phase=~\"Pending|Unknown\"}) by(namespace,pod,job,cluster) * on(namespace,pod,cluster) group_left(owner_kind) topk(1, max(kube_pod_owner{owner_kind!=\"Job\"}) by(namespace,pod,owner_kind,cluster)) by(namespace,pod,cluster)) by(namespace,pod,job,cluster) > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeDeploymentGenerationMismatch"
			annotations: {
				description: "Deployment generation for {{ $labels.namespace }}/{{ $labels.deployment }} does not match, this indicates that the Deployment has failed but has not been rolled back on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubedeploymentgenerationmismatch"
				summary:     "Deployment generation mismatch due to possible roll-back"
			}
			expr: "kube_deployment_status_observed_generation{namespace=~\".*\",job=\"kube-state-metrics\"} != kube_deployment_metadata_generation{namespace=~\".*\",job=\"kube-state-metrics\"}"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeDeploymentReplicasMismatch"
			annotations: {
				description: "Deployment {{ $labels.namespace }}/{{ $labels.deployment }} has not matched the expected number of replicas for longer than 15 minutes on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubedeploymentreplicasmismatch"
				summary:     "Deployment has not matched the expected number of replicas."
			}
			expr: "(kube_deployment_spec_replicas{namespace=~\".*\",job=\"kube-state-metrics\"} > kube_deployment_status_replicas_available{namespace=~\".*\",job=\"kube-state-metrics\"}) and (changes(kube_deployment_status_replicas_updated{namespace=~\".*\",job=\"kube-state-metrics\"}[10m]) == 0)"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeDeploymentRolloutStuck"
			annotations: {
				description: "Rollout of deployment {{ $labels.namespace }}/{{ $labels.deployment }} is not progressing for longer than 15 minutes on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubedeploymentrolloutstuck"
				summary:     "Deployment rollout is not progressing."
			}
			expr: "kube_deployment_status_condition{condition=\"Progressing\",status=\"false\",namespace=~\".*\",job=\"kube-state-metrics\"} != 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeStatefulSetReplicasMismatch"
			annotations: {
				description: "StatefulSet {{ $labels.namespace }}/{{ $labels.statefulset }} has not matched the expected number of replicas for longer than 15 minutes on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubestatefulsetreplicasmismatch"
				summary:     "StatefulSet has not matched the expected number of replicas."
			}
			expr: "(kube_statefulset_status_replicas_ready{namespace=~\".*\",job=\"kube-state-metrics\"} != kube_statefulset_replicas{namespace=~\".*\",job=\"kube-state-metrics\"}) and (changes(kube_statefulset_status_replicas_updated{namespace=~\".*\",job=\"kube-state-metrics\"}[10m]) == 0)"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeStatefulSetGenerationMismatch"
			annotations: {
				description: "StatefulSet generation for {{ $labels.namespace }}/{{ $labels.statefulset }} does not match, this indicates that the StatefulSet has failed but has not been rolled back on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubestatefulsetgenerationmismatch"
				summary:     "StatefulSet generation mismatch due to possible roll-back"
			}
			expr: "kube_statefulset_status_observed_generation{namespace=~\".*\",job=\"kube-state-metrics\"} != kube_statefulset_metadata_generation{namespace=~\".*\",job=\"kube-state-metrics\"}"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeStatefulSetUpdateNotRolledOut"
			annotations: {
				description: "StatefulSet {{ $labels.namespace }}/{{ $labels.statefulset }} update has not been rolled out on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubestatefulsetupdatenotrolledout"
				summary:     "StatefulSet update has not been rolled out."
			}
			expr: "(max(kube_statefulset_status_current_revision{namespace=~\".*\",job=\"kube-state-metrics\"} unless kube_statefulset_status_update_revision{namespace=~\".*\",job=\"kube-state-metrics\"}) by(namespace,statefulset,job,cluster) * on(namespace,statefulset,job,cluster) (kube_statefulset_replicas{namespace=~\".*\",job=\"kube-state-metrics\"} != kube_statefulset_status_replicas_updated{namespace=~\".*\",job=\"kube-state-metrics\"})) and on(namespace,statefulset,job,cluster) (changes(kube_statefulset_status_replicas_updated{namespace=~\".*\",job=\"kube-state-metrics\"}[5m]) == 0)"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeDaemonSetRolloutStuck"
			annotations: {
				description: "DaemonSet {{ $labels.namespace }}/{{ $labels.daemonset }} has not finished or progressed for at least 15m on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubedaemonsetrolloutstuck"
				summary:     "DaemonSet rollout is stuck."
			}
			expr: "((((kube_daemonset_status_current_number_scheduled{namespace=~\".*\",job=\"kube-state-metrics\"} != kube_daemonset_status_desired_number_scheduled{namespace=~\".*\",job=\"kube-state-metrics\"}) or (kube_daemonset_status_number_misscheduled{namespace=~\".*\",job=\"kube-state-metrics\"} != 0)) or (kube_daemonset_status_updated_number_scheduled{namespace=~\".*\",job=\"kube-state-metrics\"} != kube_daemonset_status_desired_number_scheduled{namespace=~\".*\",job=\"kube-state-metrics\"})) or (kube_daemonset_status_number_available{namespace=~\".*\",job=\"kube-state-metrics\"} != kube_daemonset_status_desired_number_scheduled{namespace=~\".*\",job=\"kube-state-metrics\"})) and (changes(kube_daemonset_status_updated_number_scheduled{namespace=~\".*\",job=\"kube-state-metrics\"}[5m]) == 0)"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeContainerWaiting"
			annotations: {
				description: "pod/{{ $labels.pod }} in namespace {{ $labels.namespace }} on container {{ $labels.container}} has been in waiting state for longer than 1 hour. (reason: \"{{ $labels.reason }}\") on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubecontainerwaiting"
				summary:     "Pod container waiting longer than 1 hour"
			}
			expr: "kube_pod_container_status_waiting_reason{reason!=\"CrashLoopBackOff\",namespace=~\".*\",job=\"kube-state-metrics\"} > 0"
			for:  "1h"
			labels: severity: "warning"
		}, {
			alert: "KubeDaemonSetNotScheduled"
			annotations: {
				description: "{{ $value }} Pods of DaemonSet {{ $labels.namespace }}/{{ $labels.daemonset }} are not scheduled on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubedaemonsetnotscheduled"
				summary:     "DaemonSet pods are not scheduled."
			}
			expr: "(kube_daemonset_status_desired_number_scheduled{namespace=~\".*\",job=\"kube-state-metrics\"} - kube_daemonset_status_current_number_scheduled{namespace=~\".*\",job=\"kube-state-metrics\"}) > 0"
			for:  "10m"
			labels: severity: "warning"
		}, {
			alert: "KubeDaemonSetMisScheduled"
			annotations: {
				description: "{{ $value }} Pods of DaemonSet {{ $labels.namespace }}/{{ $labels.daemonset }} are running where they are not supposed to run on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubedaemonsetmisscheduled"
				summary:     "DaemonSet pods are misscheduled."
			}
			expr: "kube_daemonset_status_number_misscheduled{namespace=~\".*\",job=\"kube-state-metrics\"} > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeJobNotCompleted"
			annotations: {
				description: "Job {{ $labels.namespace }}/{{ $labels.job_name }} is taking more than {{ \"43200\" | humanizeDuration }} to complete on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubejobnotcompleted"
				summary:     "Job did not complete in time"
			}
			expr: "(time() - max(kube_job_status_start_time{namespace=~\".*\",job=\"kube-state-metrics\"} and (kube_job_status_active{namespace=~\".*\",job=\"kube-state-metrics\"} > 0)) by(namespace,job_name,cluster)) > 43200"
			labels: severity: "warning"
		}, {
			alert: "KubeJobFailed"
			annotations: {
				description: "Job {{ $labels.namespace }}/{{ $labels.job_name }} failed to complete. Removing failed job after investigation should clear this alert on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubejobfailed"
				summary:     "Job failed to complete."
			}
			expr: "kube_job_failed{namespace=~\".*\",job=\"kube-state-metrics\"} > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeHpaReplicasMismatch"
			annotations: {
				description: "HPA {{ $labels.namespace }}/{{ $labels.horizontalpodautoscaler  }} has not matched the desired number of replicas for longer than 15 minutes on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubehpareplicasmismatch"
				summary:     "HPA has not matched desired number of replicas."
			}
			expr: "(((kube_horizontalpodautoscaler_status_desired_replicas{namespace=~\".*\",job=\"kube-state-metrics\"} != kube_horizontalpodautoscaler_status_current_replicas{namespace=~\".*\",job=\"kube-state-metrics\"}) and (kube_horizontalpodautoscaler_status_current_replicas{namespace=~\".*\",job=\"kube-state-metrics\"} > kube_horizontalpodautoscaler_spec_min_replicas{namespace=~\".*\",job=\"kube-state-metrics\"})) and (kube_horizontalpodautoscaler_status_current_replicas{namespace=~\".*\",job=\"kube-state-metrics\"} < kube_horizontalpodautoscaler_spec_max_replicas{namespace=~\".*\",job=\"kube-state-metrics\"})) and (changes(kube_horizontalpodautoscaler_status_current_replicas{namespace=~\".*\",job=\"kube-state-metrics\"}[15m]) == 0)"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeHpaMaxedOut"
			annotations: {
				description: "HPA {{ $labels.namespace }}/{{ $labels.horizontalpodautoscaler  }} has been running at max replicas for longer than 15 minutes on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubehpamaxedout"
				summary:     "HPA is running at max replicas"
			}
			expr: "(kube_horizontalpodautoscaler_status_current_replicas{namespace=~\".*\",job=\"kube-state-metrics\"} == kube_horizontalpodautoscaler_spec_max_replicas{namespace=~\".*\",job=\"kube-state-metrics\"}) and on(namespace,horizontalpodautoscaler,cluster) (kube_horizontalpodautoscaler_spec_max_replicas{namespace=~\".*\",job=\"kube-state-metrics\"} != kube_horizontalpodautoscaler_spec_min_replicas{namespace=~\".*\",job=\"kube-state-metrics\"})"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubePdbNotEnoughHealthyPods"
			annotations: {
				description: "PDB {{ $labels.cluster }}/{{ $labels.namespace }}/{{ $labels.poddisruptionbudget }} expects {{ $value }} more healthy pods. The desired number of healthy pods has not been met for at least 15m."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepdbnotenoughhealthypods"
				summary:     "PDB does not have enough healthy pods."
			}
			expr: "(kube_poddisruptionbudget_status_desired_healthy{namespace=~\".*\",job=\"kube-state-metrics\"} - kube_poddisruptionbudget_status_current_healthy{namespace=~\".*\",job=\"kube-state-metrics\"}) > 0"
			for:  "15m"
			labels: severity: "warning"
		}]
	}]
}, {
	metadata: name: "kubernetes-resources"
	spec: groups: [{
		name: "kubernetes-resources"
		rules: [{
			alert: "KubeCPUOvercommit"
			annotations: {
				description: "Cluster {{ $labels.cluster }} has overcommitted CPU resource requests for Pods by {{ printf \"%.2f\" $value }} CPU shares and cannot tolerate node failure."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubecpuovercommit"
				summary:     "Cluster has overcommitted CPU resource requests."
			}
			expr: "(((sum(namespace_cpu:kube_pod_container_resource_requests:sum) by(cluster) - sum(kube_node_status_allocatable{job=\"kube-state-metrics\",resource=\"cpu\"}) by(cluster)) > 0) and (count(max(kube_node_role{job=\"kube-state-metrics\",role=\"control-plane\"}) by(cluster,node)) by(cluster) < 3)) or ((sum(namespace_cpu:kube_pod_container_resource_requests:sum) by(cluster) - ((sum(kube_node_status_allocatable{job=\"kube-state-metrics\",resource=\"cpu\"}) by(cluster) - max(kube_node_status_allocatable{job=\"kube-state-metrics\",resource=\"cpu\"}) by(cluster)) > 0)) > 0)"
			for:  "10m"
			labels: severity: "warning"
		}, {
			alert: "KubeMemoryOvercommit"
			annotations: {
				description: "Cluster {{ $labels.cluster }} has overcommitted memory resource requests for Pods by {{ $value | humanize }} bytes and cannot tolerate node failure."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubememoryovercommit"
				summary:     "Cluster has overcommitted memory resource requests."
			}
			expr: "(((sum(namespace_memory:kube_pod_container_resource_requests:sum) by(cluster) - sum(kube_node_status_allocatable{job=\"kube-state-metrics\",resource=\"memory\"}) by(cluster)) > 0) and (count(max(kube_node_role{job=\"kube-state-metrics\",role=\"control-plane\"}) by(cluster,node)) by(cluster) < 3)) or ((sum(namespace_memory:kube_pod_container_resource_requests:sum) by(cluster) - ((sum(kube_node_status_allocatable{job=\"kube-state-metrics\",resource=\"memory\"}) by(cluster) - max(kube_node_status_allocatable{job=\"kube-state-metrics\",resource=\"memory\"}) by(cluster)) > 0)) > 0)"
			for:  "10m"
			labels: severity: "warning"
		}, {
			alert: "KubeCPUQuotaOvercommit"
			annotations: {
				description: "Cluster {{ $labels.cluster }} has overcommitted CPU resource requests for Namespaces."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubecpuquotaovercommit"
				summary:     "Cluster has overcommitted CPU resource requests."
			}
			expr: "(sum(min(kube_resourcequota{job=\"kube-state-metrics\",type=\"hard\",resource=~\"(cpu|requests.cpu)\"}) without(resource)) by(cluster) / sum(kube_node_status_allocatable{resource=\"cpu\",job=\"kube-state-metrics\"}) by(cluster)) > 1.5"
			for:  "5m"
			labels: severity: "warning"
		}, {
			alert: "KubeMemoryQuotaOvercommit"
			annotations: {
				description: "Cluster {{ $labels.cluster }} has overcommitted memory resource requests for Namespaces."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubememoryquotaovercommit"
				summary:     "Cluster has overcommitted memory resource requests."
			}
			expr: "(sum(min(kube_resourcequota{job=\"kube-state-metrics\",type=\"hard\",resource=~\"(memory|requests.memory)\"}) without(resource)) by(cluster) / sum(kube_node_status_allocatable{resource=\"memory\",job=\"kube-state-metrics\"}) by(cluster)) > 1.5"
			for:  "5m"
			labels: severity: "warning"
		}, {
			alert: "KubeQuotaAlmostFull"
			annotations: {
				description: "Namespace {{ $labels.namespace }} is using {{ $value | humanizePercentage }} of its {{ $labels.resource }} quota on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubequotaalmostfull"
				summary:     "Namespace quota is going to be full."
			}
			expr: "((max(kube_resourcequota{job=\"kube-state-metrics\",type=\"used\"}) without(instance,job,type) / on(cluster,namespace,resource,resourcequota) group_left() (max(kube_resourcequota{job=\"kube-state-metrics\",type=\"hard\"}) without(instance,job,type) > 0)) > 0.9) < 1"
			for:  "15m"
			labels: severity: "info"
		}, {
			alert: "KubeQuotaFullyUsed"
			annotations: {
				description: "Namespace {{ $labels.namespace }} is using {{ $value | humanizePercentage }} of its {{ $labels.resource }} quota on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubequotafullyused"
				summary:     "Namespace quota is fully used."
			}
			expr: "(max(kube_resourcequota{job=\"kube-state-metrics\",type=\"used\"}) without(instance,job,type) / on(cluster,namespace,resource,resourcequota) group_left() (max(kube_resourcequota{job=\"kube-state-metrics\",type=\"hard\"}) without(instance,job,type) > 0)) == 1"
			for:  "15m"
			labels: severity: "info"
		}, {
			alert: "KubeQuotaExceeded"
			annotations: {
				description: "Namespace {{ $labels.namespace }} is using {{ $value | humanizePercentage }} of its {{ $labels.resource }} quota on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubequotaexceeded"
				summary:     "Namespace quota has exceeded the limits."
			}
			expr: "(max(kube_resourcequota{job=\"kube-state-metrics\",type=\"used\"}) without(instance,job,type) / on(cluster,namespace,resource,resourcequota) group_left() (max(kube_resourcequota{job=\"kube-state-metrics\",type=\"hard\"}) without(instance,job,type) > 0)) > 1"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "CPUThrottlingHigh"
			annotations: {
				description: "{{ $value | humanizePercentage }} throttling of CPU in namespace {{ $labels.namespace }} for container {{ $labels.container }} in pod {{ $labels.pod }} on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/cputhrottlinghigh"
				summary:     "Processes experience elevated CPU throttling."
			}
			expr: "(sum(topk(1, increase(container_cpu_cfs_throttled_periods_total{container!=\"\",job=\"kubelet\",metrics_path=\"/metrics/cadvisor\"}[5m])) by(cluster,namespace,pod,container,instance)) without(id,metrics_path,name,image,endpoint,job,node) / on(cluster,namespace,pod,container,instance) group_left() sum(topk(1, increase(container_cpu_cfs_periods_total{job=\"kubelet\",metrics_path=\"/metrics/cadvisor\"}[5m])) by(cluster,namespace,pod,container,instance)) without(id,metrics_path,name,image,endpoint,job,node)) > 0.25"
			for:  "15m"
			labels: severity: "info"
		}]
	}]
}, {
	metadata: name: "kubernetes-storage"
	spec: groups: [{
		name: "kubernetes-storage"
		rules: [{
			alert: "KubePersistentVolumeFillingUp"
			annotations: {
				description: "The PersistentVolume claimed by {{ $labels.persistentvolumeclaim }} in Namespace {{ $labels.namespace }} {{ with $labels.cluster -}} on Cluster {{ . }} {{- end }} is only {{ $value | humanizePercentage }} free."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepersistentvolumefillingup"
				summary:     "PersistentVolume is filling up."
			}
			expr: "((((kubelet_volume_stats_available_bytes{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"} / kubelet_volume_stats_capacity_bytes{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"}) < 0.03) and (kubelet_volume_stats_used_bytes{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"} > 0)) unless on(cluster,namespace,persistentvolumeclaim) (kube_persistentvolumeclaim_access_mode{access_mode=\"ReadOnlyMany\"} == 1)) unless on(cluster,namespace,persistentvolumeclaim) (kube_persistentvolumeclaim_labels{label_excluded_from_alerts=\"true\"} == 1)"
			for:  "1m"
			labels: severity: "critical"
		}, {
			alert: "KubePersistentVolumeFillingUp"
			annotations: {
				description: "Based on recent sampling, the PersistentVolume claimed by {{ $labels.persistentvolumeclaim }} in Namespace {{ $labels.namespace }} {{ with $labels.cluster -}} on Cluster {{ . }} {{- end }} is expected to fill up within four days. Currently {{ $value | humanizePercentage }} is available."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepersistentvolumefillingup"
				summary:     "PersistentVolume is filling up."
			}
			expr: "(((((kubelet_volume_stats_available_bytes{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"} / kubelet_volume_stats_capacity_bytes{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"}) < 0.15) and (kubelet_volume_stats_used_bytes{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"} > 0)) and (predict_linear(kubelet_volume_stats_available_bytes{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"}[6h], 345600) < 0)) unless on(cluster,namespace,persistentvolumeclaim) (kube_persistentvolumeclaim_access_mode{access_mode=\"ReadOnlyMany\"} == 1)) unless on(cluster,namespace,persistentvolumeclaim) (kube_persistentvolumeclaim_labels{label_excluded_from_alerts=\"true\"} == 1)"
			for:  "1h"
			labels: severity: "warning"
		}, {
			alert: "KubePersistentVolumeInodesFillingUp"
			annotations: {
				description: "The PersistentVolume claimed by {{ $labels.persistentvolumeclaim }} in Namespace {{ $labels.namespace }} {{ with $labels.cluster -}} on Cluster {{ . }} {{- end }} only has {{ $value | humanizePercentage }} free inodes."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepersistentvolumeinodesfillingup"
				summary:     "PersistentVolumeInodes are filling up."
			}
			expr: "((((kubelet_volume_stats_inodes_free{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"} / kubelet_volume_stats_inodes{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"}) < 0.03) and (kubelet_volume_stats_inodes_used{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"} > 0)) unless on(cluster,namespace,persistentvolumeclaim) (kube_persistentvolumeclaim_access_mode{access_mode=\"ReadOnlyMany\"} == 1)) unless on(cluster,namespace,persistentvolumeclaim) (kube_persistentvolumeclaim_labels{label_excluded_from_alerts=\"true\"} == 1)"
			for:  "1m"
			labels: severity: "critical"
		}, {
			alert: "KubePersistentVolumeInodesFillingUp"
			annotations: {
				description: "Based on recent sampling, the PersistentVolume claimed by {{ $labels.persistentvolumeclaim }} in Namespace {{ $labels.namespace }} {{ with $labels.cluster -}} on Cluster {{ . }} {{- end }} is expected to run out of inodes within four days. Currently {{ $value | humanizePercentage }} of its inodes are free."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepersistentvolumeinodesfillingup"
				summary:     "PersistentVolumeInodes are filling up."
			}
			expr: "(((((kubelet_volume_stats_inodes_free{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"} / kubelet_volume_stats_inodes{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"}) < 0.15) and (kubelet_volume_stats_inodes_used{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"} > 0)) and (predict_linear(kubelet_volume_stats_inodes_free{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"}[6h], 345600) < 0)) unless on(cluster,namespace,persistentvolumeclaim) (kube_persistentvolumeclaim_access_mode{access_mode=\"ReadOnlyMany\"} == 1)) unless on(cluster,namespace,persistentvolumeclaim) (kube_persistentvolumeclaim_labels{label_excluded_from_alerts=\"true\"} == 1)"
			for:  "1h"
			labels: severity: "warning"
		}, {
			alert: "KubePersistentVolumeErrors"
			annotations: {
				description: "The persistent volume {{ $labels.persistentvolume }} {{ with $labels.cluster -}} on Cluster {{ . }} {{- end }} has status {{ $labels.phase }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepersistentvolumeerrors"
				summary:     "PersistentVolume is having issues with provisioning."
			}
			expr: "kube_persistentvolume_status_phase{phase=~\"Failed|Pending\",job=\"kube-state-metrics\"} > 0"
			for:  "5m"
			labels: severity: "critical"
		}]
	}]
}, {
	metadata: name: "kubernetes-system-apiserver"
	spec: groups: [{
		name: "kubernetes-system-apiserver"
		rules: [{
			alert: "KubeClientCertificateExpiration"
			annotations: {
				description: "A client certificate used to authenticate to kubernetes apiserver is expiring in less than 7.0 days on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeclientcertificateexpiration"
				summary:     "Client certificate is about to expire."
			}
			expr: "(histogram_quantile(0.01, sum(rate(apiserver_client_certificate_expiration_seconds_bucket{job=\"apiserver\"}[5m])) without(namespace,service,endpoint)) < 604800) and on(job,cluster,instance) (apiserver_client_certificate_expiration_seconds_count{job=\"apiserver\"} > 0)"
			for:  "5m"
			labels: severity: "warning"
		}, {
			alert: "KubeClientCertificateExpiration"
			annotations: {
				description: "A client certificate used to authenticate to kubernetes apiserver is expiring in less than 24.0 hours on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeclientcertificateexpiration"
				summary:     "Client certificate is about to expire."
			}
			expr: "(histogram_quantile(0.01, sum(rate(apiserver_client_certificate_expiration_seconds_bucket{job=\"apiserver\"}[5m])) without(namespace,service,endpoint)) < 86400) and on(job,cluster,instance) (apiserver_client_certificate_expiration_seconds_count{job=\"apiserver\"} > 0)"
			for:  "5m"
			labels: severity: "critical"
		}, {
			alert: "KubeAggregatedAPIErrors"
			annotations: {
				description: "Kubernetes aggregated API {{ $labels.instance }}/{{ $labels.name }} has reported {{ $labels.reason }} errors on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeaggregatedapierrors"
				summary:     "Kubernetes aggregated API has reported errors."
			}
			expr: "sum(increase(aggregator_unavailable_apiservice_total{job=\"apiserver\"}[1m])) by(cluster,instance,name,reason) > 0"
			for:  "10m"
			labels: severity: "warning"
		}, {
			alert: "KubeAggregatedAPIDown"
			annotations: {
				description: "Kubernetes aggregated API {{ $labels.name }}/{{ $labels.namespace }} has been only {{ $value | humanize }}% available over the last 10m on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeaggregatedapidown"
				summary:     "Kubernetes aggregated API is down."
			}
			expr: "((1 - max(avg_over_time(aggregator_unavailable_apiservice{job=\"apiserver\"}[10m])) by(name,namespace,cluster)) * 100) < 85"
			for:  "5m"
			labels: severity: "warning"
		}, {
			alert: "KubeAPIDown"
			annotations: {
				description: "KubeAPI has disappeared from Prometheus target discovery."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeapidown"
				summary:     "Target disappeared from Prometheus target discovery."
			}
			expr: "absent(up{job=\"apiserver\"})"
			for:  "15m"
			labels: severity: "critical"
		}, {
			alert: "KubeAPITerminatedRequests"
			annotations: {
				description: "The kubernetes apiserver has terminated {{ $value | humanizePercentage }} of its incoming requests on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeapiterminatedrequests"
				summary:     "The kubernetes apiserver has terminated {{ $value | humanizePercentage }} of its incoming requests."
			}
			expr: "(sum(rate(apiserver_request_terminations_total{job=\"apiserver\"}[10m])) by(cluster) / (sum(rate(apiserver_request_total{job=\"apiserver\"}[10m])) by(cluster) + sum(rate(apiserver_request_terminations_total{job=\"apiserver\"}[10m])) by(cluster))) > 0.20"
			for:  "5m"
			labels: severity: "warning"
		}]
	}]
}, {
	metadata: name: "kubernetes-system-controller-manager"
	spec: groups: [{
		name: "kubernetes-system-controller-manager"
		rules: [{
			alert: "KubeControllerManagerDown"
			annotations: {
				description: "KubeControllerManager has disappeared from Prometheus target discovery."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubecontrollermanagerdown"
				summary:     "Target disappeared from Prometheus target discovery."
			}
			expr: "absent(up{job=\"kube-controller-manager\"})"
			for:  "15m"
			labels: severity: "critical"
		}]
	}]
}, {
	metadata: name: "kubernetes-system-kubelet"
	spec: groups: [{
		name: "kubernetes-system-kubelet"
		rules: [{
			alert: "KubeNodeNotReady"
			annotations: {
				description: "{{ $labels.node }} has been unready for more than 15 minutes on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubenodenotready"
				summary:     "Node is not ready."
			}
			expr: "(kube_node_status_condition{job=\"kube-state-metrics\",condition=\"Ready\",status=\"true\"} == 0) and on(cluster,node) (kube_node_spec_unschedulable{job=\"kube-state-metrics\"} == 0)"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeNodePressure"
			annotations: {
				description: "{{ $labels.node }} on cluster {{ $labels.cluster }} has active Condition {{ $labels.condition }}. This is caused by resource usage exceeding eviction thresholds."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubenodepressure"
				summary:     "Node has as active Condition."
			}
			expr: "(kube_node_status_condition{job=\"kube-state-metrics\",condition=~\"(MemoryPressure|DiskPressure|PIDPressure)\",status=\"true\"} == 1) and on(cluster,node) (kube_node_spec_unschedulable{job=\"kube-state-metrics\"} == 0)"
			for:  "10m"
			labels: severity: "info"
		}, {
			alert: "KubeNodeUnreachable"
			annotations: {
				description: "{{ $labels.node }} is unreachable and some workloads may be rescheduled on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubenodeunreachable"
				summary:     "Node is unreachable."
			}
			expr: "(kube_node_spec_taint{job=\"kube-state-metrics\",key=\"node.kubernetes.io/unreachable\",effect=\"NoSchedule\"} unless ignoring(key,value) kube_node_spec_taint{job=\"kube-state-metrics\",key=~\"ToBeDeletedByClusterAutoscaler|cloud.google.com/impending-node-termination|aws-node-termination-handler/spot-itn\"}) == 1"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeletTooManyPods"
			annotations: {
				description: "Kubelet '{{ $labels.node }}' is running at {{ $value | humanizePercentage }} of its Pod capacity on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubelettoomanypods"
				summary:     "Kubelet is running at capacity."
			}
			expr: "((max(kubelet_running_pods{job=\"kubelet\",metrics_path=\"/metrics\"} > 1) by(cluster,instance) * on(cluster,instance) group_left(node) max(kubelet_node_name{job=\"kubelet\",metrics_path=\"/metrics\"}) by(cluster,instance,node)) / on(cluster,node) group_left() max(kube_node_status_capacity{job=\"kube-state-metrics\",resource=\"pods\"} != 1) by(cluster,node)) > 0.95"
			for:  "15m"
			labels: severity: "info"
		}, {
			alert: "KubeNodeReadinessFlapping"
			annotations: {
				description: "The readiness status of node {{ $labels.node }} has changed {{ $value }} times in the last 15 minutes on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubenodereadinessflapping"
				summary:     "Node readiness status is flapping."
			}
			expr: "(sum(changes(kube_node_status_condition{job=\"kube-state-metrics\",status=\"true\",condition=\"Ready\"}[15m])) by(cluster,node) > 2) and on(cluster,node) (kube_node_spec_unschedulable{job=\"kube-state-metrics\"} == 0)"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeNodeEviction"
			annotations: {
				description: "Node {{ $labels.node }} on {{ $labels.cluster }} is evicting Pods due to {{ $labels.eviction_signal }}.  Eviction occurs when eviction thresholds are crossed, typically caused by Pods exceeding RAM/ephemeral-storage limits."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubenodeeviction"
				summary:     "Node is evicting pods."
			}
			expr: "(sum(rate(kubelet_evictions{job=\"kubelet\",metrics_path=\"/metrics\"}[15m])) by(cluster,eviction_signal,instance) * on(cluster,instance) group_left(node) max(kubelet_node_name{job=\"kubelet\",metrics_path=\"/metrics\"}) by(cluster,instance,node)) > 0"
			for:  "0s"
			labels: severity: "info"
		}, {
			alert: "KubeletPlegDurationHigh"
			annotations: {
				description: "The Kubelet Pod Lifecycle Event Generator has a 99th percentile duration of {{ $value }} seconds on node {{ $labels.node }} on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletplegdurationhigh"
				summary:     "Kubelet Pod Lifecycle Event Generator is taking too long to relist."
			}
			expr: "node_quantile:kubelet_pleg_relist_duration_seconds:histogram_quantile{quantile=\"0.99\"} >= 10"
			for:  "5m"
			labels: severity: "warning"
		}, {
			alert: "KubeletPodStartUpLatencyHigh"
			annotations: {
				description: "Kubelet Pod startup 99th percentile latency is {{ $value }} seconds on node {{ $labels.node }} on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletpodstartuplatencyhigh"
				summary:     "Kubelet Pod startup latency is too high."
			}
			expr: "(histogram_quantile(0.99, sum(topk(1, rate(kubelet_pod_worker_duration_seconds_bucket{job=\"kubelet\",metrics_path=\"/metrics\"}[5m])) by(cluster,instance,le,operation_type)) by(cluster,instance,le)) * on(cluster,instance) group_left(node) topk(1, kubelet_node_name{job=\"kubelet\",metrics_path=\"/metrics\"}) by(cluster,instance,node)) > 60"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeletClientCertificateExpiration"
			annotations: {
				description: "Client certificate for Kubelet on node {{ $labels.node }} expires in {{ $value | humanizeDuration }} on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletclientcertificateexpiration"
				summary:     "Kubelet client certificate is about to expire."
			}
			expr: "kubelet_certificate_manager_client_ttl_seconds < 604800"
			labels: severity: "warning"
		}, {
			alert: "KubeletClientCertificateExpiration"
			annotations: {
				description: "Client certificate for Kubelet on node {{ $labels.node }} expires in {{ $value | humanizeDuration }} on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletclientcertificateexpiration"
				summary:     "Kubelet client certificate is about to expire."
			}
			expr: "kubelet_certificate_manager_client_ttl_seconds < 86400"
			labels: severity: "critical"
		}, {
			alert: "KubeletServerCertificateExpiration"
			annotations: {
				description: "Server certificate for Kubelet on node {{ $labels.node }} expires in {{ $value | humanizeDuration }} on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletservercertificateexpiration"
				summary:     "Kubelet server certificate is about to expire."
			}
			expr: "kubelet_certificate_manager_server_ttl_seconds < 604800"
			labels: severity: "warning"
		}, {
			alert: "KubeletServerCertificateExpiration"
			annotations: {
				description: "Server certificate for Kubelet on node {{ $labels.node }} expires in {{ $value | humanizeDuration }} on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletservercertificateexpiration"
				summary:     "Kubelet server certificate is about to expire."
			}
			expr: "kubelet_certificate_manager_server_ttl_seconds < 86400"
			labels: severity: "critical"
		}, {
			alert: "KubeletClientCertificateRenewalErrors"
			annotations: {
				description: "Kubelet on node {{ $labels.node }} has failed to renew its client certificate ({{ $value | humanize }} errors in the last 5 minutes) on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletclientcertificaterenewalerrors"
				summary:     "Kubelet has failed to renew its client certificate."
			}
			expr: "increase(kubelet_certificate_manager_client_expiration_renew_errors[5m]) > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeletServerCertificateRenewalErrors"
			annotations: {
				description: "Kubelet on node {{ $labels.node }} has failed to renew its server certificate ({{ $value | humanize }} errors in the last 5 minutes) on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletservercertificaterenewalerrors"
				summary:     "Kubelet has failed to renew its server certificate."
			}
			expr: "increase(kubelet_server_expiration_renew_errors[5m]) > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeletDown"
			annotations: {
				description: "Kubelet has disappeared from Prometheus target discovery on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletdown"
				summary:     "Target disappeared from Prometheus target discovery."
			}
			expr: "count(kube_node_info{job=\"kube-state-metrics\"}) by(cluster) unless on(cluster) count(up{job=\"kubelet\",metrics_path=\"/metrics\"} == 1) by(cluster)"
			for:  "15m"
			labels: severity: "critical"
		}]
	}]
}, {
	metadata: name: "kubernetes-system-scheduler"
	spec: groups: [{
		name: "kubernetes-system-scheduler"
		rules: [{
			alert: "KubeSchedulerDown"
			annotations: {
				description: "KubeScheduler has disappeared from Prometheus target discovery."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeschedulerdown"
				summary:     "Target disappeared from Prometheus target discovery."
			}
			expr: "absent(up{job=\"kube-scheduler\"})"
			for:  "15m"
			labels: severity: "critical"
		}]
	}]
}, {
	metadata: name: "kubernetes-system"
	spec: groups: [{
		name: "kubernetes-system"
		rules: [{
			alert: "KubeVersionMismatch"
			annotations: {
				description: "There are {{ $value }} different semantic versions of Kubernetes components running on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeversionmismatch"
				summary:     "Different semantic versions of Kubernetes components running."
			}
			expr: "count(count(label_replace(kubernetes_build_info{job!~\"kube-dns|coredns\"}, \"git_version\", \"$1\", \"git_version\", \"(v[0-9]*.[0-9]*).*\")) by(git_version,cluster)) by(cluster) > 1"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeClientErrors"
			annotations: {
				description: "Kubernetes API server client '{{ $labels.job }}/{{ $labels.instance }}' is experiencing {{ $value | humanizePercentage }} errors on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeclienterrors"
				summary:     "Kubernetes API server client is experiencing errors."
			}
			expr: "(sum(rate(rest_client_requests_total{job=\"apiserver\",code=~\"5..\"}[5m])) by(cluster,instance,job,namespace) / sum(rate(rest_client_requests_total{job=\"apiserver\"}[5m])) by(cluster,instance,job,namespace)) > 0.01"
			for:  "15m"
			labels: severity: "warning"
		}]
	}]
}, {
	metadata: name: "node-network"
	spec: groups: [{
		name: "node-network"
		rules: [{
			alert: "NodeNetworkInterfaceFlapping"
			annotations: {
				description: "Network interface \"{{ $labels.device }}\" changing its up status often on node-exporter {{ $labels.namespace }}/{{ $labels.pod }}"
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/general/nodenetworkinterfaceflapping"
				summary:     "Network interface is often changing its status"
			}
			expr: "changes(node_network_up{job=\"node-exporter\",device!~\"veth.+\"}[2m]) > 2"
			for:  "2m"
			labels: severity: "warning"
		}]
	}]
}, {
	metadata: name: "node.rules"
	spec: groups: [{
		name: "node.rules"
		rules: [{
			expr: "topk(1, max(label_replace(kube_pod_info{job=\"kube-state-metrics\",node!=\"\"}, \"pod\", \"$1\", \"pod\", \"(.*)\")) by(cluster,node,namespace,pod)) by(cluster,namespace,pod)"
			record: "node_namespace_pod:kube_pod_info:"
		}, {
			expr: "count(node_cpu_seconds_total{mode=\"idle\",job=\"node-exporter\"} * on(cluster,namespace,pod) group_left(node) topk(1, node_namespace_pod:kube_pod_info:) by(cluster,namespace,pod)) by(cluster,node)"
			record: "node:node_num_cpu:sum"
		}, {
			expr: "sum(node_memory_MemAvailable_bytes{job=\"node-exporter\"} or (((node_memory_Buffers_bytes{job=\"node-exporter\"} + node_memory_Cached_bytes{job=\"node-exporter\"}) + node_memory_MemFree_bytes{job=\"node-exporter\"}) + node_memory_Slab_bytes{job=\"node-exporter\"})) by(cluster)"
			record: ":node_memory_MemAvailable_bytes:sum"
		}, {
			expr: "avg(sum(rate(node_cpu_seconds_total{mode!=\"idle\",mode!=\"iowait\",mode!=\"steal\",job=\"node-exporter\"}[5m])) without(mode)) by(cluster,node)"
			record: "node:node_cpu_utilization:ratio_rate5m"
		}, {
			expr: "avg(node:node_cpu_utilization:ratio_rate5m) by(cluster)"
			record: "cluster:node_cpu:ratio_rate5m"
		}]
	}]
}, {
	metadata: name: "vm-health"
	spec: groups: [{
		name: "vm-health"
		rules: [{
			alert: "TooManyRestarts"
			annotations: {
				description: """
					Job {{ $labels.job }} (instance {{ $labels.instance }}) has restarted more than twice in the last 15 minutes. It might be crashlooping.

					"""
				summary: "{{ $labels.job }} too many restarts (instance {{ $labels.instance }})"
			}
			expr: "changes(process_start_time_seconds{job=~\".*(victoriametrics|vmselect|vminsert|vmstorage|vmagent|vmalert|vmsingle|vmalertmanager|vmauth).*\"}[15m]) > 2"
			labels: severity: "critical"
		}, {
			alert: "ServiceDown"
			annotations: {
				description: "{{ $labels.instance }} of job {{ $labels.job }} has been down for more than 2 minutes."
				summary:     "Service {{ $labels.job }} is down on {{ $labels.instance }}"
			}
			expr: "up{job=~\".*(victoriametrics|vmselect|vminsert|vmstorage|vmagent|vmalert|vmsingle|vmalertmanager|vmauth).*\"} == 0"
			for:  "2m"
			labels: severity: "critical"
		}, {
			alert: "ProcessNearFDLimits"
			annotations: {
				description: """
					Exhausting OS file descriptors limit can cause severe degradation of the process.
					Consider to increase the limit as fast as possible.

					"""
				summary: "Number of free file descriptors is less than 100 for \"{{ $labels.job }}\"(\"{{ $labels.instance }}\") for the last 5m"
			}
			expr: "(process_max_fds - process_open_fds) < 100"
			for:  "5m"
			labels: severity: "critical"
		}, {
			alert: "TooHighMemoryUsage"
			annotations: {
				description: """
					Too high memory usage may result into multiple issues such as OOMs or degraded performance.
					Consider to either increase available memory or decrease the load on the process.

					"""
				summary: "It is more than 80% of memory used by \"{{ $labels.job }}\"(\"{{ $labels.instance }}\")"
			}
			expr: "(min_over_time(process_resident_memory_anon_bytes[10m]) / vm_available_memory_bytes) > 0.8"
			for:  "5m"
			labels: severity: "critical"
		}, {
			alert: "TooHighCPUUsage"
			annotations: {
				description: """
					Too high CPU usage may be a sign of insufficient resources and make process unstable. Consider to either increase available CPU resources or decrease the load on the process.

					"""
				summary: "More than 90% of CPU is used by \"{{ $labels.job }}\"(\"{{ $labels.instance }}\") during the last 5m"
			}
			expr: "(rate(process_cpu_seconds_total[5m]) / process_cpu_cores_available) > 0.9"
			for:  "5m"
			labels: severity: "critical"
		}, {
			alert: "TooHighGoroutineSchedulingLatency"
			annotations: {
				description: """
					Go runtime is unable to schedule goroutines execution in acceptable time. This is usually a sign of insufficient CPU resources or CPU throttling. Verify that service has enough CPU resources. Otherwise, the service could work unreliably with delays in processing.

					"""
				summary: "\"{{ $labels.job }}\"(\"{{ $labels.instance }}\") has insufficient CPU resources for >15m"
			}
			expr: "histogram_quantile(0.99, sum(rate(go_sched_latencies_seconds_bucket{job=~\".*(victoriametrics|vmselect|vminsert|vmstorage|vmagent|vmalert|vmsingle|vmalertmanager|vmauth).*\"}[5m])) by(le,job,instance,cluster)) > 0.1"
			for:  "15m"
			labels: severity: "critical"
		}, {
			alert: "TooManyTSIDMisses"
			annotations: {
				description: """
					Unexpected TSID misses for \\"{{ $labels.job }}\\" ({{ $labels.instance }}) for the last 15 minutes.
					If this happens after unclean shutdown of VictoriaMetrics process (via \\"kill -9\\", OOM or power off),
					then this is OK - the alert must go away in a few minutes after the restart.
					Otherwise this may point to the corruption of index data.

					"""
				summary: "Unexpected TSID misses for job \"{{ $labels.job }}\" ({{ $labels.instance }}) for the last 15 minutes"
			}
			expr: "increase(vm_missing_tsids_for_metric_id_total[5m]) > 0"
			for:  "15m"
			labels: severity: "critical"
		}, {
			alert: "ConcurrentInsertsHitTheLimit"
			annotations: {
				description: """
					The limit of concurrent inserts on instance {{ $labels.instance }} depends on the number of CPUs.
					Usually, when component constantly hits the limit it is likely the component is overloaded and requires more CPU.
					In some cases for components like vmagent or vminsert the alert might trigger if there are too many clients
					making write attempts. If vmagent's or vminsert's CPU usage and network saturation are at normal level, then 
					it might be worth adjusting `-maxConcurrentInserts` cmd-line flag.

					"""
				summary: "{{ $labels.job }} on instance {{ $labels.instance }} is constantly hitting concurrent inserts limit"
			}
			expr: "avg_over_time(vm_concurrent_insert_current[1m]) >= vm_concurrent_insert_capacity"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "IndexDBRecordsDrop"
			annotations: {
				description: """
					VictoriaMetrics could skip registering new timeseries during ingestion if they fail the validation process. 
					For example, `reason=too_long_item` means that time series cannot exceed 64KB. Please, reduce the number 
					of labels or label values for such series. Or enforce these limits via `-maxLabelsPerTimeseries` and 
					`-maxLabelValueLen` command-line flags.

					"""
				summary: "IndexDB skipped registering items during data ingestion with reason={{ $labels.reason }}."
			}
			expr: "increase(vm_indexdb_items_dropped_total[5m]) > 0"
			labels: severity: "critical"
		}, {
			alert: "RowsRejectedOnIngestion"
			annotations: {
				description: "Ingested rows on instance \"{{ $labels.instance }}\" are rejected due to the following reason: \"{{ $labels.reason }}\""
				summary:     "Some rows are rejected on \"{{ $labels.instance }}\" on ingestion attempt"
			}
			expr: "rate(vm_rows_ignored_total[5m]) > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "TooHighQueryLoad"
			annotations: {
				description: """
					Instance {{ $labels.instance }} ({{ $labels.job }}) is failing to serve read queries during last 15m.
					Concurrency limit `-search.maxConcurrentRequests` was reached on this instance and extra queries were
					put into the queue for `-search.maxQueueDuration` interval. But even after waiting in the queue these queries weren't served.
					This happens if instance is overloaded with the current workload, or datasource is too slow to respond.
					Possible solutions are the following:
					* reduce the query load;
					* increase compute resources or number of replicas;
					* adjust limits `-search.maxConcurrentRequests` and `-search.maxQueueDuration`.
					See more at https://docs.victoriametrics.com/victoriametrics/troubleshooting/#slow-queries.

					"""
				summary: "Read queries fail with timeout for {{ $labels.job }} on instance {{ $labels.instance }}"
			}
			expr: "increase(vm_concurrent_select_limit_timeout_total[5m]) > 0"
			for:  "15m"
			labels: severity: "warning"
		}]
	}]
}, {
	metadata: name: "vmagent"
	spec: groups: [{
		concurrency: 2
		interval:    "30s"
		name:        "vmagent"
		rules: [{
			alert: "PersistentQueueIsDroppingData"
			annotations: {
				dashboard:   "{{ $externalURL }}/d/G7Z9GzMGz?viewPanel=49&var-instance={{ $labels.instance }}"
				description: "Vmagent dropped {{ $value | humanize1024 }} from persistent queue on instance {{ $labels.instance }} for the last 10m."
				summary:     "Instance {{ $labels.instance }} is dropping data from persistent queue"
			}
			expr: "sum(increase(vm_persistentqueue_bytes_dropped_total[5m])) without(path) > 0"
			for:  "10m"
			labels: severity: "critical"
		}, {
			alert: "RejectedRemoteWriteDataBlocksAreDropped"
			annotations: {
				dashboard:   "{{ $externalURL }}/d/G7Z9GzMGz?viewPanel=79&var-instance={{ $labels.instance }}"
				description: "Job \"{{ $labels.job }}\" on instance {{ $labels.instance }} drops the rejected by remote-write server data blocks. Check the logs to find the reason for rejects."
				summary:     "Vmagent is dropping data blocks that are rejected by remote storage"
			}
			expr: "sum(increase(vmagent_remotewrite_packets_dropped_total[5m])) without(url) > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "TooManyScrapeErrors"
			annotations: {
				dashboard:   "{{ $externalURL }}/d/G7Z9GzMGz?viewPanel=31&var-instance={{ $labels.instance }}"
				description: "Job \"{{ $labels.job }}\" on instance {{ $labels.instance }} fails to scrape targets for last 15m"
				summary:     "Vmagent fails to scrape one or more targets"
			}
			expr: "increase(vm_promscrape_scrapes_failed_total[5m]) > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "ScrapePoolHasNoTargets"
			annotations: {
				description: "Vmagent \"{{ $labels.job }}\" has scrape_pool \"{{ $labels.scrape_job }}\" with 0 discovered targets. It is likely a misconfiguration. Please follow https://docs.victoriametrics.com/victoriametrics/vmagent/#debugging-scrape-targets to troubleshoot the scraping config."
				summary:     "Vmagent has scrape_pool with 0 configured/discovered targets"
			}
			expr: "sum(vm_promscrape_scrape_pool_targets) without(status,instance,pod) == 0"
			for:  "30m"
			labels: severity: "warning"
		}, {
			alert: "TooManyWriteErrors"
			annotations: {
				dashboard:   "{{ $externalURL }}/d/G7Z9GzMGz?viewPanel=77&var-instance={{ $labels.instance }}"
				description: "Job \"{{ $labels.job }}\" on instance {{ $labels.instance }} responds with errors to write requests for last 15m."
				summary:     "Vmagent responds with too many errors on data ingestion protocols"
			}
			expr: "(sum(increase(vm_ingestserver_request_errors_total[5m])) without(name,net,type) + sum(increase(vmagent_http_request_errors_total[5m])) without(path,protocol)) > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "TooManyRemoteWriteErrors"
			annotations: {
				dashboard: "{{ $externalURL }}/d/G7Z9GzMGz?viewPanel=61&var-instance={{ $labels.instance }}"
				description: """
					Vmagent fails to push data via remote write protocol to destination "{{ $labels.url }}"
					 Ensure that destination is up and reachable.
					"""
				summary: "Job \"{{ $labels.job }}\" on instance {{ $labels.instance }} fails to push to remote storage"
			}
			expr: "rate(vmagent_remotewrite_retries_count_total[5m]) > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "RemoteWriteConnectionIsSaturated"
			annotations: {
				dashboard: "{{ $externalURL }}/d/G7Z9GzMGz?viewPanel=84&var-instance={{ $labels.instance }}"
				description: """
					The remote write connection between vmagent "{{ $labels.job }}" (instance {{ $labels.instance }}) and destination "{{ $labels.url }}" is saturated by more than 90% and vmagent won't be able to keep up.
					 There could be the following reasons for this:
					 * vmagent can't send data fast enough through the existing network connections. Increase `-remoteWrite.queues` cmd-line flag value to establish more connections per destination.
					 * remote destination can't accept data fast enough. Check if remote destination has enough resources for processing.
					"""
				summary: "Remote write connection from \"{{ $labels.job }}\" (instance {{ $labels.instance }}) to {{ $labels.url }} is saturated"
			}
			expr: "(rate(vmagent_remotewrite_send_duration_seconds_total[5m]) / vmagent_remotewrite_queues) > 0.9"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "PersistentQueueForWritesIsSaturated"
			annotations: {
				dashboard:   "{{ $externalURL }}/d/G7Z9GzMGz?viewPanel=98&var-instance={{ $labels.instance }}"
				description: "Persistent queue writes for vmagent \"{{ $labels.job }}\" (instance {{ $labels.instance }}) are saturated by more than 90% and vmagent won't be able to keep up with flushing data on disk. In this case, consider to decrease load on the vmagent or improve the disk throughput."
				summary:     "Persistent queue writes for instance {{ $labels.instance }} are saturated"
			}
			expr: "rate(vm_persistentqueue_write_duration_seconds_total[5m]) > 0.9"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "PersistentQueueForReadsIsSaturated"
			annotations: {
				dashboard:   "{{ $externalURL }}/d/G7Z9GzMGz?viewPanel=99&var-instance={{ $labels.instance }}"
				description: "Persistent queue reads for vmagent \"{{ $labels.job }}\" (instance {{ $labels.instance }}) are saturated by more than 90% and vmagent won't be able to keep up with reading data from the disk. In this case, consider to decrease load on the vmagent or improve the disk throughput."
				summary:     "Persistent queue reads for instance {{ $labels.instance }} are saturated"
			}
			expr: "rate(vm_persistentqueue_read_duration_seconds_total[5m]) > 0.9"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "SeriesLimitHourReached"
			annotations: {
				dashboard:   "{{ $externalURL }}/d/G7Z9GzMGz?viewPanel=88&var-instance={{ $labels.instance }}"
				description: "Max series limit set via -remoteWrite.maxHourlySeries flag is close to reaching the max value. Then samples for new time series will be dropped instead of sending them to remote storage systems."
				summary:     "Instance {{ $labels.instance }} reached 90% of the limit"
			}
			expr: "(vmagent_hourly_series_limit_current_series / vmagent_hourly_series_limit_max_series) > 0.9"
			labels: severity: "critical"
		}, {
			alert: "SeriesLimitDayReached"
			annotations: {
				dashboard:   "{{ $externalURL }}/d/G7Z9GzMGz?viewPanel=90&var-instance={{ $labels.instance }}"
				description: "Max series limit set via -remoteWrite.maxDailySeries flag is close to reaching the max value. Then samples for new time series will be dropped instead of sending them to remote storage systems."
				summary:     "Instance {{ $labels.instance }} reached 90% of the limit"
			}
			expr: "(vmagent_daily_series_limit_current_series / vmagent_daily_series_limit_max_series) > 0.9"
			labels: severity: "critical"
		}, {
			alert: "ConfigurationReloadFailure"
			annotations: {
				description: "Configuration hot-reload failed for vmagent on instance {{ $labels.instance }}. Check vmagent's logs for detailed error message."
				summary:     "Configuration reload failed for vmagent instance {{ $labels.instance }}"
			}
			expr: "(vm_promscrape_config_last_reload_successful != 1) or (vmagent_relabel_config_last_reload_successful != 1)"
			labels: severity: "warning"
		}, {
			alert: "StreamAggrFlushTimeout"
			annotations: {
				description: "Stream aggregation process can't keep up with the load and might produce incorrect aggregation results. Check logs for more details. Possible solutions: increase aggregation interval; aggregate smaller number of series; reduce samples' ingestion rate to stream aggregation."
				summary:     "Streaming aggregation at \"{{ $labels.job }}\" (instance {{ $labels.instance }}) can't be finished within the configured aggregation interval."
			}
			expr: "increase(vm_streamaggr_flush_timeouts_total[5m]) > 0"
			labels: severity: "warning"
		}, {
			alert: "StreamAggrDedupFlushTimeout"
			annotations: {
				description: "Deduplication process can't keep up with the load and might produce incorrect results. Check docs https://docs.victoriametrics.com/victoriametrics/stream-aggregation/#deduplication and logs for more details. Possible solutions: increase deduplication interval; deduplicate smaller number of series; reduce samples' ingestion rate."
				summary:     "Deduplication \"{{ $labels.job }}\" (instance {{ $labels.instance }}) can't be finished within configured deduplication interval."
			}
			expr: "increase(vm_streamaggr_dedup_flush_timeouts_total[5m]) > 0"
			labels: severity: "warning"
		}, {
			alert: "PersistentQueueRunsOutOfSpaceIn12Hours"
			annotations: {
				description: "RemoteWrite destination ({{ $labels.url }}) is unavailable or unable to receive data in a timely manner, so the persistent queue size is growing. Once the available space is exhausted, some samples will be discarded and cause incident. Please check the health of remoteWrite destination ({{ $labels.url }})."
				summary:     "Persistent Queue (url {{ $labels.url }}) of {{ $labels.instance }} (job:{{ $labels.job }}) will run out of space in 12 hours."
			}
			expr: "(((sum(vm_persistentqueue_free_disk_space_bytes) by(job,instance,path,cluster) / (sum(deriv(vm_persistentqueue_bytes_pending[1m])) by(job,instance,path,cluster) > 0)) * on(job,instance,path,cluster) group_left(url) ((vmagent_remotewrite_pending_data_bytes * 0) + 1)) < 43200) > 0"
			for:  "10m"
			labels: severity: "warning"
		}, {
			alert: "PersistentQueueRunsOutOfSpaceIn4Hours"
			annotations: {
				description: "RemoteWrite destination ({{ $labels.url }}) is unavailable or unable to receive data in a timely manner, so the persistent queue size is growing. Once the available space is exhausted, some samples will be discarded and cause incident. Please check the health of remoteWrite destination ({{ $labels.url }})."
				summary:     "Persistent Queue (url {{ $labels.url }}) of {{ $labels.instance }} (job:{{ $labels.job }}) will run out of space in 4 hours."
			}
			expr: "(((sum(vm_persistentqueue_free_disk_space_bytes) by(job,instance,path,cluster) / (sum(deriv(vm_persistentqueue_bytes_pending[1m])) by(job,instance,path,cluster) > 0)) * on(job,instance,path,cluster) group_left(url) ((vmagent_remotewrite_pending_data_bytes * 0) + 1)) < 14400) > 0"
			for:  "10m"
			labels: severity: "critical"
		}]
	}]
}, {
	metadata: name: "vmalert"
	spec: groups: [{
		interval: "30s"
		name:     "vmalert"
		rules: [{
			alert: "ConfigurationReloadFailure"
			annotations: {
				description: "Configuration hot-reload failed for vmalert on instance {{ $labels.instance }}. Check vmalert's logs for detailed error message."
				summary:     "Configuration reload failed for vmalert instance {{ $labels.instance }}"
			}
			expr: "vmalert_config_last_reload_successful != 1"
			labels: severity: "warning"
		}, {
			alert: "AlertingRulesError"
			annotations: {
				dashboard:   "{{ $externalURL }}/d/LzldHAVnz?viewPanel=13&var-instance={{ $labels.instance }}&var-file={{ $labels.file }}&var-group={{ $labels.group }}"
				description: "Alerting rules execution is failing for \"{{ $labels.alertname }}\" from group \"{{ $labels.group }}\" in file \"{{ $labels.file }}\". Check vmalert's logs for detailed error message."
				summary:     "Alerting rules are failing for vmalert instance {{ $labels.instance }}"
			}
			expr: "sum(increase(vmalert_alerting_rules_errors_total[5m])) without(id) > 0"
			for:  "5m"
			labels: severity: "warning"
		}, {
			alert: "RecordingRulesError"
			annotations: {
				dashboard:   "{{ $externalURL }}/d/LzldHAVnz?viewPanel=30&var-instance={{ $labels.instance }}&var-file={{ $labels.file }}&var-group={{ $labels.group }}"
				description: "Recording rules execution is failing for \"{{ $labels.recording }}\" from group \"{{ $labels.group }}\" in file \"{{ $labels.file }}\". Check vmalert's logs for detailed error message."
				summary:     "Recording rules are failing for vmalert instance {{ $labels.instance }}"
			}
			expr: "sum(increase(vmalert_recording_rules_errors_total[5m])) without(id) > 0"
			for:  "5m"
			labels: severity: "warning"
		}, {
			alert: "RecordingRulesNoData"
			annotations: {
				dashboard:   "{{ $externalURL }}/d/LzldHAVnz?viewPanel=33&var-file={{ $labels.file }}&var-group={{ $labels.group }}"
				description: "Recording rule \"{{ $labels.recording }}\" from group \"{{ $labels.group }} in file \"{{ $labels.file }}\" produces 0 samples over the last 30min. It might be caused by a misconfiguration or incorrect query expression."
				summary:     "Recording rule {{ $labels.recording }} ({{ $labels.group }}) produces no data"
			}
			expr: "sum(vmalert_recording_rules_last_evaluation_samples) without(id) < 1"
			for:  "30m"
			labels: severity: "info"
		}, {
			alert: "TooManyMissedIterations"
			annotations: {
				description: "vmalert instance {{ $labels.instance }} is missing rules evaluations for group \"{{ $labels.group }}\" in file \"{{ $labels.file }}\". The group evaluation time takes longer than the configured evaluation interval. This may result in missed alerting notifications or recording rules samples. Try increasing evaluation interval or concurrency of group \"{{ $labels.group }}\". See https://docs.victoriametrics.com/victoriametrics/vmalert/#groups. If rule expressions are taking longer than expected, please see https://docs.victoriametrics.com/victoriametrics/troubleshooting/#slow-queries."
				summary:     "vmalert instance {{ $labels.instance }} is missing rules evaluations"
			}
			expr: "increase(vmalert_iteration_missed_total[5m]) > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "RemoteWriteErrors"
			annotations: {
				description: "vmalert instance {{ $labels.instance }} is failing to push metrics generated via alerting or recording rules to the configured remote write URL. Check vmalert's logs for detailed error message."
				summary:     "vmalert instance {{ $labels.instance }} is failing to push metrics to remote write URL"
			}
			expr: "increase(vmalert_remotewrite_errors_total[5m]) > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "RemoteWriteDroppingData"
			annotations: {
				description: "vmalert instance {{ $labels.instance }} is failing to send results of alerting or recording rules to the configured remote write URL. This may result into gaps in recording rules or alerts state. Check vmalert's logs for detailed error message."
				summary:     "vmalert instance {{ $labels.instance }} is dropping data sent to remote write URL"
			}
			expr: "increase(vmalert_remotewrite_dropped_rows_total[5m]) > 0"
			for:  "5m"
			labels: severity: "critical"
		}, {
			alert: "AlertmanagerErrors"
			annotations: {
				description: "vmalert instance {{ $labels.instance }} is failing to send alert notifications to \"{{ $labels.addr }}\". Check vmalert's logs for detailed error message."
				summary:     "vmalert instance {{ $labels.instance }} is failing to send notifications to Alertmanager"
			}
			expr: "increase(vmalert_alerts_send_errors_total[5m]) > 0"
			for:  "15m"
			labels: severity: "warning"
		}]
	}]
}, {
	metadata: name: "vmcluster"
	spec: groups: [{
		concurrency: 2
		interval:    "30s"
		name:        "vmcluster"
		rules: [{
			alert: "DiskRunsOutOfSpaceIn3Days"
			annotations: {
				dashboard: "{{ $externalURL }}/d/oS7Bi_0Wz?viewPanel=20&var-instance={{ $labels.instance }}"
				description: """
					Taking into account current ingestion rate, free disk space will be enough only for {{ $value | humanizeDuration }} on instance {{ $labels.instance }}.
					 Consider to limit the ingestion rate, decrease retention or scale the disk space up if possible.
					"""
				summary: "Instance {{ $labels.instance }} will run out of disk space in 3 days"
			}
			expr: "((sum(vm_free_disk_space_bytes) without(path) / (((rate(vm_rows_added_to_storage_total[1d]) - sum(rate(vm_deduplicated_samples_total[1d])) without(type)) * (sum(vm_data_size_bytes{type!~\"indexdb.*\"}) without(type) / sum(vm_rows{type!~\"indexdb.*\"}) without(type))) + (rate(vm_new_timeseries_created_total[1d]) * (sum(vm_data_size_bytes{type=\"indexdb/file\"}) without(type) / sum(vm_rows{type=\"indexdb/file\"}) without(type))))) < 259200) > 0"
			for:  "30m"
			labels: severity: "critical"
		}, {
			alert: "NodeBecomesReadonlyIn3Days"
			annotations: {
				dashboard: "{{ $externalURL }}/d/oS7Bi_0Wz?viewPanel=20&var-instance={{ $labels.instance }}"
				description: """
					Taking into account current ingestion rate, free disk space and -storage.minFreeDiskSpaceBytes instance {{ $labels.instance }} will remain writable for {{ $value | humanizeDuration }}.
					 Consider to limit the ingestion rate, decrease retention or scale the disk space up if possible.
					"""
				summary: "Instance {{ $labels.instance }} will become read-only in 3 days"
			}
			expr: "((sum(vm_free_disk_space_bytes - vm_free_disk_space_limit_bytes) without(path) / (((rate(vm_rows_added_to_storage_total[1d]) - sum(rate(vm_deduplicated_samples_total[1d])) without(type)) * (sum(vm_data_size_bytes{type!~\"indexdb.*\"}) without(type) / sum(vm_rows{type!~\"indexdb.*\"}) without(type))) + (rate(vm_new_timeseries_created_total[1d]) * (sum(vm_data_size_bytes{type=\"indexdb/file\"}) without(type) / sum(vm_rows{type=\"indexdb/file\"}) without(type))))) < 259200) > 0"
			for:  "30m"
			labels: severity: "warning"
		}, {
			alert: "DiskRunsOutOfSpace"
			annotations: {
				dashboard: "{{ $externalURL }}/d/oS7Bi_0Wz?viewPanel=20&var-instance={{ $labels.instance }}"
				description: """
					Disk utilisation on instance {{ $labels.instance }} is more than 80%.
					 Having less than 20% of free disk space could cripple merges processes and overall performance. Consider to limit the ingestion rate, decrease retention or scale the disk space if possible.
					"""
				summary: "Instance {{ $labels.instance }} (job={{ $labels.job }}) will run out of disk space soon"
			}
			expr: "(sum(vm_data_size_bytes) by(job,instance,cluster) / (sum(vm_free_disk_space_bytes) by(job,instance,cluster) + sum(vm_data_size_bytes) by(job,instance,cluster))) > 0.8"
			for:  "30m"
			labels: severity: "critical"
		}, {
			alert: "RequestErrorsToAPI"
			annotations: {
				dashboard:   "{{ $externalURL }}/d/oS7Bi_0Wz?viewPanel=52&var-instance={{ $labels.instance }}"
				description: "Requests to path {{ $labels.path }} are receiving errors. Please verify if clients are sending correct requests."
				summary:     "Too many errors served for {{ $labels.job }} path {{ $labels.path }} (instance {{ $labels.instance }})"
			}
			expr: "increase(vm_http_request_errors_total[5m]) > 0"
			for:  "15m"
			labels: {
				severity: "warning"
				show_at:  "dashboard"
			}
		}, {
			alert: "RPCErrors"
			annotations: {
				dashboard: "{{ $externalURL }}/d/oS7Bi_0Wz?viewPanel=44&var-instance={{ $labels.instance }}"
				description: """
					RPC errors are interconnection errors between cluster components.
					 Possible reasons for errors are misconfiguration, overload, network blips or unreachable components.
					"""
				summary: "Too many RPC errors for {{ $labels.job }} (instance {{ $labels.instance }})"
			}
			expr: "((sum(increase(vm_rpc_connection_errors_total[5m])) by(job,instance,cluster) + sum(increase(vm_rpc_dial_errors_total[5m])) by(job,instance,cluster)) + sum(increase(vm_rpc_handshake_errors_total[5m])) by(job,instance,cluster)) > 0"
			for:  "15m"
			labels: {
				severity: "warning"
				show_at:  "dashboard"
			}
		}, {
			alert: "TooHighChurnRate"
			annotations: {
				dashboard: "{{ $externalURL }}/d/oS7Bi_0Wz?viewPanel=102"
				description: """
					VM constantly creates new time series.
					 This effect is known as Churn Rate.
					 High Churn Rate tightly connected with database performance and may result in unexpected OOM's or slow queries.
					"""
				summary: "Churn rate is more than 10% for the last 15m"
			}
			expr: "(sum(rate(vm_new_timeseries_created_total[5m])) by(job,cluster) / sum(rate(vm_rows_inserted_total[5m])) by(job,cluster)) > 0.1"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "TooHighChurnRate24h"
			annotations: {
				dashboard: "{{ $externalURL }}/d/oS7Bi_0Wz?viewPanel=102"
				description: """
					The number of created new time series over last 24h is 3x times higher than current number of active series.
					 This effect is known as Churn Rate.
					 High Churn Rate tightly connected with database performance and may result in unexpected OOM's or slow queries.
					"""
				summary: "Too high number of new series created over last 24h"
			}
			expr: "sum(increase(vm_new_timeseries_created_total[24h])) by(job,cluster) > (sum(vm_cache_entries{type=\"storage/hour_metric_ids\"}) by(job,cluster) * 3)"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "TooHighSlowInsertsRate"
			annotations: {
				dashboard:   "{{ $externalURL }}/d/oS7Bi_0Wz?viewPanel=108"
				description: "High rate of slow inserts may be a sign of resource exhaustion for the current load. It is likely more RAM is needed for optimal handling of the current number of active time series. See also https://github.com/VictoriaMetrics/VictoriaMetrics/issues/3976#issuecomment-1476883183"
				summary:     "Percentage of slow inserts is more than 5% for the last 15m"
			}
			expr: "(sum(rate(vm_slow_row_inserts_total[5m])) by(job,cluster) / sum(rate(vm_rows_inserted_total[5m])) by(job,cluster)) > 0.05"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "VminsertVmstorageConnectionIsSaturated"
			annotations: {
				dashboard: "{{ $externalURL }}/d/oS7Bi_0Wz?viewPanel=139&var-instance={{ $labels.instance }}"
				description: """
					The connection between vminsert (instance {{ $labels.instance }}) and vmstorage (instance {{ $labels.addr }}) is saturated by more than 90% and vminsert won't be able to keep up.
					 This usually means that more vminsert or vmstorage nodes must be added to the cluster in order to increase the total number of vminsert -> vmstorage links.
					"""
				summary: "Connection between vminsert on {{ $labels.instance }} and vmstorage on {{ $labels.addr }} is saturated"
			}
			expr: "rate(vm_rpc_send_duration_seconds_total[5m]) > 0.9"
			for:  "15m"
			labels: {
				severity: "warning"
				show_at:  "dashboard"
			}
		}]
	}]
}, {
	metadata: name: "vmoperator"
	spec: groups: [{
		name: "vmoperator"
		rules: [{
			alert: "LogErrors"
			annotations: {
				dashboard:   "{{ $externalURL }}/d/1H179hunk/victoriametrics-operator?ds={{ $labels.dc }}&orgId=1&viewPanel=16"
				description: "Operator has too many errors at logs: {{ $value}}, check operator logs"
				summary:     "Too many errors at logs of operator: {{ $value}}"
			}
			expr: "sum(rate(operator_log_messages_total{level=\"error\",job=~\".*((victoria.*)|vm)-?operator\"}[5m])) by(cluster) > 0"
			for:  "15m"
			labels: {
				severity: "warning"
				show_at:  "dashboard"
			}
		}, {
			alert: "ReconcileErrors"
			annotations: {
				dashboard:   "{{ $externalURL }}/d/1H179hunk/victoriametrics-operator?ds={{ $labels.dc }}&orgId=1&viewPanel=10"
				description: "Operator cannot parse response from k8s api server, possible bug: {{ $value }}, check operator logs"
				summary:     "Too many errors at reconcile loop of operator: {{ $value}}"
			}
			expr: "sum(rate(controller_runtime_reconcile_errors_total{job=~\".*((victoria.*)|vm)-?operator\"}[5m])) by(cluster) > 0"
			for:  "10m"
			labels: {
				severity: "warning"
				show_at:  "dashboard"
			}
		}, {
			alert: "HighQueueDepth"
			annotations: {
				dashboard:   "{{ $externalURL }}/d/1H179hunk/victoriametrics-operator?ds={{ $labels.dc }}&orgId=1&viewPanel=20"
				description: "Operator cannot handle reconciliation load for controller: `{{- $labels.name }}`, current depth: {{ $value }}"
				summary:     "Too many `{{- $labels.name }}` in queue: {{ $value }}"
			}
			expr: "sum(workqueue_depth{job=~\".*((victoria.*)|vm)-?operator\",name=~\"(vmagent|vmalert|vmalertmanager|vmauth|vmcluster|vmnodescrape|vmpodscrape|vmprobe|vmrule|vmservicescrape|vmsingle|vmstaticscrape)\"}) by(name,cluster) > 10"
			for:  "15m"
			labels: {
				severity: "warning"
				show_at:  "dashboard"
			}
		}]
	}]
}, {
	metadata: name: "vmsingle"
	spec: groups: [{
		concurrency: 2
		interval:    "30s"
		name:        "vmsingle"
		rules: [{
			alert: "DiskRunsOutOfSpaceIn3Days"
			annotations: {
				dashboard: "{{ $externalURL }}/d/wNf0q_kZk?viewPanel=53&var-instance={{ $labels.instance }}"
				description: """
					Taking into account current ingestion rate, free disk space will be enough only for {{ $value | humanizeDuration }} on instance {{ $labels.instance }}.
					 Consider to limit the ingestion rate, decrease retention or scale the disk space if possible.
					"""
				summary: "Instance {{ $labels.instance }} will run out of disk space soon"
			}
			expr: "((sum(vm_free_disk_space_bytes) without(path) / (((rate(vm_rows_added_to_storage_total[1d]) - sum(rate(vm_deduplicated_samples_total[1d])) without(type)) * (sum(vm_data_size_bytes{type!~\"indexdb.*\"}) without(type) / sum(vm_rows{type!~\"indexdb.*\"}) without(type))) + (rate(vm_new_timeseries_created_total[1d]) * (sum(vm_data_size_bytes{type=\"indexdb/file\"}) without(type) / sum(vm_rows{type=\"indexdb/file\"}) without(type))))) < 259200) > 0"
			for:  "30m"
			labels: severity: "critical"
		}, {
			alert: "NodeBecomesReadonlyIn3Days"
			annotations: {
				dashboard: "{{ $externalURL }}/d/oS7Bi_0Wz?viewPanel=53&var-instance={{ $labels.instance }}"
				description: """
					Taking into account current ingestion rate and free disk space instance {{ $labels.instance }} is writable for {{ $value | humanizeDuration }}.
					 Consider to limit the ingestion rate, decrease retention or scale the disk space up if possible.
					"""
				summary: "Instance {{ $labels.instance }} will become read-only in 3 days"
			}
			expr: "((sum(vm_free_disk_space_bytes - vm_free_disk_space_limit_bytes) without(path) / (((rate(vm_rows_added_to_storage_total[1d]) - sum(rate(vm_deduplicated_samples_total[1d])) without(type)) * (sum(vm_data_size_bytes{type!~\"indexdb.*\"}) without(type) / sum(vm_rows{type!~\"indexdb.*\"}) without(type))) + (rate(vm_new_timeseries_created_total[1d]) * (sum(vm_data_size_bytes{type=\"indexdb/file\"}) without(type) / sum(vm_rows{type=\"indexdb/file\"}) without(type))))) < 259200) > 0"
			for:  "30m"
			labels: severity: "warning"
		}, {
			alert: "DiskRunsOutOfSpace"
			annotations: {
				dashboard: "{{ $externalURL }}/d/wNf0q_kZk?viewPanel=53&var-instance={{ $labels.instance }}"
				description: """
					Disk utilisation on instance {{ $labels.instance }} is more than 80%.
					 Having less than 20% of free disk space could cripple merge processes and overall performance. Consider to limit the ingestion rate, decrease retention or scale the disk space if possible.
					"""
				summary: "Instance {{ $labels.instance }} (job={{ $labels.job }}) will run out of disk space soon"
			}
			expr: "(sum(vm_data_size_bytes) by(job,instance,cluster) / (sum(vm_free_disk_space_bytes) by(job,instance,cluster) + sum(vm_data_size_bytes) by(job,instance,cluster))) > 0.8"
			for:  "30m"
			labels: severity: "critical"
		}, {
			alert: "RequestErrorsToAPI"
			annotations: {
				dashboard:   "{{ $externalURL }}/d/wNf0q_kZk?viewPanel=35&var-instance={{ $labels.instance }}"
				description: "Requests to path {{ $labels.path }} are receiving errors. Please verify if clients are sending correct requests."
				summary:     "Too many errors served for path {{ $labels.path }} (instance {{ $labels.instance }})"
			}
			expr: "increase(vm_http_request_errors_total[5m]) > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "TooHighChurnRate"
			annotations: {
				dashboard: "{{ $externalURL }}/d/wNf0q_kZk?viewPanel=66&var-instance={{ $labels.instance }}"
				description: """
					VM constantly creates new time series on "{{ $labels.instance }}".
					 This effect is known as Churn Rate.
					 High Churn Rate is tightly connected with database performance and may result in unexpected OOM's or slow queries.
					"""
				summary: "Churn rate is more than 10% on \"{{ $labels.instance }}\" for the last 15m"
			}
			expr: "(sum(rate(vm_new_timeseries_created_total[5m])) by(instance,cluster) / sum(rate(vm_rows_inserted_total[5m])) by(instance,cluster)) > 0.1"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "TooHighChurnRate24h"
			annotations: {
				dashboard: "{{ $externalURL }}/d/wNf0q_kZk?viewPanel=66&var-instance={{ $labels.instance }}"
				description: """
					The number of created new time series over last 24h is 3x times higher than current number of active series on "{{ $labels.instance }}".
					 This effect is known as Churn Rate.
					 High Churn Rate is tightly connected with database performance and may result in unexpected OOM's or slow queries.
					"""
				summary: "Too high number of new series on \"{{ $labels.instance }}\" created over last 24h"
			}
			expr: "sum(increase(vm_new_timeseries_created_total[24h])) by(instance,cluster) > (sum(vm_cache_entries{type=\"storage/hour_metric_ids\"}) by(instance,cluster) * 3)"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "TooHighSlowInsertsRate"
			annotations: {
				dashboard:   "{{ $externalURL }}/d/wNf0q_kZk?viewPanel=68&var-instance={{ $labels.instance }}"
				description: "High rate of slow inserts on \"{{ $labels.instance }}\" may be a sign of resource exhaustion for the current load. It is likely more RAM is needed for optimal handling of the current number of active time series. See also https://github.com/VictoriaMetrics/VictoriaMetrics/issues/3976#issuecomment-1476883183"
				summary:     "Percentage of slow inserts is more than 5% on \"{{ $labels.instance }}\" for the last 15m"
			}
			expr: "(sum(rate(vm_slow_row_inserts_total[5m])) by(instance,cluster) / sum(rate(vm_rows_inserted_total[5m])) by(instance,cluster)) > 0.05"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "MetadataCacheUtilizationIsTooHigh"
			annotations: {
				description: "Metadata cache stores meta information about ingested time series - see https://docs.victoriametrics.com/victoriametrics/#metrics-metadata. When cache is overutilized, the oldest entries will be dropped out automatically. It may result into incomplete response for /api/v1/metadata API calls. It doesn't impact regular queries or alerts. Cache size is controlled via -storage.maxMetadataStorageSize cmd-line flag."
				summary:     "Metadata cache capacity on {{ $labels.instance }} (job={{ $labels.job }}) is utilized for more than 95% for the last 15min"
			}
			expr: "(vm_metrics_metadata_storage_size_bytes / vm_metrics_metadata_storage_max_size_bytes) > 0.95"
			for:  "15m"
			labels: severity: "warning"
		}]
	}]
}]
