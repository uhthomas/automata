package ingress_nginx

helm_release: {
	apiVersion: "helm.fluxcd.io/v1"
	kind:       "HelmRelease"
	metadata: name: "ingress-nginx"
	spec: {
		releaseName: "ingress-nginx"
		chart: {
			repository: "https://kubernetes.github.io/ingress-nginx"
			name:       "ingress-nginx"
			version:    "3.20.1"
		}
		values: controller: {
			config: {
				"proxy-buffers-number": "8"
				"proxy-buffer-size":    "16k"
			}
			autoscaling: enabled:           true
			publishService: enabled:        true
			service: externalTrafficPolicy: "Local"
		}
	}
}
