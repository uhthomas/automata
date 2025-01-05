package fluent_bit

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
	data: {
		"custom_parsers.conf": """
			[PARSER]
			    Name        audit
			    Format      json
			    Time_Key    requestReceivedTimestamp
			    Time_Format %Y-%m-%dT%H:%M:%S.%L%z

			[PARSER]
			    Name        containerd
			    Format      regex
			    Regex       ^(?<time>[^ ]+) (?<stream>stdout|stderr) (?<logtag>[^ ]*) (?<log>.*)$
			    Time_Key    time
			    Time_Format %Y-%m-%dT%H:%M:%S.%L%z

			"""
		"fluent-bit.yaml": yaml.Marshal({
			service: {
				daemon:       "off"
				flush:        1
				daemon:       "off"
				log_level:    "warn"
				parsers_file: "/fluent-bit/etc/conf/custom_parsers.conf"
				http_server:  "on"
				http_listen:  "0.0.0.0"
				http_port:    2020
				health_check: "on"
			}
			pipeline: {
				inputs: [{
					name:   "tcp"
					listen: "0.0.0.0"
					port:   12345
					format: "json"
					tag:    "talos.*"
				}, {
					name:   "tail"
					alias:  "kubernetes"
					path:   "/var/log/containers/*.log"
					parser: "containerd"
					tag:    "kubernetes.*"
				}, {
					name:   "tail"
					alias:  "audit"
					path:   "/var/log/audit/kube/*.log"
					parser: "audit"
					tag:    "audit.*"
				}]
				filters: [{
					name:                  "kubernetes"
					alias:                 "kubernetes"
					match:                 "kubernetes.*"
					buffer_size:           0
					kube_tag_prefix:       "kubernetes.var.log.containers."
					merge_log:             "on"
					"k8s-logging.parser":  "on"
					"k8s-logging.exclude": "on"
					namespace_labels:      "on"
				}, {
					name:   "modify"
					match:  "kubernetes.*"
					add:    "source kubernetes"
					remove: "logtag"
				}, {
					name:         "nest"
					match:        "*"
					wildcard:     "pod_name"
					operation:    "lift"
					nested_under: "kubernetes"
					add_prefix:   "kubernetes_"
				}]
				outputs: [{
					name:             "http"
					match:            "*"
					host:             "victoria-logs.victoria-logs"
					port:             80
					compress:         "gzip"
					uri:              "/insert/jsonline?_stream_fields=stream,source,kubernetes_namespace_name,kubernetes_pod_name,kubernetes_container_name&_msg_field=log&_time_field=date"
					format:           "json_lines"
					json_date_format: "iso8601"
					header: ["AccountID 0", "ProjectID 0"]
				}]
			}
		})
	}
}]
