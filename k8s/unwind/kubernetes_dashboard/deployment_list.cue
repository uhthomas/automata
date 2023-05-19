package kubernetes_dashboard

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
		selector: matchLabels: "app.kubernetes.io/name": "kubernetes-dashboard"
		template: {
			metadata: labels: "app.kubernetes.io/name": "kubernetes-dashboard"
			spec: {
				volumes: [{
					name: "kubernetes-dashboard-certs"
					secret: secretName: "kubernetes-dashboard-certs"
				}, {
					name: "tmp-volume"
					emptyDir: {}
				}]
				containers: [{
					name:  "kubernetes-dashboard"
					image: "kubernetesui/dashboard:v\(#Version)@sha256:ca93706ef4e400542202d620b8094a7e4e568ca9b1869c71b053cdf8b5dc3029"
					args: [
						"--auto-generate-certificates",
						"--namespace=kubernetes-dashboard",
					]
					ports: [{
						name:          "https"
						containerPort: 8443
					}]
					volumeMounts: [{
						name:      "kubernetes-dashboard-certs"
						mountPath: "/certs"
					}, {
						mountPath: "/tmp"
						name:      "tmp-volume"
					}]
					livenessProbe: {
						httpGet: {
							path:   "/"
							port:   "https"
							scheme: v1.#URISchemeHTTPS
						}
						initialDelaySeconds: 30
						timeoutSeconds:      30
					}
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				nodeSelector: "kubernetes.io/os": "linux"
				serviceAccountName: #Name
				securityContext: {
					runAsUser:    1000
					runAsGroup:   3000
					runAsNonRoot: true
					fsGroup:      2000
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
	}
}, {
	metadata: name: "dashboard-metrics-scraper"
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": "dashboard-metrics-scraper"
		template: {
			metadata: labels: "app.kubernetes.io/name": "dashboard-metrics-scraper"
			spec: {
				volumes: [{
					name: "tmp-volume"
					emptyDir: {}
				}]
				containers: [{
					name:  "dashboard-metrics-scraper"
					image: "kubernetesui/metrics-scraper:v1.0.9@sha256:9b599f50dc7bfdfe71f021a4859fe19f74baf2135a8538ba1c1013832b7a66b4"
					ports: [{
						name:          "http"
						containerPort: 8000
					}]
					livenessProbe: {
						httpGet: {
							path: "/"
							port: "http"
						}
						initialDelaySeconds: 30
						timeoutSeconds:      30
					}
					volumeMounts: [{
						mountPath: "/tmp"
						name:      "tmp-volume"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				nodeSelector: "kubernetes.io/os": "linux"
				serviceAccountName: #Name
				securityContext: {
					runAsUser:    1000
					runAsGroup:   3000
					runAsNonRoot: true
					fsGroup:      2000
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
	}
}]
