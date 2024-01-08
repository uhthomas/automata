package vm

import victoriametricsv1beta1 "github.com/VictoriaMetrics/operator/api/victoriametrics/v1beta1"

#VMRuleList: victoriametricsv1beta1.#VMRuleList & {
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
			expr: """
				# Without max_over_time, failed scrapes could create false negatives, see
				# https://www.robustperception.io/alerting-on-gauges-in-prometheus-2-0 for details.
				max_over_time(alertmanager_config_last_reload_successful{job=\"vmalertmanager-vm-victoria-metrics-k8s-stack\",namespace=\"vmnamespace\"}[5m]) == 0
				"""

			for: "10m"
			labels: severity: "critical"
		}, {
			alert: "AlertmanagerMembersInconsistent"
			annotations: {
				description: "Alertmanager {{ $labels.namespace }}/{{ $labels.pod}} has only found {{ $value }} members of the {{$labels.job}} cluster."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/alertmanager/alertmanagermembersinconsistent"
				summary:     "A member of an Alertmanager cluster has not found all other cluster members."
			}
			expr: """
				# Without max_over_time, failed scrapes could create false negatives, see
				# https://www.robustperception.io/alerting-on-gauges-in-prometheus-2-0 for details.
				  max_over_time(alertmanager_cluster_members{job=\"vmalertmanager-vm-victoria-metrics-k8s-stack\",namespace=\"vmnamespace\"}[5m])
				< on (namespace,service) group_left
				  count by (namespace,service) (max_over_time(alertmanager_cluster_members{job=\"vmalertmanager-vm-victoria-metrics-k8s-stack\",namespace=\"vmnamespace\"}[5m]))
				"""

			for: "15m"
			labels: severity: "critical"
		}, {
			alert: "AlertmanagerFailedToSendAlerts"
			annotations: {
				description: "Alertmanager {{ $labels.namespace }}/{{ $labels.pod}} failed to send {{ $value | humanizePercentage }} of notifications to {{ $labels.integration }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/alertmanager/alertmanagerfailedtosendalerts"
				summary:     "An Alertmanager instance failed to send notifications."
			}
			expr: """
				(
				  rate(alertmanager_notifications_failed_total{job=\"vmalertmanager-vm-victoria-metrics-k8s-stack\",namespace=\"vmnamespace\"}[5m])
				/
				  rate(alertmanager_notifications_total{job=\"vmalertmanager-vm-victoria-metrics-k8s-stack\",namespace=\"vmnamespace\"}[5m])
				)
				> 0.01
				"""

			for: "5m"
			labels: severity: "warning"
		}, {
			alert: "AlertmanagerClusterFailedToSendAlerts"
			annotations: {
				description: "The minimum notification failure rate to {{ $labels.integration }} sent from any instance in the {{$labels.job}} cluster is {{ $value | humanizePercentage }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/alertmanager/alertmanagerclusterfailedtosendalerts"
				summary:     "All Alertmanager instances in a cluster failed to send notifications to a critical integration."
			}
			expr: """
				min by (namespace,service, integration) (
				  rate(alertmanager_notifications_failed_total{job=\"vmalertmanager-vm-victoria-metrics-k8s-stack\",namespace=\"vmnamespace\", integration=~`.*`}[5m])
				/
				  rate(alertmanager_notifications_total{job=\"vmalertmanager-vm-victoria-metrics-k8s-stack\",namespace=\"vmnamespace\", integration=~`.*`}[5m])
				)
				> 0.01
				"""

			for: "5m"
			labels: severity: "critical"
		}, {
			alert: "AlertmanagerClusterFailedToSendAlerts"
			annotations: {
				description: "The minimum notification failure rate to {{ $labels.integration }} sent from any instance in the {{$labels.job}} cluster is {{ $value | humanizePercentage }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/alertmanager/alertmanagerclusterfailedtosendalerts"
				summary:     "All Alertmanager instances in a cluster failed to send notifications to a non-critical integration."
			}
			expr: """
				min by (namespace,service, integration) (
				  rate(alertmanager_notifications_failed_total{job=\"vmalertmanager-vm-victoria-metrics-k8s-stack\",namespace=\"vmnamespace\", integration!~`.*`}[5m])
				/
				  rate(alertmanager_notifications_total{job=\"vmalertmanager-vm-victoria-metrics-k8s-stack\",namespace=\"vmnamespace\", integration!~`.*`}[5m])
				)
				> 0.01
				"""

			for: "5m"
			labels: severity: "warning"
		}, {
			alert: "AlertmanagerConfigInconsistent"
			annotations: {
				description: "Alertmanager instances within the {{$labels.job}} cluster have different configurations."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/alertmanager/alertmanagerconfiginconsistent"
				summary:     "Alertmanager instances within the same cluster have different configurations."
			}
			expr: """
				count by (namespace,service) (
				  count_values by (namespace,service) (\"config_hash\", alertmanager_config_hash{job=\"vmalertmanager-vm-victoria-metrics-k8s-stack\",namespace=\"vmnamespace\"})
				)
				!= 1
				"""

			for: "20m"
			labels: severity: "critical"
		}, {
			alert: "AlertmanagerClusterDown"
			annotations: {
				description: "{{ $value | humanizePercentage }} of Alertmanager instances within the {{$labels.job}} cluster have been up for less than half of the last 5m."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/alertmanager/alertmanagerclusterdown"
				summary:     "Half or more of the Alertmanager instances within the same cluster are down."
			}
			expr: """
				(
				  count by (namespace,service) (
				    avg_over_time(up{job=\"vmalertmanager-vm-victoria-metrics-k8s-stack\",namespace=\"vmnamespace\"}[5m]) < 0.5
				  )
				/
				  count by (namespace,service) (
				    up{job=\"vmalertmanager-vm-victoria-metrics-k8s-stack\",namespace=\"vmnamespace\"}
				  )
				)
				>= 0.5
				"""

			for: "5m"
			labels: severity: "critical"
		}, {
			alert: "AlertmanagerClusterCrashlooping"
			annotations: {
				description: "{{ $value | humanizePercentage }} of Alertmanager instances within the {{$labels.job}} cluster have restarted at least 5 times in the last 10m."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/alertmanager/alertmanagerclustercrashlooping"
				summary:     "Half or more of the Alertmanager instances within the same cluster are crashlooping."
			}
			expr: """
				(
				  count by (namespace,service) (
				    changes(process_start_time_seconds{job=\"vmalertmanager-vm-victoria-metrics-k8s-stack\",namespace=\"vmnamespace\"}[10m]) > 4
				  )
				/
				  count by (namespace,service) (
				    up{job=\"vmalertmanager-vm-victoria-metrics-k8s-stack\",namespace=\"vmnamespace\"}
				  )
				)
				>= 0.5
				"""

			for: "5m"
			labels: severity: "critical"
		}]
	}]
}, {
	metadata: name: "etcd"
	spec: groups: [{
		name: "etcd"
		rules: [{
			alert: "etcdInsufficientMembers"
			annotations: message: "etcd cluster \"{{ $labels.job }}\": insufficient members ({{ $value }})."
			expr: "sum(up{job=~\".*etcd.*\"} == bool 1) by (job) < ((count(up{job=~\".*etcd.*\"}) by (job) + 1) / 2)"
			for:  "3m"
			labels: severity: "critical"
		}, {
			alert: "etcdNoLeader"
			annotations: message: "etcd cluster \"{{ $labels.job }}\": member {{ $labels.instance }} has no leader."
			expr: "etcd_server_has_leader{job=~\".*etcd.*\"} == 0"
			for:  "1m"
			labels: severity: "critical"
		}, {
			alert: "etcdHighNumberOfLeaderChanges"
			annotations: message: "etcd cluster \"{{ $labels.job }}\": instance {{ $labels.instance }} has seen {{ $value }} leader changes within the last hour."
			expr: "rate(etcd_server_leader_changes_seen_total{job=~\".*etcd.*\"}[15m]) > 3"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "etcdHighNumberOfFailedGRPCRequests"
			annotations: message: "etcd cluster \"{{ $labels.job }}\": {{ $value }}% of requests for {{ $labels.grpc_method }} failed on etcd instance {{ $labels.instance }}."
			expr: """
				100 * sum(rate(grpc_server_handled_total{job=~\".*etcd.*\", grpc_code!=\"OK\"}[5m])) BY (job, instance, grpc_service, grpc_method)
				  /
				sum(rate(grpc_server_handled_total{job=~\".*etcd.*\"}[5m])) BY (job, instance, grpc_service, grpc_method)
				  > 1
				"""

			for: "10m"
			labels: severity: "warning"
		}, {
			alert: "etcdHighNumberOfFailedGRPCRequests"
			annotations: message: "etcd cluster \"{{ $labels.job }}\": {{ $value }}% of requests for {{ $labels.grpc_method }} failed on etcd instance {{ $labels.instance }}."
			expr: """
				100 * sum(rate(grpc_server_handled_total{job=~\".*etcd.*\", grpc_code!=\"OK\"}[5m])) BY (job, instance, grpc_service, grpc_method)
				  /
				sum(rate(grpc_server_handled_total{job=~\".*etcd.*\"}[5m])) BY (job, instance, grpc_service, grpc_method)
				  > 5
				"""

			for: "5m"
			labels: severity: "critical"
		}, {
			alert: "etcdGRPCRequestsSlow"
			annotations: message: "etcd cluster \"{{ $labels.job }}\": gRPC requests to {{ $labels.grpc_method }} are taking {{ $value }}s on etcd instance {{ $labels.instance }}."
			expr: """
				histogram_quantile(0.99, sum(rate(grpc_server_handling_seconds_bucket{job=~\".*etcd.*\", grpc_type=\"unary\"}[5m])) by (job, instance, grpc_service, grpc_method, le))
				> 0.15
				"""

			for: "10m"
			labels: severity: "critical"
		}, {
			alert: "etcdMemberCommunicationSlow"
			annotations: message: "etcd cluster \"{{ $labels.job }}\": member communication with {{ $labels.To }} is taking {{ $value }}s on etcd instance {{ $labels.instance }}."
			expr: """
				histogram_quantile(0.99, rate(etcd_network_peer_round_trip_time_seconds_bucket{job=~\".*etcd.*\"}[5m]))
				> 0.15
				"""

			for: "10m"
			labels: severity: "warning"
		}, {
			alert: "etcdHighNumberOfFailedProposals"
			annotations: message: "etcd cluster \"{{ $labels.job }}\": {{ $value }} proposal failures within the last hour on etcd instance {{ $labels.instance }}."
			expr: "rate(etcd_server_proposals_failed_total{job=~\".*etcd.*\"}[15m]) > 5"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "etcdHighFsyncDurations"
			annotations: message: "etcd cluster \"{{ $labels.job }}\": 99th percentile fync durations are {{ $value }}s on etcd instance {{ $labels.instance }}."
			expr: """
				histogram_quantile(0.99, rate(etcd_disk_wal_fsync_duration_seconds_bucket{job=~\".*etcd.*\"}[5m]))
				> 0.5
				"""

			for: "10m"
			labels: severity: "warning"
		}, {
			alert: "etcdHighCommitDurations"
			annotations: message: "etcd cluster \"{{ $labels.job }}\": 99th percentile commit durations {{ $value }}s on etcd instance {{ $labels.instance }}."
			expr: """
				histogram_quantile(0.99, rate(etcd_disk_backend_commit_duration_seconds_bucket{job=~\".*etcd.*\"}[5m]))
				> 0.25
				"""

			for: "10m"
			labels: severity: "warning"
		}, {
			alert: "etcdHighNumberOfFailedHTTPRequests"
			annotations: message: "{{ $value }}% of requests for {{ $labels.method }} failed on etcd instance {{ $labels.instance }}"
			expr: """
				sum(rate(etcd_http_failed_total{job=~\".*etcd.*\", code!=\"404\"}[5m])) BY (method) / sum(rate(etcd_http_received_total{job=~\".*etcd.*\"}[5m]))
				BY (method) > 0.01
				"""

			for: "10m"
			labels: severity: "warning"
		}, {
			alert: "etcdHighNumberOfFailedHTTPRequests"
			annotations: message: "{{ $value }}% of requests for {{ $labels.method }} failed on etcd instance {{ $labels.instance }}."
			expr: """
				sum(rate(etcd_http_failed_total{job=~\".*etcd.*\", code!=\"404\"}[5m])) BY (method) / sum(rate(etcd_http_received_total{job=~\".*etcd.*\"}[5m]))
				BY (method) > 0.05
				"""

			for: "10m"
			labels: severity: "critical"
		}, {
			alert: "etcdHTTPRequestsSlow"
			annotations: message: "etcd instance {{ $labels.instance }} HTTP requests to {{ $labels.method }} are slow."
			expr: """
				histogram_quantile(0.99, rate(etcd_http_successful_duration_seconds_bucket[5m]))
				> 0.15
				"""

			for: "10m"
			labels: severity: "warning"
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
			expr: "100 * (count(up == 0) BY (job, namespace, service) / count(up) BY (job, namespace, service)) > 10"
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
					\"DeadMansSnitch\" integration in PagerDuty.

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
					This alert fires whenever there's a severity=\"info\" alert, and stops firing when another alert with a
					severity of 'warning' or 'critical' starts firing on the same namespace.
					This alert should be routed to a null receiver and configured to inhibit alerts with severity=\"info\".

					"""

				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/general/infoinhibitor"
				summary:     "Info-level alert inhibition."
			}
			expr: "ALERTS{severity = \"info\"} == 1 unless on(namespace) ALERTS{alertname != \"InfoInhibitor\", severity =~ \"warning|critical\", alertstate=\"firing\"} == 1"
			labels: severity: "none"
		}]
	}]
}, {
	metadata: name: "k8s.rules"
	spec: groups: [{
		name: "k8s.rules"
		rules: [{
			expr: """
				sum by (cluster, namespace, pod, container) (
				  irate(container_cpu_usage_seconds_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", image!=\"\"}[5m])
				) * on (cluster, namespace, pod) group_left(node) topk by (cluster, namespace, pod) (
				  1, max by(cluster, namespace, pod, node) (kube_pod_info{node!=\"\"})
				)
				"""

			record: "node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate"
		}, {
			expr: """
				container_memory_working_set_bytes{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", image!=\"\"}
				* on (cluster, namespace, pod) group_left(node) topk by(cluster, namespace, pod) (1,
				  max by(cluster, namespace, pod, node) (kube_pod_info{node!=\"\"})
				)
				"""

			record: "node_namespace_pod_container:container_memory_working_set_bytes"
		}, {
			expr: """
				container_memory_rss{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", image!=\"\"}
				* on (cluster, namespace, pod) group_left(node) topk by(cluster, namespace, pod) (1,
				  max by(cluster, namespace, pod, node) (kube_pod_info{node!=\"\"})
				)
				"""

			record: "node_namespace_pod_container:container_memory_rss"
		}, {
			expr: """
				container_memory_cache{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", image!=\"\"}
				* on (cluster, namespace, pod) group_left(node) topk by(cluster, namespace, pod) (1,
				  max by(cluster, namespace, pod, node) (kube_pod_info{node!=\"\"})
				)
				"""

			record: "node_namespace_pod_container:container_memory_cache"
		}, {
			expr: """
				container_memory_swap{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", image!=\"\"}
				* on (cluster, namespace, pod) group_left(node) topk by(cluster, namespace, pod) (1,
				  max by(cluster, namespace, pod, node) (kube_pod_info{node!=\"\"})
				)
				"""

			record: "node_namespace_pod_container:container_memory_swap"
		}, {
			expr: """
				kube_pod_container_resource_requests{resource=\"memory\",job=\"kube-state-metrics\"}  * on (namespace, pod, cluster)
				group_left() max by (namespace, pod, cluster) (
				  (kube_pod_status_phase{phase=~\"Pending|Running\"} == 1)
				)
				"""

			record: "cluster:namespace:pod_memory:active:kube_pod_container_resource_requests"
		}, {
			expr: """
				sum by (namespace, cluster) (
				    sum by (namespace, pod, cluster) (
				        max by (namespace, pod, container, cluster) (
				          kube_pod_container_resource_requests{resource=\"memory\",job=\"kube-state-metrics\"}
				        ) * on(namespace, pod, cluster) group_left() max by (namespace, pod, cluster) (
				          kube_pod_status_phase{phase=~\"Pending|Running\"} == 1
				        )
				    )
				)
				"""

			record: "namespace_memory:kube_pod_container_resource_requests:sum"
		}, {
			expr: """
				kube_pod_container_resource_requests{resource=\"cpu\",job=\"kube-state-metrics\"}  * on (namespace, pod, cluster)
				group_left() max by (namespace, pod, cluster) (
				  (kube_pod_status_phase{phase=~\"Pending|Running\"} == 1)
				)
				"""

			record: "cluster:namespace:pod_cpu:active:kube_pod_container_resource_requests"
		}, {
			expr: """
				sum by (namespace, cluster) (
				    sum by (namespace, pod, cluster) (
				        max by (namespace, pod, container, cluster) (
				          kube_pod_container_resource_requests{resource=\"cpu\",job=\"kube-state-metrics\"}
				        ) * on(namespace, pod, cluster) group_left() max by (namespace, pod, cluster) (
				          kube_pod_status_phase{phase=~\"Pending|Running\"} == 1
				        )
				    )
				)
				"""

			record: "namespace_cpu:kube_pod_container_resource_requests:sum"
		}, {
			expr: """
				kube_pod_container_resource_limits{resource=\"memory\",job=\"kube-state-metrics\"}  * on (namespace, pod, cluster)
				group_left() max by (namespace, pod, cluster) (
				  (kube_pod_status_phase{phase=~\"Pending|Running\"} == 1)
				)
				"""

			record: "cluster:namespace:pod_memory:active:kube_pod_container_resource_limits"
		}, {
			expr: """
				sum by (namespace, cluster) (
				    sum by (namespace, pod, cluster) (
				        max by (namespace, pod, container, cluster) (
				          kube_pod_container_resource_limits{resource=\"memory\",job=\"kube-state-metrics\"}
				        ) * on(namespace, pod, cluster) group_left() max by (namespace, pod, cluster) (
				          kube_pod_status_phase{phase=~\"Pending|Running\"} == 1
				        )
				    )
				)
				"""

			record: "namespace_memory:kube_pod_container_resource_limits:sum"
		}, {
			expr: """
				kube_pod_container_resource_limits{resource=\"cpu\",job=\"kube-state-metrics\"}  * on (namespace, pod, cluster)
				group_left() max by (namespace, pod, cluster) (
				 (kube_pod_status_phase{phase=~\"Pending|Running\"} == 1)
				 )
				"""

			record: "cluster:namespace:pod_cpu:active:kube_pod_container_resource_limits"
		}, {
			expr: """
				sum by (namespace, cluster) (
				    sum by (namespace, pod, cluster) (
				        max by (namespace, pod, container, cluster) (
				          kube_pod_container_resource_limits{resource=\"cpu\",job=\"kube-state-metrics\"}
				        ) * on(namespace, pod, cluster) group_left() max by (namespace, pod, cluster) (
				          kube_pod_status_phase{phase=~\"Pending|Running\"} == 1
				        )
				    )
				)
				"""

			record: "namespace_cpu:kube_pod_container_resource_limits:sum"
		}, {
			expr: """
				max by (cluster, namespace, workload, pod) (
				  label_replace(
				    label_replace(
				      kube_pod_owner{job=\"kube-state-metrics\", owner_kind=\"ReplicaSet\"},
				      \"replicaset\", \"$1\", \"owner_name\", \"(.*)\"
				    ) * on(replicaset, namespace) group_left(owner_name) topk by(replicaset, namespace) (
				      1, max by (replicaset, namespace, owner_name) (
				        kube_replicaset_owner{job=\"kube-state-metrics\"}
				      )
				    ),
				    \"workload\", \"$1\", \"owner_name\", \"(.*)\"
				  )
				)
				"""

			labels: workload_type: "deployment"
			record: "namespace_workload_pod:kube_pod_owner:relabel"
		}, {
			expr: """
				max by (cluster, namespace, workload, pod) (
				  label_replace(
				    kube_pod_owner{job=\"kube-state-metrics\", owner_kind=\"DaemonSet\"},
				    \"workload\", \"$1\", \"owner_name\", \"(.*)\"
				  )
				)
				"""

			labels: workload_type: "daemonset"
			record: "namespace_workload_pod:kube_pod_owner:relabel"
		}, {
			expr: """
				max by (cluster, namespace, workload, pod) (
				  label_replace(
				    kube_pod_owner{job=\"kube-state-metrics\", owner_kind=\"StatefulSet\"},
				    \"workload\", \"$1\", \"owner_name\", \"(.*)\"
				  )
				)
				"""

			labels: workload_type: "statefulset"
			record: "namespace_workload_pod:kube_pod_owner:relabel"
		}, {
			expr: """
				max by (cluster, namespace, workload, pod) (
				  label_replace(
				    kube_pod_owner{job=\"kube-state-metrics\", owner_kind=\"Job\"},
				    \"workload\", \"$1\", \"owner_name\", \"(.*)\"
				  )
				)
				"""

			labels: workload_type: "job"
			record: "namespace_workload_pod:kube_pod_owner:relabel"
		}]
	}]
}, {
	metadata: name: "kube-apiserver-availability.rules"
	spec: groups: [{
		interval: "3m"
		name:     "kube-apiserver-availability.rules"
		rules: [{
			expr:   "avg_over_time(code_verb:apiserver_request_total:increase1h[30d]) * 24 * 30"
			record: "code_verb:apiserver_request_total:increase30d"
		}, {
			expr: "sum by (cluster, code) (code_verb:apiserver_request_total:increase30d{verb=~\"LIST|GET\"})"
			labels: verb: "read"
			record: "code:apiserver_request_total:increase30d"
		}, {
			expr: "sum by (cluster, code) (code_verb:apiserver_request_total:increase30d{verb=~\"POST|PUT|PATCH|DELETE\"})"
			labels: verb: "write"
			record: "code:apiserver_request_total:increase30d"
		}, {
			expr:   "sum by (cluster, verb, scope) (increase(apiserver_request_slo_duration_seconds_count[1h]))"
			record: "cluster_verb_scope:apiserver_request_slo_duration_seconds_count:increase1h"
		}, {
			expr:   "sum by (cluster, verb, scope) (avg_over_time(cluster_verb_scope:apiserver_request_slo_duration_seconds_count:increase1h[30d]) * 24 * 30)"
			record: "cluster_verb_scope:apiserver_request_slo_duration_seconds_count:increase30d"
		}, {
			expr:   "sum by (cluster, verb, scope, le) (increase(apiserver_request_slo_duration_seconds_bucket[1h]))"
			record: "cluster_verb_scope_le:apiserver_request_slo_duration_seconds_bucket:increase1h"
		}, {
			expr:   "sum by (cluster, verb, scope, le) (avg_over_time(cluster_verb_scope_le:apiserver_request_slo_duration_seconds_bucket:increase1h[30d]) * 24 * 30)"
			record: "cluster_verb_scope_le:apiserver_request_slo_duration_seconds_bucket:increase30d"
		}, {
			expr: """
				1 - (
				  (
				    # write too slow
				    sum by (cluster) (cluster_verb_scope:apiserver_request_slo_duration_seconds_count:increase30d{verb=~\"POST|PUT|PATCH|DELETE\"})
				    -
				    sum by (cluster) (cluster_verb_scope_le:apiserver_request_slo_duration_seconds_bucket:increase30d{verb=~\"POST|PUT|PATCH|DELETE\",le=\"1\"})
				  ) +
				  (
				    # read too slow
				    sum by (cluster) (cluster_verb_scope:apiserver_request_slo_duration_seconds_count:increase30d{verb=~\"LIST|GET\"})
				    -
				    (
				      (
				        sum by (cluster) (cluster_verb_scope_le:apiserver_request_slo_duration_seconds_bucket:increase30d{verb=~\"LIST|GET\",scope=~\"resource|\",le=\"1\"})
				        or
				        vector(0)
				      )
				      +
				      sum by (cluster) (cluster_verb_scope_le:apiserver_request_slo_duration_seconds_bucket:increase30d{verb=~\"LIST|GET\",scope=\"namespace\",le=\"5\"})
				      +
				      sum by (cluster) (cluster_verb_scope_le:apiserver_request_slo_duration_seconds_bucket:increase30d{verb=~\"LIST|GET\",scope=\"cluster\",le=\"30\"})
				    )
				  ) +
				  # errors
				  sum by (cluster) (code:apiserver_request_total:increase30d{code=~\"5..\"} or vector(0))
				)
				/
				sum by (cluster) (code:apiserver_request_total:increase30d)
				"""

			labels: verb: "all"
			record: "apiserver_request:availability30d"
		}, {
			expr: """
				1 - (
				  sum by (cluster) (cluster_verb_scope:apiserver_request_slo_duration_seconds_count:increase30d{verb=~\"LIST|GET\"})
				  -
				  (
				    # too slow
				    (
				      sum by (cluster) (cluster_verb_scope_le:apiserver_request_slo_duration_seconds_bucket:increase30d{verb=~\"LIST|GET\",scope=~\"resource|\",le=\"1\"})
				      or
				      vector(0)
				    )
				    +
				    sum by (cluster) (cluster_verb_scope_le:apiserver_request_slo_duration_seconds_bucket:increase30d{verb=~\"LIST|GET\",scope=\"namespace\",le=\"5\"})
				    +
				    sum by (cluster) (cluster_verb_scope_le:apiserver_request_slo_duration_seconds_bucket:increase30d{verb=~\"LIST|GET\",scope=\"cluster\",le=\"30\"})
				  )
				  +
				  # errors
				  sum by (cluster) (code:apiserver_request_total:increase30d{verb=\"read\",code=~\"5..\"} or vector(0))
				)
				/
				sum by (cluster) (code:apiserver_request_total:increase30d{verb=\"read\"})
				"""

			labels: verb: "read"
			record: "apiserver_request:availability30d"
		}, {
			expr: """
				1 - (
				  (
				    # too slow
				    sum by (cluster) (cluster_verb_scope:apiserver_request_slo_duration_seconds_count:increase30d{verb=~\"POST|PUT|PATCH|DELETE\"})
				    -
				    sum by (cluster) (cluster_verb_scope_le:apiserver_request_slo_duration_seconds_bucket:increase30d{verb=~\"POST|PUT|PATCH|DELETE\",le=\"1\"})
				  )
				  +
				  # errors
				  sum by (cluster) (code:apiserver_request_total:increase30d{verb=\"write\",code=~\"5..\"} or vector(0))
				)
				/
				sum by (cluster) (code:apiserver_request_total:increase30d{verb=\"write\"})
				"""

			labels: verb: "write"
			record: "apiserver_request:availability30d"
		}, {
			expr: "sum by (cluster,code,resource) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\"}[5m]))"
			labels: verb: "read"
			record: "code_resource:apiserver_request_total:rate5m"
		}, {
			expr: "sum by (cluster,code,resource) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[5m]))"
			labels: verb: "write"
			record: "code_resource:apiserver_request_total:rate5m"
		}, {
			expr:   "sum by (cluster, code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET|POST|PUT|PATCH|DELETE\",code=~\"2..\"}[1h]))"
			record: "code_verb:apiserver_request_total:increase1h"
		}, {
			expr:   "sum by (cluster, code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET|POST|PUT|PATCH|DELETE\",code=~\"3..\"}[1h]))"
			record: "code_verb:apiserver_request_total:increase1h"
		}, {
			expr:   "sum by (cluster, code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET|POST|PUT|PATCH|DELETE\",code=~\"4..\"}[1h]))"
			record: "code_verb:apiserver_request_total:increase1h"
		}, {
			expr:   "sum by (cluster, code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET|POST|PUT|PATCH|DELETE\",code=~\"5..\"}[1h]))"
			record: "code_verb:apiserver_request_total:increase1h"
		}]
	}]
}, {
	metadata: name: "kube-apiserver-burnrate.rules"
	spec: groups: [{
		name: "kube-apiserver-burnrate.rules"
		rules: [{
			expr: """
				(
				  (
				    # too slow
				    sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\"}[1d]))
				    -
				    (
				      (
				        sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=~\"resource|\",le=\"1\"}[1d]))
				        or
				        vector(0)
				      )
				      +
				      sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"namespace\",le=\"5\"}[1d]))
				      +
				      sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"cluster\",le=\"30\"}[1d]))
				    )
				  )
				  +
				  # errors
				  sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\",code=~\"5..\"}[1d]))
				)
				/
				sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\"}[1d]))
				"""

			labels: verb: "read"
			record: "apiserver_request:burnrate1d"
		}, {
			expr: """
				(
				  (
				    # too slow
				    sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\"}[1h]))
				    -
				    (
				      (
				        sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=~\"resource|\",le=\"1\"}[1h]))
				        or
				        vector(0)
				      )
				      +
				      sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"namespace\",le=\"5\"}[1h]))
				      +
				      sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"cluster\",le=\"30\"}[1h]))
				    )
				  )
				  +
				  # errors
				  sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\",code=~\"5..\"}[1h]))
				)
				/
				sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\"}[1h]))
				"""

			labels: verb: "read"
			record: "apiserver_request:burnrate1h"
		}, {
			expr: """
				(
				  (
				    # too slow
				    sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\"}[2h]))
				    -
				    (
				      (
				        sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=~\"resource|\",le=\"1\"}[2h]))
				        or
				        vector(0)
				      )
				      +
				      sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"namespace\",le=\"5\"}[2h]))
				      +
				      sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"cluster\",le=\"30\"}[2h]))
				    )
				  )
				  +
				  # errors
				  sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\",code=~\"5..\"}[2h]))
				)
				/
				sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\"}[2h]))
				"""

			labels: verb: "read"
			record: "apiserver_request:burnrate2h"
		}, {
			expr: """
				(
				  (
				    # too slow
				    sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\"}[30m]))
				    -
				    (
				      (
				        sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=~\"resource|\",le=\"1\"}[30m]))
				        or
				        vector(0)
				      )
				      +
				      sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"namespace\",le=\"5\"}[30m]))
				      +
				      sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"cluster\",le=\"30\"}[30m]))
				    )
				  )
				  +
				  # errors
				  sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\",code=~\"5..\"}[30m]))
				)
				/
				sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\"}[30m]))
				"""

			labels: verb: "read"
			record: "apiserver_request:burnrate30m"
		}, {
			expr: """
				(
				  (
				    # too slow
				    sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\"}[3d]))
				    -
				    (
				      (
				        sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=~\"resource|\",le=\"1\"}[3d]))
				        or
				        vector(0)
				      )
				      +
				      sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"namespace\",le=\"5\"}[3d]))
				      +
				      sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"cluster\",le=\"30\"}[3d]))
				    )
				  )
				  +
				  # errors
				  sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\",code=~\"5..\"}[3d]))
				)
				/
				sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\"}[3d]))
				"""

			labels: verb: "read"
			record: "apiserver_request:burnrate3d"
		}, {
			expr: """
				(
				  (
				    # too slow
				    sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\"}[5m]))
				    -
				    (
				      (
				        sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=~\"resource|\",le=\"1\"}[5m]))
				        or
				        vector(0)
				      )
				      +
				      sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"namespace\",le=\"5\"}[5m]))
				      +
				      sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"cluster\",le=\"30\"}[5m]))
				    )
				  )
				  +
				  # errors
				  sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\",code=~\"5..\"}[5m]))
				)
				/
				sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\"}[5m]))
				"""

			labels: verb: "read"
			record: "apiserver_request:burnrate5m"
		}, {
			expr: """
				(
				  (
				    # too slow
				    sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\"}[6h]))
				    -
				    (
				      (
				        sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=~\"resource|\",le=\"1\"}[6h]))
				        or
				        vector(0)
				      )
				      +
				      sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"namespace\",le=\"5\"}[6h]))
				      +
				      sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\",scope=\"cluster\",le=\"30\"}[6h]))
				    )
				  )
				  +
				  # errors
				  sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\",code=~\"5..\"}[6h]))
				)
				/
				sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\"}[6h]))
				"""

			labels: verb: "read"
			record: "apiserver_request:burnrate6h"
		}, {
			expr: """
				(
				  (
				    # too slow
				    sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\"}[1d]))
				    -
				    sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\",le=\"1\"}[1d]))
				  )
				  +
				  sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",code=~\"5..\"}[1d]))
				)
				/
				sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[1d]))
				"""

			labels: verb: "write"
			record: "apiserver_request:burnrate1d"
		}, {
			expr: """
				(
				  (
				    # too slow
				    sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\"}[1h]))
				    -
				    sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\",le=\"1\"}[1h]))
				  )
				  +
				  sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",code=~\"5..\"}[1h]))
				)
				/
				sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[1h]))
				"""

			labels: verb: "write"
			record: "apiserver_request:burnrate1h"
		}, {
			expr: """
				(
				  (
				    # too slow
				    sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\"}[2h]))
				    -
				    sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\",le=\"1\"}[2h]))
				  )
				  +
				  sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",code=~\"5..\"}[2h]))
				)
				/
				sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[2h]))
				"""

			labels: verb: "write"
			record: "apiserver_request:burnrate2h"
		}, {
			expr: """
				(
				  (
				    # too slow
				    sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\"}[30m]))
				    -
				    sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\",le=\"1\"}[30m]))
				  )
				  +
				  sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",code=~\"5..\"}[30m]))
				)
				/
				sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[30m]))
				"""

			labels: verb: "write"
			record: "apiserver_request:burnrate30m"
		}, {
			expr: """
				(
				  (
				    # too slow
				    sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\"}[3d]))
				    -
				    sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\",le=\"1\"}[3d]))
				  )
				  +
				  sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",code=~\"5..\"}[3d]))
				)
				/
				sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[3d]))
				"""

			labels: verb: "write"
			record: "apiserver_request:burnrate3d"
		}, {
			expr: """
				(
				  (
				    # too slow
				    sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\"}[5m]))
				    -
				    sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\",le=\"1\"}[5m]))
				  )
				  +
				  sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",code=~\"5..\"}[5m]))
				)
				/
				sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[5m]))
				"""

			labels: verb: "write"
			record: "apiserver_request:burnrate5m"
		}, {
			expr: """
				(
				  (
				    # too slow
				    sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\"}[6h]))
				    -
				    sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\",le=\"1\"}[6h]))
				  )
				  +
				  sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",code=~\"5..\"}[6h]))
				)
				/
				sum by (cluster) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[6h]))
				"""

			labels: verb: "write"
			record: "apiserver_request:burnrate6h"
		}]
	}]
}, {
	metadata: name: "kube-apiserver-histogram.rules"
	spec: groups: [{
		name: "kube-apiserver-histogram.rules"
		rules: [{
			expr: "histogram_quantile(0.99, sum by (cluster, le, resource) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",subresource!~\"proxy|attach|log|exec|portforward\"}[5m]))) > 0"
			labels: {
				quantile: "0.99"
				verb:     "read"
			}
			record: "cluster_quantile:apiserver_request_slo_duration_seconds:histogram_quantile"
		}, {
			expr: "histogram_quantile(0.99, sum by (cluster, le, resource) (rate(apiserver_request_slo_duration_seconds_bucket{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",subresource!~\"proxy|attach|log|exec|portforward\"}[5m]))) > 0"
			labels: {
				quantile: "0.99"
				verb:     "write"
			}
			record: "cluster_quantile:apiserver_request_slo_duration_seconds:histogram_quantile"
		}]
	}]
}, {
	metadata: name: "kube-apiserver-slos"
	spec: groups: [{
		name: "kube-apiserver-slos"
		rules: [{
			alert: "KubeAPIErrorBudgetBurn"
			annotations: {
				description: "The API server is burning too much error budget."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeapierrorbudgetburn"
				summary:     "The API server is burning too much error budget."
			}
			expr: """
				sum(apiserver_request:burnrate1h) > (14.40 * 0.01000)
				and
				sum(apiserver_request:burnrate5m) > (14.40 * 0.01000)
				"""

			for: "2m"
			labels: {
				long:     "1h"
				severity: "critical"
				short:    "5m"
			}
		}, {
			alert: "KubeAPIErrorBudgetBurn"
			annotations: {
				description: "The API server is burning too much error budget."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeapierrorbudgetburn"
				summary:     "The API server is burning too much error budget."
			}
			expr: """
				sum(apiserver_request:burnrate6h) > (6.00 * 0.01000)
				and
				sum(apiserver_request:burnrate30m) > (6.00 * 0.01000)
				"""

			for: "15m"
			labels: {
				long:     "6h"
				severity: "critical"
				short:    "30m"
			}
		}, {
			alert: "KubeAPIErrorBudgetBurn"
			annotations: {
				description: "The API server is burning too much error budget."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeapierrorbudgetburn"
				summary:     "The API server is burning too much error budget."
			}
			expr: """
				sum(apiserver_request:burnrate1d) > (3.00 * 0.01000)
				and
				sum(apiserver_request:burnrate2h) > (3.00 * 0.01000)
				"""

			for: "1h"
			labels: {
				long:     "1d"
				severity: "warning"
				short:    "2h"
			}
		}, {
			alert: "KubeAPIErrorBudgetBurn"
			annotations: {
				description: "The API server is burning too much error budget."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeapierrorbudgetburn"
				summary:     "The API server is burning too much error budget."
			}
			expr: """
				sum(apiserver_request:burnrate3d) > (1.00 * 0.01000)
				and
				sum(apiserver_request:burnrate6h) > (1.00 * 0.01000)
				"""

			for: "3h"
			labels: {
				long:     "3d"
				severity: "warning"
				short:    "6h"
			}
		}]
	}]
}, {
	metadata: name: "kube-prometheus-general.rules"
	spec: groups: [{
		name: "kube-prometheus-general.rules"
		rules: [{
			expr:   "count without(instance, pod, node) (up == 1)"
			record: "count:up1"
		}, {
			expr:   "count without(instance, pod, node) (up == 0)"
			record: "count:up0"
		}]
	}]
}, {
	metadata: name: "kube-prometheus-node-recording.ru"
	spec: groups: [{
		name: "kube-prometheus-node-recording.rules"
		rules: [{
			expr:   "sum(rate(node_cpu_seconds_total{mode!=\"idle\",mode!=\"iowait\",mode!=\"steal\"}[3m])) BY (instance)"
			record: "instance:node_cpu:rate:sum"
		}, {
			expr:   "sum(rate(node_network_receive_bytes_total[3m])) BY (instance)"
			record: "instance:node_network_receive_bytes:rate:sum"
		}, {
			expr:   "sum(rate(node_network_transmit_bytes_total[3m])) BY (instance)"
			record: "instance:node_network_transmit_bytes:rate:sum"
		}, {
			expr:   "sum(rate(node_cpu_seconds_total{mode!=\"idle\",mode!=\"iowait\",mode!=\"steal\"}[5m])) WITHOUT (cpu, mode) / ON(instance) GROUP_LEFT() count(sum(node_cpu_seconds_total) BY (instance, cpu)) BY (instance)"
			record: "instance:node_cpu:ratio"
		}, {
			expr:   "sum(rate(node_cpu_seconds_total{mode!=\"idle\",mode!=\"iowait\",mode!=\"steal\"}[5m]))"
			record: "cluster:node_cpu:sum_rate5m"
		}, {
			expr:   "cluster:node_cpu:sum_rate5m / count(sum(node_cpu_seconds_total) BY (instance, cpu))"
			record: "cluster:node_cpu:ratio"
		}]
	}]
}, {
	metadata: name: "kube-scheduler.rules"
	spec: groups: [{
		name: "kube-scheduler.rules"
		rules: [{
			expr: "histogram_quantile(0.99, sum(rate(scheduler_e2e_scheduling_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance, pod))"
			labels: quantile: "0.99"
			record: "cluster_quantile:scheduler_e2e_scheduling_duration_seconds:histogram_quantile"
		}, {
			expr: "histogram_quantile(0.99, sum(rate(scheduler_scheduling_algorithm_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance, pod))"
			labels: quantile: "0.99"
			record: "cluster_quantile:scheduler_scheduling_algorithm_duration_seconds:histogram_quantile"
		}, {
			expr: "histogram_quantile(0.99, sum(rate(scheduler_binding_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance, pod))"
			labels: quantile: "0.99"
			record: "cluster_quantile:scheduler_binding_duration_seconds:histogram_quantile"
		}, {
			expr: "histogram_quantile(0.9, sum(rate(scheduler_e2e_scheduling_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance, pod))"
			labels: quantile: "0.9"
			record: "cluster_quantile:scheduler_e2e_scheduling_duration_seconds:histogram_quantile"
		}, {
			expr: "histogram_quantile(0.9, sum(rate(scheduler_scheduling_algorithm_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance, pod))"
			labels: quantile: "0.9"
			record: "cluster_quantile:scheduler_scheduling_algorithm_duration_seconds:histogram_quantile"
		}, {
			expr: "histogram_quantile(0.9, sum(rate(scheduler_binding_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance, pod))"
			labels: quantile: "0.9"
			record: "cluster_quantile:scheduler_binding_duration_seconds:histogram_quantile"
		}, {
			expr: "histogram_quantile(0.5, sum(rate(scheduler_e2e_scheduling_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance, pod))"
			labels: quantile: "0.5"
			record: "cluster_quantile:scheduler_e2e_scheduling_duration_seconds:histogram_quantile"
		}, {
			expr: "histogram_quantile(0.5, sum(rate(scheduler_scheduling_algorithm_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance, pod))"
			labels: quantile: "0.5"
			record: "cluster_quantile:scheduler_scheduling_algorithm_duration_seconds:histogram_quantile"
		}, {
			expr: "histogram_quantile(0.5, sum(rate(scheduler_binding_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance, pod))"
			labels: quantile: "0.5"
			record: "cluster_quantile:scheduler_binding_duration_seconds:histogram_quantile"
		}]
	}]
}, {
	metadata: name: "kubelet.rules"
	spec: groups: [{
		name: "kubelet.rules"
		rules: [{
			expr: "histogram_quantile(0.99, sum(rate(kubelet_pleg_relist_duration_seconds_bucket[5m])) by (cluster, instance, le) * on(cluster, instance) group_left(node) kubelet_node_name{job=\"kubelet\", metrics_path=\"/metrics\"})"
			labels: quantile: "0.99"
			record: "node_quantile:kubelet_pleg_relist_duration_seconds:histogram_quantile"
		}, {
			expr: "histogram_quantile(0.9, sum(rate(kubelet_pleg_relist_duration_seconds_bucket[5m])) by (cluster, instance, le) * on(cluster, instance) group_left(node) kubelet_node_name{job=\"kubelet\", metrics_path=\"/metrics\"})"
			labels: quantile: "0.9"
			record: "node_quantile:kubelet_pleg_relist_duration_seconds:histogram_quantile"
		}, {
			expr: "histogram_quantile(0.5, sum(rate(kubelet_pleg_relist_duration_seconds_bucket[5m])) by (cluster, instance, le) * on(cluster, instance) group_left(node) kubelet_node_name{job=\"kubelet\", metrics_path=\"/metrics\"})"
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
				description: "Pod {{ $labels.namespace }}/{{ $labels.pod }} ({{ $labels.container }}) is in waiting state (reason: \"CrashLoopBackOff\")."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepodcrashlooping"
				summary:     "Pod is crash looping."
			}
			expr: "max_over_time(kube_pod_container_status_waiting_reason{reason=\"CrashLoopBackOff\", job=\"kube-state-metrics\", namespace=~\".*\"}[5m]) >= 1"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubePodNotReady"
			annotations: {
				description: "Pod {{ $labels.namespace }}/{{ $labels.pod }} has been in a non-ready state for longer than 15 minutes."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepodnotready"
				summary:     "Pod has been in a non-ready state for more than 15 minutes."
			}
			expr: """
				sum by (namespace, pod, cluster) (
				  max by(namespace, pod, cluster) (
				    kube_pod_status_phase{job=\"kube-state-metrics\", namespace=~\".*\", phase=~\"Pending|Unknown|Failed\"}
				  ) * on(namespace, pod, cluster) group_left(owner_kind) topk by(namespace, pod, cluster) (
				    1, max by(namespace, pod, owner_kind, cluster) (kube_pod_owner{owner_kind!=\"Job\"})
				  )
				) > 0
				"""

			for: "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeDeploymentGenerationMismatch"
			annotations: {
				description: "Deployment generation for {{ $labels.namespace }}/{{ $labels.deployment }} does not match, this indicates that the Deployment has failed but has not been rolled back."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubedeploymentgenerationmismatch"
				summary:     "Deployment generation mismatch due to possible roll-back"
			}
			expr: """
				kube_deployment_status_observed_generation{job=\"kube-state-metrics\", namespace=~\".*\"}
				  !=
				kube_deployment_metadata_generation{job=\"kube-state-metrics\", namespace=~\".*\"}
				"""

			for: "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeDeploymentReplicasMismatch"
			annotations: {
				description: "Deployment {{ $labels.namespace }}/{{ $labels.deployment }} has not matched the expected number of replicas for longer than 15 minutes."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubedeploymentreplicasmismatch"
				summary:     "Deployment has not matched the expected number of replicas."
			}
			expr: """
				(
				  kube_deployment_spec_replicas{job=\"kube-state-metrics\", namespace=~\".*\"}
				    >
				  kube_deployment_status_replicas_available{job=\"kube-state-metrics\", namespace=~\".*\"}
				) and (
				  changes(kube_deployment_status_replicas_updated{job=\"kube-state-metrics\", namespace=~\".*\"}[10m])
				    ==
				  0
				)
				"""

			for: "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeStatefulSetReplicasMismatch"
			annotations: {
				description: "StatefulSet {{ $labels.namespace }}/{{ $labels.statefulset }} has not matched the expected number of replicas for longer than 15 minutes."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubestatefulsetreplicasmismatch"
				summary:     "Deployment has not matched the expected number of replicas."
			}
			expr: """
				(
				  kube_statefulset_status_replicas_ready{job=\"kube-state-metrics\", namespace=~\".*\"}
				    !=
				  kube_statefulset_status_replicas{job=\"kube-state-metrics\", namespace=~\".*\"}
				) and (
				  changes(kube_statefulset_status_replicas_updated{job=\"kube-state-metrics\", namespace=~\".*\"}[10m])
				    ==
				  0
				)
				"""

			for: "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeStatefulSetGenerationMismatch"
			annotations: {
				description: "StatefulSet generation for {{ $labels.namespace }}/{{ $labels.statefulset }} does not match, this indicates that the StatefulSet has failed but has not been rolled back."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubestatefulsetgenerationmismatch"
				summary:     "StatefulSet generation mismatch due to possible roll-back"
			}
			expr: """
				kube_statefulset_status_observed_generation{job=\"kube-state-metrics\", namespace=~\".*\"}
				  !=
				kube_statefulset_metadata_generation{job=\"kube-state-metrics\", namespace=~\".*\"}
				"""

			for: "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeStatefulSetUpdateNotRolledOut"
			annotations: {
				description: "StatefulSet {{ $labels.namespace }}/{{ $labels.statefulset }} update has not been rolled out."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubestatefulsetupdatenotrolledout"
				summary:     "StatefulSet update has not been rolled out."
			}
			expr: """
				(
				  max without (revision) (
				    kube_statefulset_status_current_revision{job=\"kube-state-metrics\", namespace=~\".*\"}
				      unless
				    kube_statefulset_status_update_revision{job=\"kube-state-metrics\", namespace=~\".*\"}
				  )
				    *
				  (
				    kube_statefulset_replicas{job=\"kube-state-metrics\", namespace=~\".*\"}
				      !=
				    kube_statefulset_status_replicas_updated{job=\"kube-state-metrics\", namespace=~\".*\"}
				  )
				)  and (
				  changes(kube_statefulset_status_replicas_updated{job=\"kube-state-metrics\", namespace=~\".*\"}[5m])
				    ==
				  0
				)
				"""

			for: "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeDaemonSetRolloutStuck"
			annotations: {
				description: "DaemonSet {{ $labels.namespace }}/{{ $labels.daemonset }} has not finished or progressed for at least 15 minutes."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubedaemonsetrolloutstuck"
				summary:     "DaemonSet rollout is stuck."
			}
			expr: """
				(
				  (
				    kube_daemonset_status_current_number_scheduled{job=\"kube-state-metrics\", namespace=~\".*\"}
				     !=
				    kube_daemonset_status_desired_number_scheduled{job=\"kube-state-metrics\", namespace=~\".*\"}
				  ) or (
				    kube_daemonset_status_number_misscheduled{job=\"kube-state-metrics\", namespace=~\".*\"}
				     !=
				    0
				  ) or (
				    kube_daemonset_status_updated_number_scheduled{job=\"kube-state-metrics\", namespace=~\".*\"}
				     !=
				    kube_daemonset_status_desired_number_scheduled{job=\"kube-state-metrics\", namespace=~\".*\"}
				  ) or (
				    kube_daemonset_status_number_available{job=\"kube-state-metrics\", namespace=~\".*\"}
				     !=
				    kube_daemonset_status_desired_number_scheduled{job=\"kube-state-metrics\", namespace=~\".*\"}
				  )
				) and (
				  changes(kube_daemonset_status_updated_number_scheduled{job=\"kube-state-metrics\", namespace=~\".*\"}[5m])
				    ==
				  0
				)
				"""

			for: "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeContainerWaiting"
			annotations: {
				description: "pod/{{ $labels.pod }} in namespace {{ $labels.namespace }} on container {{ $labels.container}} has been in waiting state for longer than 1 hour."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubecontainerwaiting"
				summary:     "Pod container waiting longer than 1 hour"
			}
			expr: "sum by (namespace, pod, container, cluster) (kube_pod_container_status_waiting_reason{job=\"kube-state-metrics\", namespace=~\".*\"}) > 0"
			for:  "1h"
			labels: severity: "warning"
		}, {
			alert: "KubeDaemonSetNotScheduled"
			annotations: {
				description: "{{ $value }} Pods of DaemonSet {{ $labels.namespace }}/{{ $labels.daemonset }} are not scheduled."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubedaemonsetnotscheduled"
				summary:     "DaemonSet pods are not scheduled."
			}
			expr: """
				kube_daemonset_status_desired_number_scheduled{job=\"kube-state-metrics\", namespace=~\".*\"}
				  -
				kube_daemonset_status_current_number_scheduled{job=\"kube-state-metrics\", namespace=~\".*\"} > 0
				"""

			for: "10m"
			labels: severity: "warning"
		}, {
			alert: "KubeDaemonSetMisScheduled"
			annotations: {
				description: "{{ $value }} Pods of DaemonSet {{ $labels.namespace }}/{{ $labels.daemonset }} are running where they are not supposed to run."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubedaemonsetmisscheduled"
				summary:     "DaemonSet pods are misscheduled."
			}
			expr: "kube_daemonset_status_number_misscheduled{job=\"kube-state-metrics\", namespace=~\".*\"} > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeJobNotCompleted"
			annotations: {
				description: "Job {{ $labels.namespace }}/{{ $labels.job_name }} is taking more than {{ \"43200\" | humanizeDuration }} to complete."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubejobnotcompleted"
				summary:     "Job did not complete in time"
			}
			expr: """
				time() - max by(namespace, job_name, cluster) (kube_job_status_start_time{job=\"kube-state-metrics\", namespace=~\".*\"}
				  and
				kube_job_status_active{job=\"kube-state-metrics\", namespace=~\".*\"} > 0) > 43200
				"""

			labels: severity: "warning"
		}, {
			alert: "KubeJobFailed"
			annotations: {
				description: "Job {{ $labels.namespace }}/{{ $labels.job_name }} failed to complete. Removing failed job after investigation should clear this alert."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubejobfailed"
				summary:     "Job failed to complete."
			}
			expr: "kube_job_failed{job=\"kube-state-metrics\", namespace=~\".*\"}  > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeHpaReplicasMismatch"
			annotations: {
				description: "HPA {{ $labels.namespace }}/{{ $labels.horizontalpodautoscaler  }} has not matched the desired number of replicas for longer than 15 minutes."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubehpareplicasmismatch"
				summary:     "HPA has not matched desired number of replicas."
			}
			expr: """
				(kube_horizontalpodautoscaler_status_desired_replicas{job=\"kube-state-metrics\", namespace=~\".*\"}
				  !=
				kube_horizontalpodautoscaler_status_current_replicas{job=\"kube-state-metrics\", namespace=~\".*\"})
				  and
				(kube_horizontalpodautoscaler_status_current_replicas{job=\"kube-state-metrics\", namespace=~\".*\"}
				  >
				kube_horizontalpodautoscaler_spec_min_replicas{job=\"kube-state-metrics\", namespace=~\".*\"})
				  and
				(kube_horizontalpodautoscaler_status_current_replicas{job=\"kube-state-metrics\", namespace=~\".*\"}
				  <
				kube_horizontalpodautoscaler_spec_max_replicas{job=\"kube-state-metrics\", namespace=~\".*\"})
				  and
				changes(kube_horizontalpodautoscaler_status_current_replicas{job=\"kube-state-metrics\", namespace=~\".*\"}[15m]) == 0
				"""

			for: "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeHpaMaxedOut"
			annotations: {
				description: "HPA {{ $labels.namespace }}/{{ $labels.horizontalpodautoscaler  }} has been running at max replicas for longer than 15 minutes."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubehpamaxedout"
				summary:     "HPA is running at max replicas"
			}
			expr: """
				kube_horizontalpodautoscaler_status_current_replicas{job=\"kube-state-metrics\", namespace=~\".*\"}
				  ==
				kube_horizontalpodautoscaler_spec_max_replicas{job=\"kube-state-metrics\", namespace=~\".*\"}
				"""

			for: "15m"
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
				description: "Cluster has overcommitted CPU resource requests for Pods by {{ $value }} CPU shares and cannot tolerate node failure."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubecpuovercommit"
				summary:     "Cluster has overcommitted CPU resource requests."
			}
			expr: """
				sum(namespace_cpu:kube_pod_container_resource_requests:sum{}) - (sum(kube_node_status_allocatable{resource=\"cpu\"}) - max(kube_node_status_allocatable{resource=\"cpu\"})) > 0
				and
				(sum(kube_node_status_allocatable{resource=\"cpu\"}) - max(kube_node_status_allocatable{resource=\"cpu\"})) > 0
				"""

			for: "10m"
			labels: severity: "warning"
		}, {
			alert: "KubeMemoryOvercommit"
			annotations: {
				description: "Cluster has overcommitted memory resource requests for Pods by {{ $value | humanize }} bytes and cannot tolerate node failure."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubememoryovercommit"
				summary:     "Cluster has overcommitted memory resource requests."
			}
			expr: """
				sum(namespace_memory:kube_pod_container_resource_requests:sum{}) - (sum(kube_node_status_allocatable{resource=\"memory\"}) - max(kube_node_status_allocatable{resource=\"memory\"})) > 0
				and
				(sum(kube_node_status_allocatable{resource=\"memory\"}) - max(kube_node_status_allocatable{resource=\"memory\"})) > 0
				"""

			for: "10m"
			labels: severity: "warning"
		}, {
			alert: "KubeCPUQuotaOvercommit"
			annotations: {
				description: "Cluster has overcommitted CPU resource requests for Namespaces."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubecpuquotaovercommit"
				summary:     "Cluster has overcommitted CPU resource requests."
			}
			expr: """
				sum(min without(resource) (kube_resourcequota{job=\"kube-state-metrics\", type=\"hard\", resource=~\"(cpu|requests.cpu)\"}))
				  /
				sum(kube_node_status_allocatable{resource=\"cpu\", job=\"kube-state-metrics\"})
				  > 1.5
				"""

			for: "5m"
			labels: severity: "warning"
		}, {
			alert: "KubeMemoryQuotaOvercommit"
			annotations: {
				description: "Cluster has overcommitted memory resource requests for Namespaces."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubememoryquotaovercommit"
				summary:     "Cluster has overcommitted memory resource requests."
			}
			expr: """
				sum(min without(resource) (kube_resourcequota{job=\"kube-state-metrics\", type=\"hard\", resource=~\"(memory|requests.memory)\"}))
				  /
				sum(kube_node_status_allocatable{resource=\"memory\", job=\"kube-state-metrics\"})
				  > 1.5
				"""

			for: "5m"
			labels: severity: "warning"
		}, {
			alert: "KubeQuotaAlmostFull"
			annotations: {
				description: "Namespace {{ $labels.namespace }} is using {{ $value | humanizePercentage }} of its {{ $labels.resource }} quota."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubequotaalmostfull"
				summary:     "Namespace quota is going to be full."
			}
			expr: """
				kube_resourcequota{job=\"kube-state-metrics\", type=\"used\"}
				  / ignoring(instance, job, type)
				(kube_resourcequota{job=\"kube-state-metrics\", type=\"hard\"} > 0)
				  > 0.9 < 1
				"""

			for: "15m"
			labels: severity: "info"
		}, {
			alert: "KubeQuotaFullyUsed"
			annotations: {
				description: "Namespace {{ $labels.namespace }} is using {{ $value | humanizePercentage }} of its {{ $labels.resource }} quota."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubequotafullyused"
				summary:     "Namespace quota is fully used."
			}
			expr: """
				kube_resourcequota{job=\"kube-state-metrics\", type=\"used\"}
				  / ignoring(instance, job, type)
				(kube_resourcequota{job=\"kube-state-metrics\", type=\"hard\"} > 0)
				  == 1
				"""

			for: "15m"
			labels: severity: "info"
		}, {
			alert: "KubeQuotaExceeded"
			annotations: {
				description: "Namespace {{ $labels.namespace }} is using {{ $value | humanizePercentage }} of its {{ $labels.resource }} quota."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubequotaexceeded"
				summary:     "Namespace quota has exceeded the limits."
			}
			expr: """
				kube_resourcequota{job=\"kube-state-metrics\", type=\"used\"}
				  / ignoring(instance, job, type)
				(kube_resourcequota{job=\"kube-state-metrics\", type=\"hard\"} > 0)
				  > 1
				"""

			for: "15m"
			labels: severity: "warning"
		}, {
			alert: "CPUThrottlingHigh"
			annotations: {
				description: "{{ $value | humanizePercentage }} throttling of CPU in namespace {{ $labels.namespace }} for container {{ $labels.container }} in pod {{ $labels.pod }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/cputhrottlinghigh"
				summary:     "Processes experience elevated CPU throttling."
			}
			expr: """
				sum(increase(container_cpu_cfs_throttled_periods_total{container!=\"\", }[5m])) by (container, pod, namespace)
				  /
				sum(increase(container_cpu_cfs_periods_total{}[5m])) by (container, pod, namespace)
				  > ( 25 / 100 )
				"""

			for: "15m"
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
				description: "The PersistentVolume claimed by {{ $labels.persistentvolumeclaim }} in Namespace {{ $labels.namespace }} is only {{ $value | humanizePercentage }} free."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepersistentvolumefillingup"
				summary:     "PersistentVolume is filling up."
			}
			expr: """
				(
				  kubelet_volume_stats_available_bytes{job=\"kubelet\", namespace=~\".*\", metrics_path=\"/metrics\"}
				    /
				  kubelet_volume_stats_capacity_bytes{job=\"kubelet\", namespace=~\".*\", metrics_path=\"/metrics\"}
				) < 0.03
				and
				kubelet_volume_stats_used_bytes{job=\"kubelet\", namespace=~\".*\", metrics_path=\"/metrics\"} > 0
				unless on(namespace, persistentvolumeclaim)
				kube_persistentvolumeclaim_access_mode{ access_mode=\"ReadOnlyMany\"} == 1
				unless on(namespace, persistentvolumeclaim)
				kube_persistentvolumeclaim_labels{label_excluded_from_alerts=\"true\"} == 1
				"""

			for: "1m"
			labels: severity: "critical"
		}, {
			alert: "KubePersistentVolumeFillingUp"
			annotations: {
				description: "Based on recent sampling, the PersistentVolume claimed by {{ $labels.persistentvolumeclaim }} in Namespace {{ $labels.namespace }} is expected to fill up within four days. Currently {{ $value | humanizePercentage }} is available."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepersistentvolumefillingup"
				summary:     "PersistentVolume is filling up."
			}
			expr: """
				(
				  kubelet_volume_stats_available_bytes{job=\"kubelet\", namespace=~\".*\", metrics_path=\"/metrics\"}
				    /
				  kubelet_volume_stats_capacity_bytes{job=\"kubelet\", namespace=~\".*\", metrics_path=\"/metrics\"}
				) < 0.15
				and
				kubelet_volume_stats_used_bytes{job=\"kubelet\", namespace=~\".*\", metrics_path=\"/metrics\"} > 0
				and
				predict_linear(kubelet_volume_stats_available_bytes{job=\"kubelet\", namespace=~\".*\", metrics_path=\"/metrics\"}[6h], 4 * 24 * 3600) < 0
				unless on(namespace, persistentvolumeclaim)
				kube_persistentvolumeclaim_access_mode{ access_mode=\"ReadOnlyMany\"} == 1
				unless on(namespace, persistentvolumeclaim)
				kube_persistentvolumeclaim_labels{label_excluded_from_alerts=\"true\"} == 1
				"""

			for: "1h"
			labels: severity: "warning"
		}, {
			alert: "KubePersistentVolumeInodesFillingUp"
			annotations: {
				description: "The PersistentVolume claimed by {{ $labels.persistentvolumeclaim }} in Namespace {{ $labels.namespace }} only has {{ $value | humanizePercentage }} free inodes."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepersistentvolumeinodesfillingup"
				summary:     "PersistentVolumeInodes are filling up."
			}
			expr: """
				(
				  kubelet_volume_stats_inodes_free{job=\"kubelet\", namespace=~\".*\", metrics_path=\"/metrics\"}
				    /
				  kubelet_volume_stats_inodes{job=\"kubelet\", namespace=~\".*\", metrics_path=\"/metrics\"}
				) < 0.03
				and
				kubelet_volume_stats_inodes_used{job=\"kubelet\", namespace=~\".*\", metrics_path=\"/metrics\"} > 0
				unless on(namespace, persistentvolumeclaim)
				kube_persistentvolumeclaim_access_mode{ access_mode=\"ReadOnlyMany\"} == 1
				unless on(namespace, persistentvolumeclaim)
				kube_persistentvolumeclaim_labels{label_excluded_from_alerts=\"true\"} == 1
				"""

			for: "1m"
			labels: severity: "critical"
		}, {
			alert: "KubePersistentVolumeInodesFillingUp"
			annotations: {
				description: "Based on recent sampling, the PersistentVolume claimed by {{ $labels.persistentvolumeclaim }} in Namespace {{ $labels.namespace }} is expected to run out of inodes within four days. Currently {{ $value | humanizePercentage }} of its inodes are free."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepersistentvolumeinodesfillingup"
				summary:     "PersistentVolumeInodes are filling up."
			}
			expr: """
				(
				  kubelet_volume_stats_inodes_free{job=\"kubelet\", namespace=~\".*\", metrics_path=\"/metrics\"}
				    /
				  kubelet_volume_stats_inodes{job=\"kubelet\", namespace=~\".*\", metrics_path=\"/metrics\"}
				) < 0.15
				and
				kubelet_volume_stats_inodes_used{job=\"kubelet\", namespace=~\".*\", metrics_path=\"/metrics\"} > 0
				and
				predict_linear(kubelet_volume_stats_inodes_free{job=\"kubelet\", namespace=~\".*\", metrics_path=\"/metrics\"}[6h], 4 * 24 * 3600) < 0
				unless on(namespace, persistentvolumeclaim)
				kube_persistentvolumeclaim_access_mode{ access_mode=\"ReadOnlyMany\"} == 1
				unless on(namespace, persistentvolumeclaim)
				kube_persistentvolumeclaim_labels{label_excluded_from_alerts=\"true\"} == 1
				"""

			for: "1h"
			labels: severity: "warning"
		}, {
			alert: "KubePersistentVolumeErrors"
			annotations: {
				description: "The persistent volume {{ $labels.persistentvolume }} has status {{ $labels.phase }}."
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
				description: "A client certificate used to authenticate to kubernetes apiserver is expiring in less than 7.0 days."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeclientcertificateexpiration"
				summary:     "Client certificate is about to expire."
			}
			expr: "apiserver_client_certificate_expiration_seconds_count{job=\"apiserver\"} > 0 and on(job) histogram_quantile(0.01, sum by (job, le) (rate(apiserver_client_certificate_expiration_seconds_bucket{job=\"apiserver\"}[5m]))) < 604800"
			for:  "5m"
			labels: severity: "warning"
		}, {
			alert: "KubeClientCertificateExpiration"
			annotations: {
				description: "A client certificate used to authenticate to kubernetes apiserver is expiring in less than 24.0 hours."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeclientcertificateexpiration"
				summary:     "Client certificate is about to expire."
			}
			expr: "apiserver_client_certificate_expiration_seconds_count{job=\"apiserver\"} > 0 and on(job) histogram_quantile(0.01, sum by (job, le) (rate(apiserver_client_certificate_expiration_seconds_bucket{job=\"apiserver\"}[5m]))) < 86400"
			for:  "5m"
			labels: severity: "critical"
		}, {
			alert: "KubeAggregatedAPIErrors"
			annotations: {
				description: "Kubernetes aggregated API {{ $labels.name }}/{{ $labels.namespace }} has reported errors. It has appeared unavailable {{ $value | humanize }} times averaged over the past 10m."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeaggregatedapierrors"
				summary:     "Kubernetes aggregated API has reported errors."
			}
			expr: "sum by(name, namespace, cluster)(increase(aggregator_unavailable_apiservice_total[10m])) > 4"
			labels: severity: "warning"
		}, {
			alert: "KubeAggregatedAPIDown"
			annotations: {
				description: "Kubernetes aggregated API {{ $labels.name }}/{{ $labels.namespace }} has been only {{ $value | humanize }}% available over the last 10m."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeaggregatedapidown"
				summary:     "Kubernetes aggregated API is down."
			}
			expr: "(1 - max by(name, namespace, cluster)(avg_over_time(aggregator_unavailable_apiservice[10m]))) * 100 < 85"
			for:  "5m"
			labels: severity: "warning"
		}, {
			alert: "KubeAPIDown"
			annotations: {
				description: "KubeAPI has disappeared from Prometheus target discovery."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeapidown"
				summary:     "Target disappeared from Prometheus target discovery."
			}
			expr: "absent(up{job=\"apiserver\"} == 1)"
			for:  "15m"
			labels: severity: "critical"
		}, {
			alert: "KubeAPITerminatedRequests"
			annotations: {
				description: "The kubernetes apiserver has terminated {{ $value | humanizePercentage }} of its incoming requests."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeapiterminatedrequests"
				summary:     "The kubernetes apiserver has terminated {{ $value | humanizePercentage }} of its incoming requests."
			}
			expr: "sum(rate(apiserver_request_terminations_total{job=\"apiserver\"}[10m]))  / (  sum(rate(apiserver_request_total{job=\"apiserver\"}[10m])) + sum(rate(apiserver_request_terminations_total{job=\"apiserver\"}[10m])) ) > 0.20"
			for:  "5m"
			labels: severity: "warning"
		}]
	}]
}, {
	metadata: name: "kubernetes-system-controller-mana"
	spec: groups: [{
		name: "kubernetes-system-controller-manager"
		rules: [{
			alert: "KubeControllerManagerDown"
			annotations: {
				description: "KubeControllerManager has disappeared from Prometheus target discovery."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubecontrollermanagerdown"
				summary:     "Target disappeared from Prometheus target discovery."
			}
			expr: "absent(up{job=\"kube-controller-manager\"} == 1)"
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
				description: "{{ $labels.node }} has been unready for more than 15 minutes."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubenodenotready"
				summary:     "Node is not ready."
			}
			expr: "kube_node_status_condition{job=\"kube-state-metrics\",condition=\"Ready\",status=\"true\"} == 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeNodeUnreachable"
			annotations: {
				description: "{{ $labels.node }} is unreachable and some workloads may be rescheduled."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubenodeunreachable"
				summary:     "Node is unreachable."
			}
			expr: "(kube_node_spec_taint{job=\"kube-state-metrics\",key=\"node.kubernetes.io/unreachable\",effect=\"NoSchedule\"} unless ignoring(key,value) kube_node_spec_taint{job=\"kube-state-metrics\",key=~\"ToBeDeletedByClusterAutoscaler|cloud.google.com/impending-node-termination|aws-node-termination-handler/spot-itn\"}) == 1"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeletTooManyPods"
			annotations: {
				description: "Kubelet '{{ $labels.node }}' is running at {{ $value | humanizePercentage }} of its Pod capacity."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubelettoomanypods"
				summary:     "Kubelet is running at capacity."
			}
			expr: """
				count by(cluster, node) (
				  (kube_pod_status_phase{job=\"kube-state-metrics\",phase=\"Running\"} == 1) * on(instance,pod,namespace,cluster) group_left(node) topk by(instance,pod,namespace,cluster) (1, kube_pod_info{job=\"kube-state-metrics\"})
				)
				/
				max by(cluster, node) (
				  kube_node_status_capacity{job=\"kube-state-metrics\",resource=\"pods\"} != 1
				) > 0.95
				"""

			for: "15m"
			labels: severity: "info"
		}, {
			alert: "KubeNodeReadinessFlapping"
			annotations: {
				description: "The readiness status of node {{ $labels.node }} has changed {{ $value }} times in the last 15 minutes."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubenodereadinessflapping"
				summary:     "Node readiness status is flapping."
			}
			expr: "sum(changes(kube_node_status_condition{status=\"true\",condition=\"Ready\"}[15m])) by (cluster, node) > 2"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeletPlegDurationHigh"
			annotations: {
				description: "The Kubelet Pod Lifecycle Event Generator has a 99th percentile duration of {{ $value }} seconds on node {{ $labels.node }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletplegdurationhigh"
				summary:     "Kubelet Pod Lifecycle Event Generator is taking too long to relist."
			}
			expr: "node_quantile:kubelet_pleg_relist_duration_seconds:histogram_quantile{quantile=\"0.99\"} >= 10"
			for:  "5m"
			labels: severity: "warning"
		}, {
			alert: "KubeletPodStartUpLatencyHigh"
			annotations: {
				description: "Kubelet Pod startup 99th percentile latency is {{ $value }} seconds on node {{ $labels.node }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletpodstartuplatencyhigh"
				summary:     "Kubelet Pod startup latency is too high."
			}
			expr: "histogram_quantile(0.99, sum(rate(kubelet_pod_worker_duration_seconds_bucket{job=\"kubelet\", metrics_path=\"/metrics\"}[5m])) by (cluster, instance, le)) * on(cluster, instance) group_left(node) kubelet_node_name{job=\"kubelet\", metrics_path=\"/metrics\"} > 60"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeletClientCertificateExpiration"
			annotations: {
				description: "Client certificate for Kubelet on node {{ $labels.node }} expires in {{ $value | humanizeDuration }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletclientcertificateexpiration"
				summary:     "Kubelet client certificate is about to expire."
			}
			expr: "kubelet_certificate_manager_client_ttl_seconds < 604800"
			labels: severity: "warning"
		}, {
			alert: "KubeletClientCertificateExpiration"
			annotations: {
				description: "Client certificate for Kubelet on node {{ $labels.node }} expires in {{ $value | humanizeDuration }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletclientcertificateexpiration"
				summary:     "Kubelet client certificate is about to expire."
			}
			expr: "kubelet_certificate_manager_client_ttl_seconds < 86400"
			labels: severity: "critical"
		}, {
			alert: "KubeletServerCertificateExpiration"
			annotations: {
				description: "Server certificate for Kubelet on node {{ $labels.node }} expires in {{ $value | humanizeDuration }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletservercertificateexpiration"
				summary:     "Kubelet server certificate is about to expire."
			}
			expr: "kubelet_certificate_manager_server_ttl_seconds < 604800"
			labels: severity: "warning"
		}, {
			alert: "KubeletServerCertificateExpiration"
			annotations: {
				description: "Server certificate for Kubelet on node {{ $labels.node }} expires in {{ $value | humanizeDuration }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletservercertificateexpiration"
				summary:     "Kubelet server certificate is about to expire."
			}
			expr: "kubelet_certificate_manager_server_ttl_seconds < 86400"
			labels: severity: "critical"
		}, {
			alert: "KubeletClientCertificateRenewalErrors"
			annotations: {
				description: "Kubelet on node {{ $labels.node }} has failed to renew its client certificate ({{ $value | humanize }} errors in the last 5 minutes)."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletclientcertificaterenewalerrors"
				summary:     "Kubelet has failed to renew its client certificate."
			}
			expr: "increase(kubelet_certificate_manager_client_expiration_renew_errors[5m]) > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeletServerCertificateRenewalErrors"
			annotations: {
				description: "Kubelet on node {{ $labels.node }} has failed to renew its server certificate ({{ $value | humanize }} errors in the last 5 minutes)."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletservercertificaterenewalerrors"
				summary:     "Kubelet has failed to renew its server certificate."
			}
			expr: "increase(kubelet_server_expiration_renew_errors[5m]) > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeletDown"
			annotations: {
				description: "Kubelet has disappeared from Prometheus target discovery."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletdown"
				summary:     "Target disappeared from Prometheus target discovery."
			}
			expr: "absent(up{job=\"kubelet\", metrics_path=\"/metrics\"} == 1)"
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
			expr: "absent(up{job=\"kube-scheduler\"} == 1)"
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
				description: "There are {{ $value }} different semantic versions of Kubernetes components running."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeversionmismatch"
				summary:     "Different semantic versions of Kubernetes components running."
			}
			expr: "count by (cluster) (count by (git_version, cluster) (label_replace(kubernetes_build_info{job!~\"kube-dns|coredns\"},\"git_version\",\"$1\",\"git_version\",\"(v[0-9]*.[0-9]*).*\"))) > 1"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "KubeClientErrors"
			annotations: {
				description: "Kubernetes API server client '{{ $labels.job }}/{{ $labels.instance }}' is experiencing {{ $value | humanizePercentage }} errors.'"
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeclienterrors"
				summary:     "Kubernetes API server client is experiencing errors."
			}
			expr: """
				(sum(rate(rest_client_requests_total{code=~\"5..\"}[5m])) by (cluster, instance, job, namespace)
				  /
				sum(rate(rest_client_requests_total[5m])) by (cluster, instance, job, namespace))
				> 0.01
				"""

			for: "15m"
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
			expr: """
				topk by(cluster, namespace, pod) (1,
				  max by (cluster, node, namespace, pod) (
				    label_replace(kube_pod_info{job=\"kube-state-metrics\",node!=\"\"}, \"pod\", \"$1\", \"pod\", \"(.*)\")
				))
				"""

			record: "node_namespace_pod:kube_pod_info:"
		}, {
			expr: """
				count by (cluster, node) (
				  node_cpu_seconds_total{mode=\"idle\",job=\"node-exporter\"}
				  * on (namespace, pod) group_left(node)
				  topk by(namespace, pod) (1, node_namespace_pod:kube_pod_info:)
				)
				"""

			record: "node:node_num_cpu:sum"
		}, {
			expr: """
				sum(
				  node_memory_MemAvailable_bytes{job=\"node-exporter\"} or
				  (
				    node_memory_Buffers_bytes{job=\"node-exporter\"} +
				    node_memory_Cached_bytes{job=\"node-exporter\"} +
				    node_memory_MemFree_bytes{job=\"node-exporter\"} +
				    node_memory_Slab_bytes{job=\"node-exporter\"}
				  )
				) by (cluster)
				"""

			record: ":node_memory_MemAvailable_bytes:sum"
		}, {
			expr: """
				avg by (cluster, node) (
				  sum without (mode) (
				    rate(node_cpu_seconds_total{mode!=\"idle\",mode!=\"iowait\",mode!=\"steal\",job=\"node-exporter\"}[5m])
				  )
				)
				"""

			record: "node:node_cpu_utilization:ratio_rate5m"
		}, {
			expr: """
				avg by (cluster) (
				  node:node_cpu_utilization:ratio_rate5m
				)
				"""

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
				description: "Job {{ $labels.job }} (instance {{ $labels.instance }}) has restarted more than twice in the last 15 minutes. It might be crashlooping."
				summary:     "{{ $labels.job }} too many restarts (instance {{ $labels.instance }})"
			}
			expr: "changes(process_start_time_seconds{job=~\"victoriametrics|vmselect|vminsert|vmstorage|vmagent|vmalert\"}[15m]) > 2"
			labels: severity: "critical"
		}, {
			alert: "ServiceDown"
			annotations: {
				description: "{{ $labels.instance }} of job {{ $labels.job }} has been down for more than 2 minutes."
				summary:     "Service {{ $labels.job }} is down on {{ $labels.instance }}"
			}
			expr: "up{job=~\"victoriametrics|vmselect|vminsert|vmstorage|vmagent|vmalert\"} == 0"
			for:  "2m"
			labels: severity: "critical"
		}, {
			alert: "ProcessNearFDLimits"
			annotations: {
				description: "Exhausting OS file descriptors limit can cause severe degradation of the process. Consider to increase the limit as fast as possible."
				summary:     "Number of free file descriptors is less than 100 for \"{{ $labels.job }}\"(\"{{ $labels.instance }}\") for the last 5m"
			}
			expr: "(process_max_fds - process_open_fds) < 100"
			for:  "5m"
			labels: severity: "critical"
		}, {
			alert: "TooHighMemoryUsage"
			annotations: {
				description: "Too high memory usage may result into multiple issues such as OOMs or degraded performance. Consider to either increase available memory or decrease the load on the process."
				summary:     "It is more than 90% of memory used by \"{{ $labels.job }}\"(\"{{ $labels.instance }}\") during the last 5m"
			}
			expr: "(process_resident_memory_anon_bytes / vm_available_memory_bytes) > 0.9"
			for:  "5m"
			labels: severity: "critical"
		}, {
			alert: "TooHighCPUUsage"
			annotations: {
				description: "Too high CPU usage may be a sign of insufficient resources and make process unstable. Consider to either increase available CPU resources or decrease the load on the process."
				summary:     "More than 90% of CPU is used by \"{{ $labels.job }}\"(\"{{ $labels.instance }}\") during the last 5m"
			}
			expr: "rate(process_cpu_seconds_total[5m]) / process_cpu_cores_available > 0.9"
			for:  "5m"
			labels: severity: "critical"
		}, {
			alert: "TooManyLogs"
			annotations: {
				description: """
					Logging rate for job \"{{ $labels.job }}\" ({{ $labels.instance }}) is {{ $value }} for last 15m.
					 Worth to check logs for specific error messages.
					"""
				summary: "Too many logs printed for job \"{{ $labels.job }}\" ({{ $labels.instance }})"
			}
			expr: "sum(increase(vm_log_messages_total{level=\"error\"}[5m])) by (job, instance) > 0"
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
				dashboard:   "grafana.domain.com/d/G7Z9GzMGz?viewPanel=49&var-instance={{ $labels.instance }}"
				description: "Vmagent dropped {{ $value | humanize1024 }} from persistent queue on instance {{ $labels.instance }} for the last 10m."
				summary:     "Instance {{ $labels.instance }} is dropping data from persistent queue"
			}
			expr: "sum(increase(vm_persistentqueue_bytes_dropped_total[5m])) by (job, instance) > 0"
			for:  "10m"
			labels: severity: "critical"
		}, {
			alert: "RejectedRemoteWriteDataBlocksAreDropped"
			annotations: {
				dashboard: "grafana.domain.com/d/G7Z9GzMGz?viewPanel=79&var-instance={{ $labels.instance }}"
				summary:   "Job \"{{ $labels.job }}\" on instance {{ $labels.instance }} drops the rejected by remote-write server data blocks. Check the logs to find the reason for rejects."
			}
			expr: "sum(increase(vmagent_remotewrite_packets_dropped_total[5m])) by (job, instance) > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "TooManyScrapeErrors"
			annotations: {
				dashboard: "grafana.domain.com/d/G7Z9GzMGz?viewPanel=31&var-instance={{ $labels.instance }}"
				summary:   "Job \"{{ $labels.job }}\" on instance {{ $labels.instance }} fails to scrape targets for last 15m"
			}
			expr: "sum(increase(vm_promscrape_scrapes_failed_total[5m])) by (job, instance) > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "TooManyWriteErrors"
			annotations: {
				dashboard: "grafana.domain.com/d/G7Z9GzMGz?viewPanel=77&var-instance={{ $labels.instance }}"
				summary:   "Job \"{{ $labels.job }}\" on instance {{ $labels.instance }} responds with errors to write requests for last 15m."
			}
			expr: """
				(sum(increase(vm_ingestserver_request_errors_total[5m])) by (job, instance)
				+
				sum(increase(vmagent_http_request_errors_total[5m])) by (job, instance)) > 0
				"""

			for: "15m"
			labels: severity: "warning"
		}, {
			alert: "TooManyRemoteWriteErrors"
			annotations: {
				dashboard: "grafana.domain.com/d/G7Z9GzMGz?viewPanel=61&var-instance={{ $labels.instance }}"
				description: """
					Vmagent fails to push data via remote write protocol to destination \"{{ $labels.url }}\"
					 Ensure that destination is up and reachable.
					"""
				summary: "Job \"{{ $labels.job }}\" on instance {{ $labels.instance }} fails to push to remote storage"
			}
			expr: "sum(rate(vmagent_remotewrite_retries_count_total[5m])) by(job, instance, url) > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "RemoteWriteConnectionIsSaturated"
			annotations: {
				dashboard: "grafana.domain.com/d/G7Z9GzMGz?viewPanel=84&var-instance={{ $labels.instance }}"
				description: """
					The remote write connection between vmagent \"{{ $labels.job }}\" (instance {{ $labels.instance }}) and destination \"{{ $labels.url }}\" is saturated by more than 90% and vmagent won't be able to keep up.
					 This usually means that `-remoteWrite.queues` command-line flag must be increased in order to increase the number of connections per each remote storage.
					"""
				summary: "Remote write connection from \"{{ $labels.job }}\" (instance {{ $labels.instance }}) to {{ $labels.url }} is saturated"
			}
			expr: """
				sum(rate(vmagent_remotewrite_send_duration_seconds_total[5m])) by(job, instance, url)
				> 0.9 * max(vmagent_remotewrite_queues) by(job, instance, url)
				"""
			for: "15m"
			labels: severity: "warning"
		}, {
			alert: "PersistentQueueForWritesIsSaturated"
			annotations: {
				dashboard:   "grafana.domain.com/d/G7Z9GzMGz?viewPanel=98&var-instance={{ $labels.instance }}"
				description: "Persistent queue writes for vmagent \"{{ $labels.job }}\" (instance {{ $labels.instance }}) are saturated by more than 90% and vmagent won't be able to keep up with flushing data on disk. In this case, consider to decrease load on the vmagent or improve the disk throughput."
				summary:     "Persistent queue writes for instance {{ $labels.instance }} are saturated"
			}
			expr: "rate(vm_persistentqueue_write_duration_seconds_total[5m]) > 0.9"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "PersistentQueueForReadsIsSaturated"
			annotations: {
				dashboard:   "grafana.domain.com/d/G7Z9GzMGz?viewPanel=99&var-instance={{ $labels.instance }}"
				description: "Persistent queue reads for vmagent \"{{ $labels.job }}\" (instance {{ $labels.instance }}) are saturated by more than 90% and vmagent won't be able to keep up with reading data from the disk. In this case, consider to decrease load on the vmagent or improve the disk throughput."
				summary:     "Persistent queue reads for instance {{ $labels.instance }} are saturated"
			}
			expr: "rate(vm_persistentqueue_read_duration_seconds_total[5m]) > 0.9"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "SeriesLimitHourReached"
			annotations: {
				dashboard:   "grafana.domain.com/d/G7Z9GzMGz?viewPanel=88&var-instance={{ $labels.instance }}"
				description: "Max series limit set via -remoteWrite.maxHourlySeries flag is close to reaching the max value. Then samples for new time series will be dropped instead of sending them to remote storage systems."
				summary:     "Instance {{ $labels.instance }} reached 90% of the limit"
			}
			expr: "(vmagent_hourly_series_limit_current_series / vmagent_hourly_series_limit_max_series) > 0.9"
			labels: severity: "critical"
		}, {
			alert: "SeriesLimitDayReached"
			annotations: {
				dashboard:   "grafana.domain.com/d/G7Z9GzMGz?viewPanel=90&var-instance={{ $labels.instance }}"
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
			expr: """
				vm_promscrape_config_last_reload_successful != 1
				or
				vmagent_relabel_config_last_reload_successful != 1
				"""

			labels: severity: "warning"
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
				dashboard: "grafana.domain.com/d/wNf0q_kZk?viewPanel=73&var-instance={{ $labels.instance }}"
				description: """
					Taking into account current ingestion rate, free disk space will be enough only for {{ $value | humanizeDuration }} on instance {{ $labels.instance }}.
					 Consider to limit the ingestion rate, decrease retention or scale the disk space if possible.
					"""
				summary: "Instance {{ $labels.instance }} will run out of disk space soon"
			}
			expr: """
				vm_free_disk_space_bytes / ignoring(path)
				(
				   (
				    rate(vm_rows_added_to_storage_total[1d]) -
				    ignoring(type) rate(vm_deduplicated_samples_total{type=\"merge\"}[1d])
				   )
				  * scalar(
				    sum(vm_data_size_bytes{type!~\"indexdb.*\"}) /
				    sum(vm_rows{type!~\"indexdb.*\"})
				   )
				) < 3 * 24 * 3600 > 0
				"""

			for: "30m"
			labels: severity: "critical"
		}, {
			alert: "DiskRunsOutOfSpace"
			annotations: {
				dashboard: "grafana.domain.com/d/wNf0q_kZk?viewPanel=53&var-instance={{ $labels.instance }}"
				description: """
					Disk utilisation on instance {{ $labels.instance }} is more than 80%.
					 Having less than 20% of free disk space could cripple merges processes and overall performance. Consider to limit the ingestion rate, decrease retention or scale the disk space if possible.
					"""
				summary: "Instance {{ $labels.instance }} will run out of disk space soon"
			}
			expr: """
				sum(vm_data_size_bytes) by(instance) /
				(
				 sum(vm_free_disk_space_bytes) by(instance) +
				 sum(vm_data_size_bytes) by(instance)
				) > 0.8
				"""

			for: "30m"
			labels: severity: "critical"
		}, {
			alert: "RequestErrorsToAPI"
			annotations: {
				dashboard:   "grafana.domain.com/d/wNf0q_kZk?viewPanel=35&var-instance={{ $labels.instance }}"
				description: "Requests to path {{ $labels.path }} are receiving errors. Please verify if clients are sending correct requests."
				summary:     "Too many errors served for path {{ $labels.path }} (instance {{ $labels.instance }})"
			}
			expr: "increase(vm_http_request_errors_total[5m]) > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "ConcurrentFlushesHitTheLimit"
			annotations: {
				dashboard: "grafana.domain.com/d/wNf0q_kZk?viewPanel=59&var-instance={{ $labels.instance }}"
				description: """
					The limit of concurrent flushes on instance {{ $labels.instance }} is equal to number of CPUs.
					 When VictoriaMetrics constantly hits the limit it means that storage is overloaded and requires more CPU.
					"""
				summary: "VictoriaMetrics on instance {{ $labels.instance }} is constantly hitting concurrent flushes limit"
			}
			expr: "avg_over_time(vm_concurrent_insert_current[1m]) >= vm_concurrent_insert_capacity"
			for:  "15m"
			labels: {
				severity: "warning"
				show_at:  "dashboard"
			}
		}, {
			alert: "RowsRejectedOnIngestion"
			annotations: {
				dashboard:   "grafana.domain.com/d/wNf0q_kZk?viewPanel=58&var-instance={{ $labels.instance }}"
				description: "VM is rejecting to ingest rows on \"{{ $labels.instance }}\" due to the following reason: \"{{ $labels.reason }}\""
				summary:     "Some rows are rejected on \"{{ $labels.instance }}\" on ingestion attempt"
			}
			expr: "sum(rate(vm_rows_ignored_total[5m])) by (instance, reason) > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "TooHighChurnRate"
			annotations: {
				dashboard: "grafana.domain.com/d/wNf0q_kZk?viewPanel=66&var-instance={{ $labels.instance }}"
				description: """
					VM constantly creates new time series on \"{{ $labels.instance }}\".
					 This effect is known as Churn Rate.
					 High Churn Rate tightly connected with database performance and may result in unexpected OOM's or slow queries.
					"""
				summary: "Churn rate is more than 10% on \"{{ $labels.instance }}\" for the last 15m"
			}
			expr: """
				(
				   sum(rate(vm_new_timeseries_created_total[5m])) by(instance)
				   /
				   sum(rate(vm_rows_inserted_total[5m])) by (instance)
				 ) > 0.1
				"""

			for: "15m"
			labels: severity: "warning"
		}, {
			alert: "TooHighChurnRate24h"
			annotations: {
				dashboard: "grafana.domain.com/d/wNf0q_kZk?viewPanel=66&var-instance={{ $labels.instance }}"
				description: """
					The number of created new time series over last 24h is 3x times higher than current number of active series on \"{{ $labels.instance }}\".
					 This effect is known as Churn Rate.
					 High Churn Rate tightly connected with database performance and may result in unexpected OOM's or slow queries.
					"""
				summary: "Too high number of new series on \"{{ $labels.instance }}\" created over last 24h"
			}
			expr: """
				sum(increase(vm_new_timeseries_created_total[24h])) by(instance)
				>
				(sum(vm_cache_entries{type=\"storage/hour_metric_ids\"}) by(instance) * 3)
				"""

			for: "15m"
			labels: severity: "warning"
		}, {
			alert: "TooHighSlowInsertsRate"
			annotations: {
				dashboard:   "grafana.domain.com/d/wNf0q_kZk?viewPanel=68&var-instance={{ $labels.instance }}"
				description: "High rate of slow inserts on \"{{ $labels.instance }}\" may be a sign of resource exhaustion for the current load. It is likely more RAM is needed for optimal handling of the current number of active time series."
				summary:     "Percentage of slow inserts is more than 5% on \"{{ $labels.instance }}\" for the last 15m"
			}
			expr: """
				(
				   sum(rate(vm_slow_row_inserts_total[5m])) by(instance)
				   /
				   sum(rate(vm_rows_inserted_total[5m])) by (instance)
				 ) > 0.05
				"""

			for: "15m"
			labels: severity: "warning"
		}, {
			alert: "LabelsLimitExceededOnIngestion"
			annotations: {
				dashboard: "grafana.domain.com/d/wNf0q_kZk?viewPanel=74&var-instance={{ $labels.instance }}"
				description: """
					VictoriaMetrics limits the number of labels per each metric with `-maxLabelsPerTimeseries` command-line flag.
					 This prevents from ingesting metrics with too many labels. Please verify that `-maxLabelsPerTimeseries` is configured correctly or that clients which send these metrics aren't misbehaving.
					"""
				summary: "Metrics ingested in ({{ $labels.instance }}) are exceeding labels limit"
			}
			expr: "sum(increase(vm_metrics_with_dropped_labels_total[5m])) by (instance) > 0"
			for:  "15m"
			labels: severity: "warning"
		}]
	}]
}]
