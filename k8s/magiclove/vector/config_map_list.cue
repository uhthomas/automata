package vector

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
	data: "agent.yaml": yaml.Marshal({
		data_dir: "/vector-data-dir"
		api: {
			enabled:    true
			address:    "127.0.0.1:8686"
			playground: false
		}
		sources: {
			kubernetes_logs: type: "kubernetes_logs"
			host_metrics: {
				filesystem: {
					devices: excludes: ["binfmt_misc"]
					filesystems: excludes: ["binfmt_misc"]
					mountpoints: excludes: ["*/proc/sys/fs/binfmt_misc"]
				}
				type: "host_metrics"
			}
			internal_metrics: type: "internal_metrics"
		}
		sinks: {
			prom_exporter: {
				type: "prometheus_exporter"
				inputs: ["host_metrics", "internal_metrics"]
				address: "0.0.0.0:9090"
			}
			// stdout: {
			// 	type: "console"
			// 	inputs: ["kubernetes_logs"]
			// 	encoding: codec: "json"
			// }
			vlogs: {
				type: "http"
				inputs: ["kubernetes_logs"]
				uri: "http://victoria-logs.victoria-logs/insert/jsonline?_stream_fields=stream,source_type,kubernetes.pod_node_name,kubernetes.pod_namespace,kubernetes.pod_owner,kubernetes.pod_name,kubernetes.container_name&_msg_field=message&_time_field=timestamp"
				encoding: codec:      "json"
				framing: method:      "newline_delimited"
				healthcheck: enabled: false
				request: headers: {
					AccountID: "0"
					ProjectID: "0"
				}
			}
			// [sinks.vlogs]
			//   inputs = [ "your_input" ]
			//   type = "http"
			//   uri = "http://localhost:9428/insert/jsonline?_stream_fields=host,container_name&_msg_field=message&_time_field=timestamp"
			//   encoding.codec = "json"
			//   framing.method = "newline_delimited"
			//   healthcheck.enabled = false

			//   [sinks.vlogs.request.headers]
			//     AccountID = "12"
			//     ProjectID = "34"
		}
	})
}]
