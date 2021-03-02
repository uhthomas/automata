package helm_operator

helm_release: {
	apiVersion: "helm.fluxcd.io/v1"
	kind:       "HelmRelease"
	metadata: name: "helm-operator"
	spec: {
		releaseName: "helm-operator"
		chart: {
			repository: "https://charts.fluxcd.io"
			name:       "helm-operator"
			version:    "1.1.0"
		}
		values: {
			createCRD:       true
			logReleaseDiffs: true
			logFormat:       "json"
			helm: versions:      "v3"
			git: timeout:        "2m"
			rbac: pspEnabled:    true
			prometheus: enabled: true
			dashboards: enabled: true
		}
	}}
