package node_exporter

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
	metadata: name: "node-exporter.rules"
	spec: groups: [{
		name: "node-exporter.rules"
		rules: [{
			expr: """
				count without (cpu, mode) (
				  node_cpu_seconds_total{job=\"node-exporter\",mode=\"idle\"}
				)
				"""

			record: "instance:node_num_cpu:sum"
		}, {
			expr: """
				1 - avg without (cpu) (
				  sum without (mode) (rate(node_cpu_seconds_total{job=\"node-exporter\", mode=~\"idle|iowait|steal\"}[5m]))
				)
				"""

			record: "instance:node_cpu_utilisation:rate5m"
		}, {
			expr: """
				(
				  node_load1{job=\"node-exporter\"}
				/
				  instance:node_num_cpu:sum{job=\"node-exporter\"}
				)
				"""

			record: "instance:node_load1_per_cpu:ratio"
		}, {
			expr: """
				1 - (
				  (
				    node_memory_MemAvailable_bytes{job=\"node-exporter\"}
				    or
				    (
				      node_memory_Buffers_bytes{job=\"node-exporter\"}
				      +
				      node_memory_Cached_bytes{job=\"node-exporter\"}
				      +
				      node_memory_MemFree_bytes{job=\"node-exporter\"}
				      +
				      node_memory_Slab_bytes{job=\"node-exporter\"}
				    )
				  )
				/
				  node_memory_MemTotal_bytes{job=\"node-exporter\"}
				)
				"""

			record: "instance:node_memory_utilisation:ratio"
		}, {
			expr:   "rate(node_vmstat_pgmajfault{job=\"node-exporter\"}[5m])"
			record: "instance:node_vmstat_pgmajfault:rate5m"
		}, {
			expr:   "rate(node_disk_io_time_seconds_total{job=\"node-exporter\", device=~\"(/dev/)?(mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|md.+|dasd.+)\"}[5m])"
			record: "instance_device:node_disk_io_time_seconds:rate5m"
		}, {
			expr:   "rate(node_disk_io_time_weighted_seconds_total{job=\"node-exporter\", device=~\"(/dev/)?(mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|md.+|dasd.+)\"}[5m])"
			record: "instance_device:node_disk_io_time_weighted_seconds:rate5m"
		}, {
			expr: """
				sum without (device) (
				  rate(node_network_receive_bytes_total{job=\"node-exporter\", device!=\"lo\"}[5m])
				)
				"""

			record: "instance:node_network_receive_bytes_excluding_lo:rate5m"
		}, {
			expr: """
				sum without (device) (
				  rate(node_network_transmit_bytes_total{job=\"node-exporter\", device!=\"lo\"}[5m])
				)
				"""

			record: "instance:node_network_transmit_bytes_excluding_lo:rate5m"
		}, {
			expr: """
				sum without (device) (
				  rate(node_network_receive_drop_total{job=\"node-exporter\", device!=\"lo\"}[5m])
				)
				"""

			record: "instance:node_network_receive_drop_excluding_lo:rate5m"
		}, {
			expr: """
				sum without (device) (
				  rate(node_network_transmit_drop_total{job=\"node-exporter\", device!=\"lo\"}[5m])
				)
				"""

			record: "instance:node_network_transmit_drop_excluding_lo:rate5m"
		}]
	}]
}, {
	metadata: name: "node-exporter"
	spec: groups: [{
		name: "node-exporter"
		rules: [{
			alert: "NodeFilesystemSpaceFillingUp"
			annotations: {
				description: "Filesystem on {{ $labels.device }} at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available space left and is filling up."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodefilesystemspacefillingup"
				summary:     "Filesystem is predicted to run out of space within the next 24 hours."
			}
			expr: """
				(
				  node_filesystem_avail_bytes{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"} / node_filesystem_size_bytes{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"} * 100 < 15
				and
				  predict_linear(node_filesystem_avail_bytes{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"}[6h], 24*60*60) < 0
				and
				  node_filesystem_readonly{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"} == 0
				)
				"""

			for: "1h"
			labels: severity: "warning"
		}, {
			alert: "NodeFilesystemSpaceFillingUp"
			annotations: {
				description: "Filesystem on {{ $labels.device }} at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available space left and is filling up fast."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodefilesystemspacefillingup"
				summary:     "Filesystem is predicted to run out of space within the next 4 hours."
			}
			expr: """
				(
				  node_filesystem_avail_bytes{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"} / node_filesystem_size_bytes{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"} * 100 < 10
				and
				  predict_linear(node_filesystem_avail_bytes{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"}[6h], 4*60*60) < 0
				and
				  node_filesystem_readonly{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"} == 0
				)
				"""

			for: "1h"
			labels: severity: "critical"
		}, {
			alert: "NodeFilesystemAlmostOutOfSpace"
			annotations: {
				description: "Filesystem on {{ $labels.device }} at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available space left."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodefilesystemalmostoutofspace"
				summary:     "Filesystem has less than 5% space left."
			}
			expr: """
				(
				  node_filesystem_avail_bytes{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"} / node_filesystem_size_bytes{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"} * 100 < 5
				and
				  node_filesystem_readonly{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"} == 0
				)
				"""

			for: "30m"
			labels: severity: "warning"
		}, {
			alert: "NodeFilesystemAlmostOutOfSpace"
			annotations: {
				description: "Filesystem on {{ $labels.device }} at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available space left."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodefilesystemalmostoutofspace"
				summary:     "Filesystem has less than 3% space left."
			}
			expr: """
				(
				  node_filesystem_avail_bytes{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"} / node_filesystem_size_bytes{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"} * 100 < 3
				and
				  node_filesystem_readonly{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"} == 0
				)
				"""

			for: "30m"
			labels: severity: "critical"
		}, {
			alert: "NodeFilesystemFilesFillingUp"
			annotations: {
				description: "Filesystem on {{ $labels.device }} at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available inodes left and is filling up."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodefilesystemfilesfillingup"
				summary:     "Filesystem is predicted to run out of inodes within the next 24 hours."
			}
			expr: """
				(
				  node_filesystem_files_free{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"} / node_filesystem_files{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"} * 100 < 40
				and
				  predict_linear(node_filesystem_files_free{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"}[6h], 24*60*60) < 0
				and
				  node_filesystem_readonly{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"} == 0
				)
				"""

			for: "1h"
			labels: severity: "warning"
		}, {
			alert: "NodeFilesystemFilesFillingUp"
			annotations: {
				description: "Filesystem on {{ $labels.device }} at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available inodes left and is filling up fast."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodefilesystemfilesfillingup"
				summary:     "Filesystem is predicted to run out of inodes within the next 4 hours."
			}
			expr: """
				(
				  node_filesystem_files_free{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"} / node_filesystem_files{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"} * 100 < 20
				and
				  predict_linear(node_filesystem_files_free{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"}[6h], 4*60*60) < 0
				and
				  node_filesystem_readonly{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"} == 0
				)
				"""

			for: "1h"
			labels: severity: "critical"
		}, {
			alert: "NodeFilesystemAlmostOutOfFiles"
			annotations: {
				description: "Filesystem on {{ $labels.device }} at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available inodes left."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodefilesystemalmostoutoffiles"
				summary:     "Filesystem has less than 5% inodes left."
			}
			expr: """
				(
				  node_filesystem_files_free{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"} / node_filesystem_files{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"} * 100 < 5
				and
				  node_filesystem_readonly{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"} == 0
				)
				"""

			for: "1h"
			labels: severity: "warning"
		}, {
			alert: "NodeFilesystemAlmostOutOfFiles"
			annotations: {
				description: "Filesystem on {{ $labels.device }} at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available inodes left."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodefilesystemalmostoutoffiles"
				summary:     "Filesystem has less than 3% inodes left."
			}
			expr: """
				(
				  node_filesystem_files_free{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"} / node_filesystem_files{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"} * 100 < 3
				and
				  node_filesystem_readonly{job=\"node-exporter\",fstype!=\"\",mountpoint!=\"\"} == 0
				)
				"""

			for: "1h"
			labels: severity: "critical"
		}, {
			alert: "NodeNetworkReceiveErrs"
			annotations: {
				description: "{{ $labels.instance }} interface {{ $labels.device }} has encountered {{ printf \"%.0f\" $value }} receive errors in the last two minutes."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodenetworkreceiveerrs"
				summary:     "Network interface is reporting many receive errors."
			}
			expr: "rate(node_network_receive_errs_total[2m]) / rate(node_network_receive_packets_total[2m]) > 0.01"
			for:  "1h"
			labels: severity: "warning"
		}, {
			alert: "NodeNetworkTransmitErrs"
			annotations: {
				description: "{{ $labels.instance }} interface {{ $labels.device }} has encountered {{ printf \"%.0f\" $value }} transmit errors in the last two minutes."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodenetworktransmiterrs"
				summary:     "Network interface is reporting many transmit errors."
			}
			expr: "rate(node_network_transmit_errs_total[2m]) / rate(node_network_transmit_packets_total[2m]) > 0.01"
			for:  "1h"
			labels: severity: "warning"
		}, {
			alert: "NodeHighNumberConntrackEntriesUsed"
			annotations: {
				description: "{{ $value | humanizePercentage }} of conntrack entries are used."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodehighnumberconntrackentriesused"
				summary:     "Number of conntrack are getting close to the limit."
			}
			expr: "(node_nf_conntrack_entries / node_nf_conntrack_entries_limit) > 0.75"
			labels: severity: "warning"
		}, {
			alert: "NodeTextFileCollectorScrapeError"
			annotations: {
				description: "Node Exporter text file collector failed to scrape."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodetextfilecollectorscrapeerror"
				summary:     "Node Exporter text file collector failed to scrape."
			}
			expr: "node_textfile_scrape_error{job=\"node-exporter\"} == 1"
			labels: severity: "warning"
		}, {
			alert: "NodeClockSkewDetected"
			annotations: {
				description: "Clock on {{ $labels.instance }} is out of sync by more than 300s. Ensure NTP is configured correctly on this host."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodeclockskewdetected"
				summary:     "Clock skew detected."
			}
			expr: """
				(
				  node_timex_offset_seconds{job=\"node-exporter\"} > 0.05
				and
				  deriv(node_timex_offset_seconds{job=\"node-exporter\"}[5m]) >= 0
				)
				or
				(
				  node_timex_offset_seconds{job=\"node-exporter\"} < -0.05
				and
				  deriv(node_timex_offset_seconds{job=\"node-exporter\"}[5m]) <= 0
				)
				"""

			for: "10m"
			labels: severity: "warning"
		}, {
			alert: "NodeClockNotSynchronising"
			annotations: {
				description: "Clock on {{ $labels.instance }} is not synchronising. Ensure NTP is configured on this host."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodeclocknotsynchronising"
				summary:     "Clock not synchronising."
			}
			expr: """
				min_over_time(node_timex_sync_status{job=\"node-exporter\"}[5m]) == 0
				and
				node_timex_maxerror_seconds{job=\"node-exporter\"} >= 16
				"""

			for: "10m"
			labels: severity: "warning"
		}, {
			alert: "NodeRAIDDegraded"
			annotations: {
				description: "RAID array '{{ $labels.device }}' on {{ $labels.instance }} is in degraded state due to one or more disks failures. Number of spare drives is insufficient to fix issue automatically."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/noderaiddegraded"
				summary:     "RAID Array is degraded"
			}
			expr: "node_md_disks_required{job=\"node-exporter\",device=~\"(/dev/)?(mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|md.+|dasd.+)\"} - ignoring (state) (node_md_disks{state=\"active\",job=\"node-exporter\",device=~\"(/dev/)?(mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|md.+|dasd.+)\"}) > 0"
			for:  "15m"
			labels: severity: "critical"
		}, {
			alert: "NodeRAIDDiskFailure"
			annotations: {
				description: "At least one device in RAID array on {{ $labels.instance }} failed. Array '{{ $labels.device }}' needs attention and possibly a disk swap."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/noderaiddiskfailure"
				summary:     "Failed device in RAID array"
			}
			expr: "node_md_disks{state=\"failed\",job=\"node-exporter\",device=~\"(/dev/)?(mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|md.+|dasd.+)\"} > 0"
			labels: severity: "warning"
		}, {
			alert: "NodeFileDescriptorLimit"
			annotations: {
				description: "File descriptors limit at {{ $labels.instance }} is currently at {{ printf \"%.2f\" $value }}%."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodefiledescriptorlimit"
				summary:     "Kernel is predicted to exhaust file descriptors limit soon."
			}
			expr: """
				(
				  node_filefd_allocated{job=\"node-exporter\"} * 100 / node_filefd_maximum{job=\"node-exporter\"} > 70
				)
				"""

			for: "15m"
			labels: severity: "warning"
		}, {
			alert: "NodeFileDescriptorLimit"
			annotations: {
				description: "File descriptors limit at {{ $labels.instance }} is currently at {{ printf \"%.2f\" $value }}%."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodefiledescriptorlimit"
				summary:     "Kernel is predicted to exhaust file descriptors limit soon."
			}
			expr: """
				(
				  node_filefd_allocated{job=\"node-exporter\"} * 100 / node_filefd_maximum{job=\"node-exporter\"} > 90
				)
				"""

			for: "15m"
			labels: severity: "critical"
		}]
	}]
}]
