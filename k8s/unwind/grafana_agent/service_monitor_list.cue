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
	spec: {
		endpoints: [{
			port:        "http-metrics"
			honorLabels: true
			relabelings: [{
				sourceLabels: ["__meta_kubernetes_service_annotation_prometheus_io_scrape"]
				action: "keep"
				regex:  "true"
			}]
		}]
		namespaceSelector: any: true
		selector: matchLabels: {}
	}
}, {
	metadata: name: "\(#Name)-kubelet"
	spec: {
		endpoints: [{
			bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
			honorLabels:     true
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
			path:        "/metrics"
			port:        "http-metrics"
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
