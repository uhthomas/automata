package oauth2_proxy

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
)

deployment: [...appsv1.#Deployment]

deployment: [{
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: "oauth2-proxy"
	spec: {
		revisionHistoryLimit:    5
		progressDeadlineSeconds: 120
		strategy: rollingUpdate: maxUnavailable: 1
		minReadySeconds: 1
		selector: matchLabels: app: "oauth2-proxy"
		template: {
			metadata: labels: app: "oauth2-proxy"
			spec: containers: [{
				name:            "oauth2-proxy"
				image:           "quay.io/oauth2-proxy/oauth2-proxy:v6.1.1@sha256:791aef35b8d1d2a325028b188d5a650605d69985a0dab1233c06079e7321eee0"
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
					"--client-id=$(CLIENT_ID)",
					"--client-secret=$(CLIENT_SECRET)",
					"--cookie-secret=$(COOKIE_SECRET)",
					"--skip-provider-button=true",
					"--whitelist-domain=.6f.io",
					"--cookie-domain=.6f.io",
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
