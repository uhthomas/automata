package grafana

import (
	"crypto/sha256"
	"encoding/hex"

	grafanav1beta1 "github.com/grafana/grafana-operator/v5/api/v1beta1"
)

#GrafanaDashboardList: grafanav1beta1.#GrafanaDashboardList & {
	apiVersion: "grafana.integreatly.org/v1beta1"
	kind:       "GrafanaDashboardList"
	items: [...{
		apiVersion: "grafana.integreatly.org/v1beta1"
		kind:       "GrafanaDashboard"
	}]
}

let dashboards = {
	General: [
		// Node Exporter Full
		// https://grafana.com/grafana/dashboards/1860
		1860,
	]
	Ceph: [
		"https://raw.githubusercontent.com/ceph/ceph/278d89538d248b92584c49442aef613cf0540c8a/monitoring/ceph-mixin/dashboards_out/ceph-cluster-advanced.json",
		"https://raw.githubusercontent.com/ceph/ceph/278d89538d248b92584c49442aef613cf0540c8a/monitoring/ceph-mixin/dashboards_out/ceph-cluster.json",
		"https://raw.githubusercontent.com/ceph/ceph/278d89538d248b92584c49442aef613cf0540c8a/monitoring/ceph-mixin/dashboards_out/cephfs-overview.json",
		"https://raw.githubusercontent.com/ceph/ceph/278d89538d248b92584c49442aef613cf0540c8a/monitoring/ceph-mixin/dashboards_out/host-details.json",
		"https://raw.githubusercontent.com/ceph/ceph/278d89538d248b92584c49442aef613cf0540c8a/monitoring/ceph-mixin/dashboards_out/hosts-overview.json",
		"https://raw.githubusercontent.com/ceph/ceph/278d89538d248b92584c49442aef613cf0540c8a/monitoring/ceph-mixin/dashboards_out/multi-cluster-overview.json",
		"https://raw.githubusercontent.com/ceph/ceph/278d89538d248b92584c49442aef613cf0540c8a/monitoring/ceph-mixin/dashboards_out/osd-device-details.json",
		"https://raw.githubusercontent.com/ceph/ceph/278d89538d248b92584c49442aef613cf0540c8a/monitoring/ceph-mixin/dashboards_out/osds-overview.json",
		"https://raw.githubusercontent.com/ceph/ceph/278d89538d248b92584c49442aef613cf0540c8a/monitoring/ceph-mixin/dashboards_out/pool-detail.json",
		"https://raw.githubusercontent.com/ceph/ceph/278d89538d248b92584c49442aef613cf0540c8a/monitoring/ceph-mixin/dashboards_out/pool-overview.json",
		"https://raw.githubusercontent.com/ceph/ceph/278d89538d248b92584c49442aef613cf0540c8a/monitoring/ceph-mixin/dashboards_out/radosgw-detail.json",
		"https://raw.githubusercontent.com/ceph/ceph/278d89538d248b92584c49442aef613cf0540c8a/monitoring/ceph-mixin/dashboards_out/radosgw-overview.json",
		"https://raw.githubusercontent.com/ceph/ceph/278d89538d248b92584c49442aef613cf0540c8a/monitoring/ceph-mixin/dashboards_out/radosgw-sync-overview.json",
		"https://raw.githubusercontent.com/ceph/ceph/278d89538d248b92584c49442aef613cf0540c8a/monitoring/ceph-mixin/dashboards_out/rbd-details.json",
		"https://raw.githubusercontent.com/ceph/ceph/278d89538d248b92584c49442aef613cf0540c8a/monitoring/ceph-mixin/dashboards_out/rbd-overview.json",
		"https://raw.githubusercontent.com/ceph/ceph/278d89538d248b92584c49442aef613cf0540c8a/monitoring/ceph-mixin/dashboards_out/rgw-s3-analytics.json",
	]
	"Cert Manager": [
		"https://gitlab.com/uneeq-oss/cert-manager-mixin/-/raw/master/dashboards/cert-manager.json",
	]
	Kubernetes: [
		// Kubernetes / System / API Server
		// https://grafana.com/grafana/dashboards/15761
		15761,
		// Kubernetes / System / CoreDNS
		// https://grafana.com/grafana/dashboards/15762
		15762,
		// Kubernetes / Views / Global
		// https://grafana.com/grafana/dashboards/15757
		15757,
		// Kubernetes / Views / Namespaces
		// https://grafana.com/grafana/dashboards/15758
		15758,
		// Kubernetes / Views / Nodes
		// https://grafana.com/grafana/dashboards/15759
		15759,
		// Kubernetes / Views / Pods
		// https://grafana.com/grafana/dashboards/15760
		15760,
		// Trivy Operator - Vulnerabilities
		// https://grafana.com/grafana/dashboards/16337
		16337,
		// Prometheus
		// https://grafana.com/grafana/dashboards/19105
		19105,
	]
	VictoriaLogs: ["https://raw.githubusercontent.com/VictoriaMetrics/VictoriaMetrics/7b20de4674f9594ef17cbba7aa5c735c11788195/dashboards/victorialogs.json"]
	VictoriaMetrics: [
		// VictoriaMetrics - single-node
		// https://grafana.com/grafana/dashboards/10229
		10229,
		// VictoriaMetrics - vmagent
		// https://grafana.com/grafana/dashboards/12683
		12683,
		// VictoriaMetrics - vmalert
		// https://grafana.com/grafana/dashboards/14950
		14950,
		// VictoriaMetrics - operator
		// https://grafana.com/grafana/dashboards/17869
		17869,
	]
}

#GrafanaDashboardList: items: [for folderName, dashboardRefs in dashboards for dashboardRef in dashboardRefs {
	metadata: name: "\(#Name)-\(hex.Encode(sha256.Sum256('\(folderName)-\(dashboardRef)')))"
	spec: {
		if (dashboardRef & string) != _|_ {
			url: dashboardRef
		}
		if (dashboardRef & int) != _|_ {
			grafanaCom: id: dashboardRef
		}
		instanceSelector: matchLabels: "app.kubernetes.io/name": #Name
		folder: folderName
		datasources: [if folder == "EMQX MQTT" {
			inputName:      "prometheus"
			datasourceName: "default"
		}, if "\(dashboardRef)" == "17446" {
			inputName:      "DS_PROMETHEUS"
			datasourceName: "default"
		}]
	}
}]
