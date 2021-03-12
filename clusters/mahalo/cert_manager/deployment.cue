package cert_manager

import appsv1 "k8s.io/api/apps/v1"

deployment: [...appsv1.#Deployment]

deployment: [{
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		name: "cert-manager-cainjector"
		labels: {
			app:                           "cainjector"
			"app.kubernetes.io/component": "cainjector"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "cainjector"
		}
	}
	spec: {
		replicas: 1
		selector: matchLabels: {
			"app.kubernetes.io/component": "cainjector"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "cainjector"
		}
		template: {
			metadata: labels: {
				app:                           "cainjector"
				"app.kubernetes.io/component": "cainjector"
				"app.kubernetes.io/instance":  "cert-manager"
				"app.kubernetes.io/name":      "cainjector"
			}
			spec: {
				containers: [{
					args: [
						"--v=2",
						"--leader-election-namespace=kube-system",
					]
					env: [{
						name: "POD_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}]
					image:           "quay.io/jetstack/cert-manager-cainjector:v1.2.0"
					imagePullPolicy: "IfNotPresent"
					name:            "cert-manager"
				}]
				serviceAccountName: "cert-manager-cainjector"
			}
		}
	}
}, {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/component": "controller"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
		}
		name: "cert-manager"
	}
	spec: {
		replicas: 1
		selector: matchLabels: {
			"app.kubernetes.io/component": "controller"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
		}
		template: {
			metadata: {
				annotations: {
					"prometheus.io/path":   "/metrics"
					"prometheus.io/port":   "9402"
					"prometheus.io/scrape": "true"
				}
				labels: {
					app:                           "cert-manager"
					"app.kubernetes.io/component": "controller"
					"app.kubernetes.io/instance":  "cert-manager"
					"app.kubernetes.io/name":      "cert-manager"
				}
			}
			spec: {
				containers: [{
					args: [
						"--v=2",
						"--cluster-resource-namespace=$(POD_NAMESPACE)",
						"--leader-election-namespace=kube-system",
					]
					env: [{
						name: "POD_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}]
					image:           "quay.io/jetstack/cert-manager-controller:v1.2.0"
					imagePullPolicy: "IfNotPresent"
					name:            "cert-manager"
					ports: [{
						containerPort: 9402
						protocol:      "TCP"
					}]
				}]
				serviceAccountName: "cert-manager"
			}
		}
	}
}, {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			app:                           "webhook"
			"app.kubernetes.io/component": "webhook"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "webhook"
		}
		name: "cert-manager-webhook"
	}
	spec: {
		replicas: 1
		selector: matchLabels: {
			"app.kubernetes.io/component": "webhook"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "webhook"
		}
		template: {
			metadata: labels: {
				app:                           "webhook"
				"app.kubernetes.io/component": "webhook"
				"app.kubernetes.io/instance":  "cert-manager"
				"app.kubernetes.io/name":      "webhook"
			}
			spec: {
				containers: [{
					args: [
						"--v=2",
						"--secure-port=10250",
						"--dynamic-serving-ca-secret-namespace=$(POD_NAMESPACE)",
						"--dynamic-serving-ca-secret-name=cert-manager-webhook-ca",
						"--dynamic-serving-dns-names=cert-manager-webhook,cert-manager-webhook.cert-manager,cert-manager-webhook.cert-manager.svc",
					]
					env: [{
						name: "POD_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}]
					image:           "quay.io/jetstack/cert-manager-webhook:v1.2.0"
					imagePullPolicy: "IfNotPresent"
					livenessProbe: {
						failureThreshold: 3
						httpGet: {

							path:   "/livez"
							port:   6080
							scheme: "HTTP"
						}
						initialDelaySeconds: 60
						periodSeconds:       10
						successThreshold:    1
						timeoutSeconds:      1
					}
					name: "cert-manager"
					ports: [{
						containerPort: 10250
						name:          "https"
					}]
					readinessProbe: {
						failureThreshold: 3
						httpGet: {

							path:   "/healthz"
							port:   6080
							scheme: "HTTP"
						}
						initialDelaySeconds: 5
						periodSeconds:       5
						successThreshold:    1
						timeoutSeconds:      1
					}
				}]
				serviceAccountName: "cert-manager-webhook"
			}
		}
	}
}]
