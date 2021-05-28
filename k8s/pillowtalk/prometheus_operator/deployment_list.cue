package prometheus_operator

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
		replicas: 1
		selector: matchLabels: {
			"app.kubernetes.io/component": "controller"
			"app.kubernetes.io/name":      "prometheus-operator"
		}
		template: {
			metadata: {
				annotations: "kubectl.kubernetes.io/default-container": "prometheus-operator"
				labels: {
					"app.kubernetes.io/component": "controller"
					"app.kubernetes.io/name":      "prometheus-operator"
					"app.kubernetes.io/version":   "0.48.0"
				}
			}
			spec: {
				containers: [{
					args: [
						"--kubelet-service=kube-system/kubelet",
						"--prometheus-config-reloader=quay.io/prometheus-operator/prometheus-config-reloader:v0.48.0@sha256:67b34221e382b9527100fb7078742075c2cda1b87eead2e70517142a8f00059b",
					]
					image: "quay.io/prometheus-operator/prometheus-operator:v0.48.0@sha256:ff7ba77bf8bd367e71f5e5f63a9de1de83c9af42fe9e7fc968f9d294871f6942"
					name:  "prometheus-operator"
					ports: [{
						containerPort: 8080
						name:          "http"
					}]
					resources: {
						limits: {
							cpu:    "200m"
							memory: "200Mi"
						}
						requests: {
							cpu:    "100m"
							memory: "100Mi"
						}
					}
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: allowPrivilegeEscalation: false
				}]
				nodeSelector: "kubernetes.io/os": "linux"
				securityContext: {
					runAsNonRoot: true
					runAsUser:    65534
				}
				serviceAccountName: "prometheus-operator"
			}
		}
	}
}]
