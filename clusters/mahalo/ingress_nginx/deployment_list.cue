package ingress_nginx

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
	metadata: {
		name: "ingress-nginx-controller"
		labels: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/version":   "0.44.0"
			"app.kubernetes.io/component": "controller"
		}
	}
	spec: {
		selector: matchLabels: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/component": "controller"
		}
		revisionHistoryLimit: 10
		minReadySeconds:      0
		template: {
			metadata: {
				annotations: {
					"prometheus.io/path":   "/metrics"
					"prometheus.io/port":   "10254"
					"prometheus.io/scheme": "http"
					"prometheus.io/scrape": "true"
				}
				labels: {
					"app.kubernetes.io/name":      "ingress-nginx"
					"app.kubernetes.io/instance":  "ingress-nginx"
					"app.kubernetes.io/component": "controller"
				}
			}
			spec: {
				dnsPolicy: v1.#DNSClusterFirst
				containers: [{
					name:            "controller"
					image:           "k8s.gcr.io/ingress-nginx/controller:v0.44.0@sha256:3dd0fac48073beaca2d67a78c746c7593f9c575168a17139a9955a82c63c4b9a"
					imagePullPolicy: v1.#PullIfNotPresent
					lifecycle: preStop: exec: command: [
						"/wait-shutdown",
					]
					args: [
						"/nginx-ingress-controller",
						"--publish-service=$(POD_NAMESPACE)/ingress-nginx-controller",
						"--election-id=ingress-controller-leader",
						"--ingress-class=nginx",
						"--configmap=$(POD_NAMESPACE)/ingress-nginx-controller",
						"--validating-webhook=:8443",
						"--validating-webhook-certificate=/usr/local/certificates/cert",
						"--validating-webhook-key=/usr/local/certificates/key",
					]
					securityContext: {
						capabilities: {
							drop: [
								"ALL",
							]
							add: [
								"NET_BIND_SERVICE",
							]
						}
						runAsUser:                101
						allowPrivilegeEscalation: true
					}
					env: [{
						name: "POD_NAME"
						valueFrom: fieldRef: fieldPath: "metadata.name"
					}, {
						name: "POD_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}, {
						name:  "LD_PRELOAD"
						value: "/usr/local/lib/libmimalloc.so"
					}]
					livenessProbe: {
						httpGet: {
							path:   "/healthz"
							port:   10254
							scheme: "HTTP"
						}
						initialDelaySeconds: 10
						periodSeconds:       10
						timeoutSeconds:      1
						successThreshold:    1
						failureThreshold:    5
					}
					readinessProbe: {
						httpGet: {
							path:   "/healthz"
							port:   10254
							scheme: "HTTP"
						}
						initialDelaySeconds: 10
						periodSeconds:       10
						timeoutSeconds:      1
						successThreshold:    1
						failureThreshold:    3
					}
					ports: [{
						name:          "http"
						containerPort: 80
						protocol:      "TCP"
					}, {
						name:          "https"
						containerPort: 443
						protocol:      "TCP"
					}, {
						name:          "webhook"
						containerPort: 8443
						protocol:      "TCP"
					}]
					volumeMounts: [{
						name:      "webhook-cert"
						mountPath: "/usr/local/certificates/"
						readOnly:  true
					}]
					resources: {
						requests: {
							cpu:    "100m"
							memory: "128Mi"
						}
						limits: {
							cpu:    "200m"
							memory: "256Mi"
						}
					}
				}]
				nodeSelector: "kubernetes.io/os": "linux"
				serviceAccountName:            "ingress-nginx"
				terminationGracePeriodSeconds: 300
				volumes: [{
					name: "webhook-cert"
					secret: secretName: "ingress-nginx-admission"
				}]
			}
		}
	}
}]
