package oauth2_proxy

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
)

deploymentList: appsv1.#DeploymentList & {
	apiVersion: "apps/v1"
	kind:       "DeploymentList"
	items: [...{
		apiVersion: "apps/v1"
		kind:       "Deployment"
	}]
}

deploymentList: items: [{
	spec: {
		revisionHistoryLimit:    5
		progressDeadlineSeconds: 120
		strategy: rollingUpdate: maxUnavailable: 1
		minReadySeconds: 1
		selector: matchLabels: {
			"app.kubernetes.io/name":      "oauth2-proxy"
			"app.kubernetes.io/instance":  "oauth2-proxy"
			"app.kubernetes.io/component": "oauth2-proxy"
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      "oauth2-proxy"
				"app.kubernetes.io/instance":  "oauth2-proxy"
				"app.kubernetes.io/component": "oauth2-proxy"
			}
			spec: containers: [{
				name:            "oauth2-proxy"
				image:           "quay.io/oauth2-proxy/oauth2-proxy:v7.0.1@sha256:15eaf47e0ca8b15d668f5cb5da67f028abe251a2855a6b1c9344080c5735b59a"
				imagePullPolicy: v1.#PullIfNotPresent
				ports: [{
					name:          "http"
					containerPort: 4180
				}]
				env: [{
					name: "CLIENT_ID"
					valueFrom: secretKeyRef: {
						name: "oauth2-proxy"
						key:  "client-id"
					}
				}, {
					name: "CLIENT_SECRET"
					valueFrom: secretKeyRef: {
						name: "oauth2-proxy"
						key:  "client-secret"
					}
				}, {
					name: "COOKIE_SECRET"
					valueFrom: secretKeyRef: {
						name: "oauth2-proxy"
						key:  "cookie-secret"
					}
				}]
				args: [
					"--http-address=:4180",
					"--provider=google",
					"--email-domain=6f.io",
					"--email-domain=starjunk.net",
					"--client-id=$(CLIENT_ID)",
					"--client-secret=$(CLIENT_SECRET)",
					"--cookie-secret=$(COOKIE_SECRET)",
					"--skip-provider-button=true",
					"--whitelist-domain=.6f.io",
					"--whitelist-domain=.starjunk.net",
					"--cookie-domain=.6f.io",
					"--cookie-domain=.starjunk.net",
					"--set-authorization-header=true",
					"--set-xauthrequest=true",
					"--reverse-proxy=true",
					"--pass-user-headers=true",
					"--cookie-samesite=none",
				]
				resources: {
					requests: {
						memory: "16Mi"
						cpu:    "50m"
					}
					limits: {
						memory: "32Mi"
						cpu:    "200m"
					}
				}
			}]
		}
	}
}]
