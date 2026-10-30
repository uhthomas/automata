package grafana

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
)

#DeploymentList: appsv1.#DeploymentList & {
	apiVersion: "apps/v1"
	kind:       "DeploymentList"
	items: [...{
		apiVersion: "apps/v1"
		kind:       "Deployment"
	}]
}

#DeploymentList: items: [{
	metadata: annotations: "reloader.stakater.com/auto": "true"
	spec: {
		progressDeadlineSeconds: 900
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				volumes: [{
					name: "data"
					persistentVolumeClaim: claimName: "data-\(#Name)-0"
				}, {
					name: "tmp"
					emptyDir: {}
				}]
				containers: [{
					name:  "grafana"
					image: "grafana/grafana:\(#Version)"
					ports: [{
						name:          "http"
						containerPort: 3000
					}]
					env: [{
						name:  "GF_LOG_MODE"
						value: "console"
					}, {
						name:  "GF_SERVER_ROOT_URL"
						value: "https://\(#Name)-magiclove.hipparcos.net"
					}, {
						name:  "GF_DATABASE_PATH"
						value: "/var/lib/grafana/database/grafana.db"
					}, {
						name:  "GF_GRAFANA_NET_URL"
						value: "https://grafana.net"
					}, {
						name:  "GF_PLUGINS_PREINSTALL_SYNC"
						value: "victoriametrics-logs-datasource@0.33.1,victoriametrics-metrics-datasource@0.26.1"
					}, {
						name: "GF_SECURITY_ADMIN_USER"
						valueFrom: secretKeyRef: {
							name: #Name
							key:  "username"
						}
					}, {
						name: "GF_SECURITY_ADMIN_PASSWORD"
						valueFrom: secretKeyRef: {
							name: #Name
							key:  "password"
						}
					}, {
						name:  "GF_AUTH_GENERIC_OAUTH_ENABLED"
						value: "true"
					}, {
						name:  "GF_AUTH_GENERIC_OAUTH_NAME"
						value: "Kanidm"
					}, {
						name: "GF_AUTH_GENERIC_OAUTH_CLIENT_ID"
						valueFrom: secretKeyRef: {
							name: "\(#Name)-kanidm-oauth2-credentials"
							key:  "CLIENT_ID"
						}
					}, {
						name: "GF_AUTH_GENERIC_OAUTH_CLIENT_SECRET"
						valueFrom: secretKeyRef: {
							name: "\(#Name)-kanidm-oauth2-credentials"
							key:  "CLIENT_SECRET"
						}
					}, {
						name:  "GF_AUTH_GENERIC_OAUTH_SCOPES"
						value: "openid email profile groups_spn"
					}, {
						name:  "GF_AUTH_GENERIC_OAUTH_AUTH_URL"
						value: "https://kanidm-magiclove.hipparcos.net/ui/oauth2"
					}, {
						name:  "GF_AUTH_GENERIC_OAUTH_TOKEN_URL"
						value: "https://kanidm-magiclove.hipparcos.net/oauth2/token"
					}, {
						name:  "GF_AUTH_GENERIC_OAUTH_API_URL"
						value: "https://kanidm-magiclove.hipparcos.net/oauth2/openid/\(#Name)/userinfo"
					}, {
						name:  "GF_AUTH_GENERIC_OAUTH_LOGIN_ATTRIBUTE_PATH"
						value: "preferred_username"
					}, {
						name:  "GF_AUTH_GENERIC_OAUTH_ROLE_ATTRIBUTE_PATH"
						value: "contains(groups[*], 'grafana-admins@kanidm-magiclove.hipparcos.net') && 'Admin' || 'Viewer'"
					}, {
						name:  "GF_AUTH_GENERIC_OAUTH_ALLOW_SIGN_UP"
						value: "true"
					}, {
						name:  "GF_AUTH_GENERIC_OAUTH_USE_PKCE"
						value: "true"
					}, {
						name:  "GF_AUTH_GENERIC_OAUTH_AUTO_LOGIN"
						value: "true"
					}, {
						name:  "GF_AUTH_DISABLE_LOGIN_FORM"
						value: "true"
					}]
					volumeMounts: [{
						name:      "data"
						mountPath: "/var/lib/grafana"
					}, {
						name:      "tmp"
						mountPath: "/tmp"
					}]

					let probe = {
						httpGet: {
							path: "/api/health"
							port: "http"
						}
					}

					startupProbe: probe & {
						failureThreshold: 60
						periodSeconds:    10
					}
					livenessProbe: probe
					readinessProbe: probe & {
						initialDelaySeconds: 30
						failureThreshold:    5
					}

					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				securityContext: {
					runAsUser:           1000
					runAsGroup:          3000
					runAsNonRoot:        true
					fsGroup:             2000
					fsGroupChangePolicy: v1.#FSGroupChangeOnRootMismatch
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
		strategy: type: appsv1.#RecreateDeploymentStrategyType
	}
}]
