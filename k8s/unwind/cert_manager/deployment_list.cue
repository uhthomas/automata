package cert_manager

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
	metadata: {
		name: "cert-manager-cainjector"
		labels: {
			app:                           "cainjector"
			"app.kubernetes.io/name":      "cainjector"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "cainjector"
		}
	}
	spec: {
		replicas: 1
		selector: matchLabels: {
			"app.kubernetes.io/name":      "cainjector"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "cainjector"
		}
		template: {
			metadata: labels: {
				app:                           "cainjector"
				"app.kubernetes.io/name":      "cainjector"
				"app.kubernetes.io/instance":  "cert-manager"
				"app.kubernetes.io/component": "cainjector"
			}
			spec: {
				serviceAccountName: "cert-manager-cainjector"
				securityContext: {
					runAsNonRoot: true
					seccompProfile: type: "RuntimeDefault"
				}
				containers: [{
					name:            "cert-manager-cainjector"
					image:           "quay.io/jetstack/cert-manager-cainjector:v\(#Version)"
					imagePullPolicy: v1.#PullIfNotPresent
					args: [
						"--v=2",
						"--leader-election-namespace=kube-system",
					]
					env: [{
						name: "POD_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}]
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
					}
				}]
				nodeSelector: (v1.#LabelOSStable): v1.#Linux
			}
		}
	}
}, {
	metadata: labels: {
		app:                           "cert-manager"
		"app.kubernetes.io/name":      "cert-manager"
		"app.kubernetes.io/instance":  "cert-manager"
		"app.kubernetes.io/component": "controller"
	}
	spec: {
		replicas: 1
		selector: matchLabels: {
			"app.kubernetes.io/name":      "cert-manager"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "controller"
		}
		template: {
			metadata: {
				labels: {
					app:                           "cert-manager"
					"app.kubernetes.io/name":      "cert-manager"
					"app.kubernetes.io/instance":  "cert-manager"
					"app.kubernetes.io/component": "controller"
				}
				annotations: {
					"prometheus.io/path":   "/metrics"
					"prometheus.io/scrape": "true"
					"prometheus.io/port":   "9402"
				}
			}
			spec: {
				serviceAccountName: "cert-manager"
				securityContext: {
					runAsNonRoot: true
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
				containers: [{
					name:            "cert-manager-controller"
					image:           "quay.io/jetstack/cert-manager-controller:v\(#Version)"
					imagePullPolicy: v1.#PullIfNotPresent
					args: [
						"--v=2",
						"--cluster-resource-namespace=$(POD_NAMESPACE)",
						"--leader-election-namespace=kube-system",
						"--acme-http01-solver-image=quay.io/jetstack/cert-manager-acmesolver:v\(#Version)",
						"--max-concurrent-challenges=60",
						"--feature-gates=AdditionalCertificateOutputFormats=true",
					]
					ports: [{
						containerPort: 9402
						name:          "http-metrics"
						protocol:      "TCP"
					}]
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
					}
					env: [{
						name: "POD_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}]
				}]
				nodeSelector: (v1.#LabelOSStable): v1.#Linux
			}
		}
	}
}, {
	metadata: {
		name: "cert-manager-webhook"
		labels: {
			app:                           "webhook"
			"app.kubernetes.io/name":      "webhook"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "webhook"
		}
	}
	spec: {
		replicas: 1
		selector: matchLabels: {
			"app.kubernetes.io/name":      "webhook"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "webhook"
		}
		template: {
			metadata: labels: {
				app:                           "webhook"
				"app.kubernetes.io/name":      "webhook"
				"app.kubernetes.io/instance":  "cert-manager"
				"app.kubernetes.io/component": "webhook"
			}
			spec: {
				serviceAccountName: "cert-manager-webhook"
				securityContext: {
					runAsNonRoot: true
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
				containers: [{
					name:            "cert-manager-webhook"
					image:           "quay.io/jetstack/cert-manager-webhook:v\(#Version)"
					imagePullPolicy: v1.#PullIfNotPresent
					args: [
						"--v=2",
						"--secure-port=10250",
						"--dynamic-serving-ca-secret-namespace=$(POD_NAMESPACE)",
						"--dynamic-serving-ca-secret-name=cert-manager-webhook-ca",
						"--dynamic-serving-dns-names=cert-manager-webhook",
						"--dynamic-serving-dns-names=cert-manager-webhook.$(POD_NAMESPACE)",
						"--dynamic-serving-dns-names=cert-manager-webhook.$(POD_NAMESPACE).svc",
						"--feature-gates=AdditionalCertificateOutputFormats=true",
					]

					ports: [{
						name:          "https"
						containerPort: 10250
					}, {
						name:          "healthcheck"
						containerPort: 6080
					}]
					livenessProbe: {
						httpGet: {
							path:   "/livez"
							port:   6080
							scheme: "HTTP"
						}
						initialDelaySeconds: 60
						periodSeconds:       10
						timeoutSeconds:      1
						successThreshold:    1
						failureThreshold:    3
					}
					readinessProbe: {
						httpGet: {
							path:   "/healthz"
							port:   6080
							scheme: "HTTP"
						}
						initialDelaySeconds: 5
						periodSeconds:       5
						timeoutSeconds:      1
						successThreshold:    1
						failureThreshold:    3
					}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
					}
					env: [{
						name: "POD_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}]
				}]
				nodeSelector: (v1.#LabelOSStable): v1.#Linux
			}
		}
	}
}]
