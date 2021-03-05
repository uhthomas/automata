package vector

import (
	"encoding/json"

	corev1 "k8s.io/api/core/v1"
)

config_map: [...corev1.#ConfigMap]

config_map: [{
	apiVersion: "v1"
	kind:       "ConfigMap"
	metadata: name: "vector"
	data: "vector.json": json.Marshal({
		data_dir: "/run/vector"
		log_schema: {
			host_key:        "host"
			message_key:     "message"
			source_type_key: "source_type"
			timestamp_key:   "timestamp"
		}
		sources: {
			kubernetes_logs: type:  "kubernetes_logs"
			host_metrics: type:     "host_metrics"
			internal_metrics: type: "internal_metrics"
		}
		sinks: {
			prometheus: {
				type:    "prometheus"
				address: ":9090"
				inputs: ["internal_metrics", "host_metrics"]
			}
			loki: {
				type: "loki"
				inputs: ["kubernetes_logs"]
				endpoint: "http://telemetry.loki.svc:3100"
				encoding: codec:      "json"
				healthcheck: enabled: "true"
			}
		}
	})
}]
