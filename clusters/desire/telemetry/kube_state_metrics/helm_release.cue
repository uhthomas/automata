package kube_state_metrics

helm_release: {
	apiVersion: "helm.fluxcd.io/v1"
	kind:       "HelmRelease"
	metadata: name: "kube-state-metrics"
	spec: {
		releaseName: "kube-state-metrics"
		chart: {
			repository: "https://kubernetes.github.io/kube-state-metrics"
			name:       "kube-state-metrics"
			version:    "2.9.7"
		}
		values: {
			autosharding: enabled:      true
			podSecurityPolicy: enabled: true
		}
	}
}
