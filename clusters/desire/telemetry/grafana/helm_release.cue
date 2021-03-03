package grafana

helm_release: {
	apiVersion: "helm.fluxcd.io/v1"
	kind:       "HelmRelease"
	metadata: name: "grafana"
	spec: {
		releaseName: "grafana"
		chart: {
			repository: "https://grafana.github.io/helm-charts"
			name:       "grafana"
			version:    "6.4.5"
		}
		values: {
			// 7.4.3
			image: sha: "16dc29783ec7d4a23fa19207507586344c6797023604347eb3e8ea5ae431e181"
			"grafana.ini": "auth.anonymous": {
				enabled:  true
				org_role: "Admin"
			}
			ingress: {
				enabled: true
				annotations: {
					"kubernetes.io/ingress.class":             "nginx"
					"cert-manager.io/cluster-issuer":          "letsencrypt"
					"nginx.ingress.kubernetes.io/auth-url":    "https://sso.6f.io/oauth2/auth"
					"nginx.ingress.kubernetes.io/auth-signin": "https://sso.6f.io/oauth2/start?rd=https://$host$request_uri"
				}
				tls: [{
					hosts: [
						"grafana.6f.io",
					]
					secretName: "grafana-tls"
				}]
				hosts: [
					"grafana.6f.io",
				]
			}
			datasources: "datasources.yaml": {
				apiVersion: 1
				datasources: [{
					name:   "Loki"
					type:   "loki"
					access: "proxy"
					url:    "http://loki:3100"
				}, {
					name:   "Thanos"
					type:   "prometheus"
					access: "proxy"
					url:    "http://query-frontend.thanos.svc"
				}]
			}
			deploymentStrategy: type: "Recreate"
			persistence: {
				enabled: true
				size:    "1Gi"
			}
		}
	}
}
