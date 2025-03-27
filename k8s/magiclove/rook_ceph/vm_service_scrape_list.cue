package rook_ceph

import operatorv1beta1 "github.com/VictoriaMetrics/operator/api/operator/v1beta1"

#VMServiceScrapeList: operatorv1beta1.#VMServiceScrapeList & {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMServiceScrapeList"
	items: [...{
		apiVersion: "operator.victoriametrics.com/v1beta1"
		kind:       "VMServiceScrape"
	}]
}

#VMServiceScrapeList: items: [{
	spec: {
		endpoints: [{port: "ceph-exporter-http-metrics"}]
		selector: matchLabels: {
			app:          "rook-ceph-exporter"
			rook_cluster: #Namespace
		}
	}
}, {
	metadata: name: "rook-ceph-mgr"
	spec: {
		endpoints: [{port: "http-metrics"}]
		selector: matchLabels: {
			app:          "rook-ceph-mgr"
			rook_cluster: #Namespace
		}
	}
}, {
	metadata: name: "csi-metrics"
	spec: {
		endpoints: [{
			port:     "csi-http-metrics"
			interval: "5s"
		}]
		selector: matchLabels: app: "csi-metrics"
	}
}]
