package promtail

import (
	"encoding/yaml"

	"k8s.io/api/core/v1"
)

config_map: [...v1.#ConfigMap]

config_map: [{
	apiVersion: "v1"
	kind:       "ConfigMap"
	data: "promtail.yaml": yaml.Marshal({
		server: {
			log_level:        "info"
			http_listen_port: 3101
		}
		client: url:         "http://loki.telemetry.svc:3100/loki/api/v1/push"
		positions: filename: "/run/promtail/positions.yaml"
		scrape_configs: [{
			// See also https://github.com/grafana/loki/blob/master/production/ksonnet/promtail/scrape_config.libsonnet for reference
			// Pods with a label 'app.kubernetes.io/name'
			job_name: "kubernetes-pods-app-kubernetes-io-name"
			pipeline_stages: [{
				docker: {}
			}, {
				cri: {}
			}]
			kubernetes_sd_configs: [{
				role: "pod"
			}]
			relabel_configs: [{
				action: "replace"
				source_labels: [
					"__meta_kubernetes_pod_label_app_kubernetes_io_name",
				]
				target_label: "app"
			}, {
				action: "drop"
				regex:  ""
				source_labels: [
					"app",
				]
			}, {
				action: "replace"
				source_labels: [
					"__meta_kubernetes_pod_label_app_kubernetes_io_component",
				]
				target_label: "component"
			}, {
				action: "replace"
				source_labels: [
					"__meta_kubernetes_namespace",
				]
				target_label: "namespace"
			}, {
				action:      "replace"
				replacement: "$1"
				separator:   "/"
				source_labels: [
					"namespace",
					"app",
				]
				target_label: "job"
			}, {
				action: "replace"
				source_labels: [
					"__meta_kubernetes_pod_name",
				]
				target_label: "pod"
			}, {
				action: "replace"
				source_labels: [
					"__meta_kubernetes_pod_container_name",
				]
				target_label: "container"
			}, {
				action:      "replace"
				replacement: "/var/log/pods/*$1/*.log"
				separator:   "/"
				source_labels: [
					"__meta_kubernetes_pod_uid",
					"__meta_kubernetes_pod_container_name",
				]
				target_label: "__path__"
			}, {
				action:      "replace"
				replacement: "/var/log/pods/*$1/*.log"
				separator:   "/"
				source_labels: [
					"__meta_kubernetes_pod_annotation_kubernetes_io_config_hash",
					"__meta_kubernetes_pod_container_name",
				]
				target_label: "__path__"
			}]
		}, {
			// Pods with a label 'app'
			job_name: "kubernetes-pods-app"
			pipeline_stages: [{
				docker: {}
			}, {
				cri: {}
			}]
			kubernetes_sd_configs: [{
				role: "pod"
			}]
			relabel_configs: [{
				// Drop pods with label 'app.kubernetes.io/name'. They are already considered above
				action: "drop"
				regex:  ".+"
				source_labels: [
					"__meta_kubernetes_pod_label_app_kubernetes_io_name",
				]
			}, {
				action: "replace"
				source_labels: [
					"__meta_kubernetes_pod_label_app",
				]
				target_label: "app"
			}, {
				action: "drop"
				regex:  ""
				source_labels: [
					"app",
				]
			}, {
				action: "replace"
				source_labels: [
					"__meta_kubernetes_pod_label_component",
				]
				target_label: "component"
			}, {
				action: "replace"
				source_labels: [
					"__meta_kubernetes_namespace",
				]
				target_label: "namespace"
			}, {
				action:      "replace"
				replacement: "$1"
				separator:   "/"
				source_labels: [
					"namespace",
					"app",
				]
				target_label: "job"
			}, {
				action: "replace"
				source_labels: [
					"__meta_kubernetes_pod_name",
				]
				target_label: "pod"
			}, {
				action: "replace"
				source_labels: [
					"__meta_kubernetes_pod_container_name",
				]
				target_label: "container"
			}, {
				action:      "replace"
				replacement: "/var/log/pods/*$1/*.log"
				separator:   "/"
				source_labels: [
					"__meta_kubernetes_pod_uid",
					"__meta_kubernetes_pod_container_name",
				]
				target_label: "__path__"
			}, {
				action:      "replace"
				replacement: "/var/log/pods/*$1/*.log"
				separator:   "/"
				source_labels: [
					"__meta_kubernetes_pod_annotation_kubernetes_io_config_hash",
					"__meta_kubernetes_pod_container_name",
				]
				target_label: "__path__"
			}]
		}, {
			// Pods with direct controllers, such as StatefulSet
			job_name: "kubernetes-pods-direct-controllers"
			pipeline_stages: [{
				docker: {}
			}, {
				cri: {}
			}]
			kubernetes_sd_configs: [{
				role: "pod"
			}]
			relabel_configs: [{
				// Drop pods with label 'app.kubernetes.io/name' or 'app'. They are already considered above
				action:    "drop"
				regex:     ".+"
				separator: ""
				source_labels: [
					"__meta_kubernetes_pod_label_app_kubernetes_io_name",
					"__meta_kubernetes_pod_label_app",
				]
			}, {
				action: "drop"
				regex:  "[0-9a-z-.]+-[0-9a-f]{8,10}"
				source_labels: [
					"__meta_kubernetes_pod_controller_name",
				]
			}, {
				action: "replace"
				source_labels: [
					"__meta_kubernetes_pod_controller_name",
				]
				target_label: "app"
			}, {
				action: "replace"
				source_labels: [
					"__meta_kubernetes_namespace",
				]
				target_label: "namespace"
			}, {
				action:      "replace"
				replacement: "$1"
				separator:   "/"
				source_labels: [
					"namespace",
					"app",
				]
				target_label: "job"
			}, {
				action: "replace"
				source_labels: [
					"__meta_kubernetes_pod_name",
				]
				target_label: "pod"
			}, {
				action: "replace"
				source_labels: [
					"__meta_kubernetes_pod_container_name",
				]
				target_label: "container"
			}, {
				action:      "replace"
				replacement: "/var/log/pods/*$1/*.log"
				separator:   "/"
				source_labels: [
					"__meta_kubernetes_pod_uid",
					"__meta_kubernetes_pod_container_name",
				]
				target_label: "__path__"
			}, {
				action:      "replace"
				replacement: "/var/log/pods/*$1/*.log"
				separator:   "/"
				source_labels: [
					"__meta_kubernetes_pod_annotation_kubernetes_io_config_hash",
					"__meta_kubernetes_pod_container_name",
				]
				target_label: "__path__"
			}]
		}, {
			// Pods with indirect controllers, such as Deployment
			job_name: "kubernetes-pods-indirect-controller"
			pipeline_stages: [{
				docker: {}
			}, {
				cri: {}
			}]
			kubernetes_sd_configs: [{
				role: "pod"
			}]
			relabel_configs: [{
				// Drop pods with label 'app.kubernetes.io/name' or 'app'. They are already considered above
				action:    "drop"
				regex:     ".+"
				separator: ""
				source_labels: [
					"__meta_kubernetes_pod_label_app_kubernetes_io_name",
					"__meta_kubernetes_pod_label_app",
				]
			}, {
				action: "keep"
				regex:  "[0-9a-z-.]+-[0-9a-f]{8,10}"
				source_labels: [
					"__meta_kubernetes_pod_controller_name",
				]
			}, {
				action: "replace"
				regex:  "([0-9a-z-.]+)-[0-9a-f]{8,10}"
				source_labels: [
					"__meta_kubernetes_pod_controller_name",
				]
				target_label: "app"
			}, {
				action: "replace"
				source_labels: [
					"__meta_kubernetes_namespace",
				]
				target_label: "namespace"
			}, {
				action:      "replace"
				replacement: "$1"
				separator:   "/"
				source_labels: [
					"namespace",
					"app",
				]
				target_label: "job"
			}, {
				action: "replace"
				source_labels: [
					"__meta_kubernetes_pod_name",
				]
				target_label: "pod"
			}, {
				action: "replace"
				source_labels: [
					"__meta_kubernetes_pod_container_name",
				]
				target_label: "container"
			}, {
				action:      "replace"
				replacement: "/var/log/pods/*$1/*.log"
				separator:   "/"
				source_labels: [
					"__meta_kubernetes_pod_uid",
					"__meta_kubernetes_pod_container_name",
				]
				target_label: "__path__"
			}, {
				action:      "replace"
				replacement: "/var/log/pods/*$1/*.log"
				separator:   "/"
				source_labels: [
					"__meta_kubernetes_pod_annotation_kubernetes_io_config_hash",
					"__meta_kubernetes_pod_container_name",
				]
				target_label: "__path__"
			}]
		}, {
			// All remaining pods not yet covered
			job_name: "kubernetes-other"
			pipeline_stages: [{
				docker: {}
			}, {
				cri: {}
			}]
			kubernetes_sd_configs: [{
				role: "pod"
			}]
			relabel_configs: [{
				// Drop what has already been covered
				action:    "drop"
				regex:     ".+"
				separator: ""
				source_labels: [
					"__meta_kubernetes_pod_label_app_kubernetes_io_name",
					"__meta_kubernetes_pod_label_app",
				]
			}, {
				action: "drop"
				regex:  ".+"
				source_labels: [
					"__meta_kubernetes_pod_controller_name",
				]
			}, {
				action: "replace"
				source_labels: [
					"__meta_kubernetes_pod_name",
				]
				target_label: "app"
			}, {
				action: "replace"
				source_labels: [
					"__meta_kubernetes_pod_label_component",
				]
				target_label: "component"
			}, {
				action: "replace"
				source_labels: [
					"__meta_kubernetes_namespace",
				]
				target_label: "namespace"
			}, {
				action:      "replace"
				replacement: "$1"
				separator:   "/"
				source_labels: [
					"namespace",
					"app",
				]
				target_label: "job"
			}, {
				action: "replace"
				source_labels: [
					"__meta_kubernetes_pod_name",
				]
				target_label: "pod"
			}, {
				action: "replace"
				source_labels: [
					"__meta_kubernetes_pod_container_name",
				]
				target_label: "container"
			}, {
				action:      "replace"
				replacement: "/var/log/pods/*$1/*.log"
				separator:   "/"
				source_labels: [
					"__meta_kubernetes_pod_uid",
					"__meta_kubernetes_pod_container_name",
				]
				target_label: "__path__"
			}, {
				action:      "replace"
				replacement: "/var/log/pods/*$1/*.log"
				separator:   "/"
				source_labels: [
					"__meta_kubernetes_pod_annotation_kubernetes_io_config_hash",
					"__meta_kubernetes_pod_container_name",
				]
				target_label: "__path__"
			}]
		}]
	})
}]
