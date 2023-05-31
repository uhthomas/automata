package vault_config_operator

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
	spec: {
		selector: matchLabels: {
			"app.kubernetes.io/name": #Name
			"control-plane":          #Name
		}
		replicas: 1
		template: {
			metadata: labels: {
				"app.kubernetes.io/name": #Name
				"control-plane":          #Name
			}
			spec: {
				serviceAccountName: "controller-manager"
				containers: [{
					name:            "kube-rbac-proxy"
					image:           "quay.io/redhat-cop/kube-rbac-proxy:v0.11.0"
					imagePullPolicy: v1.#PullIfNotPresent
					args: [
						"--secure-listen-address=0.0.0.0:8443",
						"--upstream=http://127.0.0.1:8080/",
						"--logtostderr=true",
						"--tls-cert-file=/etc/certs/tls/tls.crt",
						"--tls-private-key-file=/etc/certs/tls/tls.key",
						"--v=0",
					]
					ports: [{
						name:          "https"
						containerPort: 8443
					}]
					volumeMounts: [{
						mountPath: "/etc/certs/tls"
						name:      "vault-config-operator-certs"
					}]
					resources: {
						limits: {
							cpu:    "500m"
							memory: "128Mi"
						}
						requests: {
							cpu:    "5m"
							memory: "64Mi"
						}
					}
				}, {
					name:            "vault-config-operator"
					image:           "quay.io/redhat-cop/vault-config-operator:v0.8.15"
					imagePullPolicy: v1.#PullIfNotPresent
					command: ["/manager"]
					args: ["--leader-elect"]
					volumeMounts: [{
						name:      "webhook-server-cert"
						readOnly:  true
						mountPath: "/tmp/k8s-webhook-server/serving-certs"
					}]
					resources: requests: {
						cpu:    "100m"
						memory: "250Mi"
					}
					livenessProbe: {
						httpGet: {
							path: "/healthz"
							port: 8081
						}
						initialDelaySeconds: 15
						periodSeconds:       20
					}
					readinessProbe: {
						httpGet: {
							path: "/readyz"
							port: 8081
						}
						initialDelaySeconds: 5
						periodSeconds:       10
					}
				}]
				volumes: [{
					name: "vault-config-operator-certs"
					secret: {
						secretName:  "vault-config-operator-certs"
						defaultMode: 0o644
					}
				}, {
					name: "webhook-server-cert"
					secret: {
						secretName:  "webhook-server-cert"
						defaultMode: 0o644
					}
				}]
			}
		}
	}
}]
