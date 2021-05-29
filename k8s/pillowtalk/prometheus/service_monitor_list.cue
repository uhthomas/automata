package prometheus

import "k8s.io/api/core/v1"

serviceMonitorList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "monitoring.coreos.com/v1"
		kind:       "ServiceMonitor"
	}]
}

serviceMonitorList: items: [{
	spec: {
		endpoints: [{port: "web"}]
		selector: matchLabels: {
			"app.kubernetes.io/name":      "prometheus"
			"app.kubernetes.io/instance":  "prometheus"
			"app.kubernetes.io/component": "prometheus"
		}
	}
}, {
	metadata: name: "prometheus-operator"
	spec: {
		endpoints: [{port: "http"}]
		selector: matchLabels: {
			"app.kubernetes.io/name":      "prometheus-operator"
			"app.kubernetes.io/instance":  "prometheus-operator"
			"app.kubernetes.io/component": "controller"
		}
		namespaceSelector: matchNames: ["prometheus-operator"]
	}
}, {
	metadata: name: "kube-state-metrics"
	spec: {
		endpoints: [{
			port: "http-metrics"
			relabelings: [{
				action: "labeldrop"
				regex:  "(pod|service|endpoint|namespace)"
			}]
		}, {port: "telemetry"}]
		jobLabel: "app.kubernetes.io/name"
		selector: matchLabels: {
			"app.kubernetes.io/name":      "kube-state-metrics"
			"app.kubernetes.io/instance":  "kube-state-metrics"
			"app.kubernetes.io/component": "kube-state-metrics"
		}
		namespaceSelector: matchNames: ["kube-state-metrics"]
	}
}, {
	metadata: name: "kube-dns"
	spec: {
		endpoints: [{port: "metrics"}]
		selector: matchLabels: "k8s-app": "kube-dns"
		namespaceSelector: matchNames: ["kube-system"]
	}
}, {
	metadata: name: "node-exporter"
	spec: {
		endpoints: [{
			port: "metrics"
			relabelings: [{
				action:      "replace"
				regex:       "(.*)"
				replacement: "$1"
				sourceLabels: ["__meta_kubernetes_pod_node_name"]
				targetLabel: "instance"
			}]
		}]
		jobLabel: "app.kubernetes.io/name"
		selector: matchLabels: {
			"app.kubernetes.io/name":      "node-exporter"
			"app.kubernetes.io/instance":  "node-exporter"
			"app.kubernetes.io/component": "exporter"
		}
		namespaceSelector: matchNames: ["node-exporter"]
	}
}, {
	metadata: {
		name: "rook-ceph-mgr"
		labels: team: "rook"
	}
	spec: {
		namespaceSelector: matchNames: ["rook-ceph"]
		selector: matchLabels: {
			app:            "rook-ceph-mgr"
			rook_cluster:   "rook-ceph"
			ceph_daemon_id: "a"
		}
		endpoints: [{
			port:     "http-metrics"
			path:     "/metrics"
			interval: "5s"
		}]
	}
}, {
	metadata: {
		name: "csi-metrics"
		labels: team: "rook"
	}
	spec: {
		namespaceSelector: matchNames: ["rook-ceph"]
		selector: matchLabels: app: "csi-metrics"
		endpoints: [{
			port:     "csi-http-metrics"
			path:     "/metrics"
			interval: "5s"
		}]
	}
}]
