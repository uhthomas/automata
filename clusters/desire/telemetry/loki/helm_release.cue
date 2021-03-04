package loki

helm_release: {
	apiVersion: "helm.fluxcd.io/v1"
	kind:       "HelmRelease"
	metadata: name: "loki"
	spec: {
		releaseName: "loki"
		chart: {
			repository: "https://grafana.github.io/loki/charts"
			name:       "loki"
			version:    "2.3.0"
		}
	}
}
