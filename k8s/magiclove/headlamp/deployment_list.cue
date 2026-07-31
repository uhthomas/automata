package headlamp

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
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				volumes: [{
					name: "tmp"
					emptyDir: {}
				}]
				containers: [{
					name:  "headlamp"
					image: _image.reference
					args: [
						"-in-cluster",
						"-in-cluster-context-name=magiclove",
						"-oidc-client-id=$(OIDC_CLIENT_ID)",
						"-oidc-client-secret=$(OIDC_CLIENT_SECRET)",
						"-oidc-idp-issuer-url=https://kanidm-magiclove.hipparcos.net/oauth2/openid/headlamp",
						"-oidc-scopes=profile,email,groups_name",
						"-oidc-callback-url=https://headlamp-magiclove.hipparcos.net/oidc-callback",
						"-oidc-use-pkce",
					]
					ports: [{
						name:          "http"
						containerPort: 4466
					}]
					env: [{name: "HOME", value: "/tmp"}, {
						name: "OIDC_CLIENT_ID"
						valueFrom: secretKeyRef: {
							name: "headlamp-kanidm-oauth2-credentials"
							key:  "CLIENT_ID"
						}
					}, {
						name: "OIDC_CLIENT_SECRET"
						valueFrom: secretKeyRef: {
							name: "headlamp-kanidm-oauth2-credentials"
							key:  "CLIENT_SECRET"
						}
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "100m"
						(v1.#ResourceMemory): "256Mi"
					}
					volumeMounts: [{
						name:      "tmp"
						mountPath: "/tmp"
					}]

					let probe = {
						httpGet: {
							path: "/"
							port: "http"
						}
						initialDelaySeconds: 5
					}

					livenessProbe:  probe
					readinessProbe: probe

					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				serviceAccountName: #Name
				securityContext: {
					runAsUser:           100
					runAsGroup:          101
					runAsNonRoot:        true
					fsGroup:             101
					fsGroupChangePolicy: v1.#FSGroupChangeOnRootMismatch
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
	}
}]
