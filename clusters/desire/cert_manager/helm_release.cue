package cert_manager

helm_release: {
	apiVersion: "helm.fluxcd.io/v1"
	kind:       "HelmRelease"
	metadata: name: "cert-manager"
	spec: {
		releaseName: "cert-manager"
		chart: {
			repository: "https://charts.jetstack.io"
			name:       "cert-manager"
			version:    "0.15.0"
		}
		values: installCRDs: true
	}
}
