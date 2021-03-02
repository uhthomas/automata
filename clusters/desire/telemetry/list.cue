package telemetry

import (
	corev1 "k8s.io/api/core/v1"
	"github.com/uhthomas/automata/clusters/desire/telemetry/fluent_bit"
	"github.com/uhthomas/automata/clusters/desire/telemetry/grafana"
	"github.com/uhthomas/automata/clusters/desire/telemetry/kube_state_metrics"
	"github.com/uhthomas/automata/clusters/desire/telemetry/loki"
	"github.com/uhthomas/automata/clusters/desire/telemetry/prometheus"
)

corev1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: namespace: "telemetry"
	}]
}

items: [namespace] +
	fluent_bit.items +
	grafana.items +
	kube_state_metrics.items +
	loki.items +
	prometheus.items
