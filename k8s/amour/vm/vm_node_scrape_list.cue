package vm

import "k8s.io/api/core/v1"

// TODO: Use generated types.
//
// https://github.com/cue-lang/cue/issues/2466
#VMNodeScrapeList: v1.#List & {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMNodeScrapeList"
	items: [...{
		apiVersion: "operator.victoriametrics.com/v1beta1"
		kind:       "VMNodeScrape"
	}]
}

#VMNodeScrapeList: items: [{
	metadata: name: "cadvisor"
	spec: {
		path:   "/metrics/cadvisor"
		scheme: "https"
		tlsConfig: {
			caFile:             "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
			insecureSkipVerify: true
		}
		bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
		honorLabels:     true
		metricRelabelConfigs: [{
			regex:  "(uid)"
			action: "labeldrop"
		}, {
			regex:  "(id|name)"
			action: "labeldrop"
		}, {
			sourceLabels: ["__name__"]
			regex:  "(rest_client_request_duration_seconds_bucket|rest_client_request_duration_seconds_sum|rest_client_request_duration_seconds_count)"
			action: "drop"
		}]
		relabelConfigs: [{
			regex:  "__meta_kubernetes_node_label_(.+)"
			action: "labelmap"
		}, {
			targetLabel: "metrics_path"
			sourceLabels: ["__metrics_path__"]
		}, {
			targetLabel: "job"
			replacement: "kubelet"
		}]
	}
}, {
	metadata: name: "probes"
	spec: {
		path:   "/metrics/probes"
		scheme: "https"
		tlsConfig: {
			caFile:             "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
			insecureSkipVerify: true
		}
		bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
		honorLabels:     true
		metricRelabelConfigs: [{
			regex:  "(uid)"
			action: "labeldrop"
		}, {
			regex:  "(id|name)"
			action: "labeldrop"
		}, {
			sourceLabels: ["__name__"]
			regex:  "(rest_client_request_duration_seconds_bucket|rest_client_request_duration_seconds_sum|rest_client_request_duration_seconds_count)"
			action: "drop"
		}]
		relabelConfigs: [{
			regex:  "__meta_kubernetes_node_label_(.+)"
			action: "labelmap"
		}, {
			targetLabel: "metrics_path"
			sourceLabels: ["__metrics_path__"]
		}, {
			targetLabel: "job"
			replacement: "kubelet"
		}]
	}
}, {
	metadata: name: "kubelet"
	spec: {
		scheme: "https"
		tlsConfig: {
			caFile:             "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
			insecureSkipVerify: true
		}
		bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
		honorLabels:     true
		metricRelabelConfigs: [{
			regex:  "(uid)"
			action: "labeldrop"
		}, {
			regex:  "(id|name)"
			action: "labeldrop"
		}, {
			sourceLabels: ["__name__"]
			regex:  "(rest_client_request_duration_seconds_bucket|rest_client_request_duration_seconds_sum|rest_client_request_duration_seconds_count)"
			action: "drop"
		}]
		relabelConfigs: [{
			regex:  "__meta_kubernetes_node_label_(.+)"
			action: "labelmap"
		}, {
			targetLabel: "metrics_path"
			sourceLabels: ["__metrics_path__"]
		}, {
			targetLabel: "job"
			replacement: "kubelet"
		}]
	}
}]
