package fluent_bit

helm_release: {
	apiVersion: "helm.fluxcd.io/v1"
	kind:       "HelmRelease"
	metadata: name: "fluent-bit"
	spec: {
		releaseName: "fluent-bit"
		chart: {
			repository: "https://grafana.github.io/loki/charts"
			name:       "fluent-bit"
			version:    "0.1.3"
		}
		values: loki: serviceName: "loki"
	}
}
