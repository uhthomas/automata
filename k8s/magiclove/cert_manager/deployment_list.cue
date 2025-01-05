package cert_manager

import (
	"strings"

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

_#FeatureGates: {
	features: [...string]
	value: strings.Join([for feature in features {
		"\(feature)=true"
	}], ",")
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
				containers: [{
					name:  "cert-manager-cainjector"
					image: "quay.io/jetstack/cert-manager-cainjector:v\(#Version)"
					args: [
						"--v=2",
						"--leader-election-namespace=kube-system",
						{
							let featureGates = _#FeatureGates & {features: [
								"ServerSideApply",
							]}
							"--feature-gates=\(featureGates.value)"
						},
					]
					ports: [{
						name:          "http-metrics"
						containerPort: 9402
					}]
					env: [{
						name: "POD_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
					}
				}]
				nodeSelector: (v1.#LabelOSStable): v1.#Linux
				serviceAccountName: "cert-manager-cainjector"
				securityContext: {
					runAsNonRoot: true
					seccompProfile: type: "RuntimeDefault"
				}
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
		selector: matchLabels: {
			"app.kubernetes.io/name":      "cert-manager"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "controller"
		}
		template: {
			metadata: labels: {
				app:                           "cert-manager"
				"app.kubernetes.io/name":      "cert-manager"
				"app.kubernetes.io/instance":  "cert-manager"
				"app.kubernetes.io/component": "controller"
			}
			spec: {
				volumes: [{
					name: "config"
					configMap: name: #Name
				}]
				containers: [{
					name:  "cert-manager-controller"
					image: "quay.io/jetstack/cert-manager-controller:v\(#Version)"
					args: [
						"--v=2",
						"--cluster-resource-namespace=$(POD_NAMESPACE)",
						"--leader-election-namespace=kube-system",
						"--acme-http01-solver-image=quay.io/jetstack/cert-manager-acmesolver:v\(#Version)",
						"--max-concurrent-challenges=60",
						{
							let featureGates = _#FeatureGates & {features: [
								"AdditionalCertificateOutputFormats",
								"ExperimentalGatewayAPISupport",
								"ServerSideApply",
							]}
							"--feature-gates=\(featureGates.value)"
						},
						"--config=/var/cert-manager/config/config.yaml",
					]
					ports: [{
						name:          "http-metrics"
						containerPort: 9402
					}, {
						name:          "http-healthz"
						containerPort: 9403
					}]
					env: [{
						name: "POD_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}]
					volumeMounts: [{
						name:      "config"
						mountPath: "/var/cert-manager/config"
					}]
					// LivenessProbe settings are based on those used for the Kubernetes
					// controller-manager. See:
					// https://github.com/kubernetes/kubernetes/blob/806b30170c61a38fedd54cc9ede4cd6275a1ad3b/cmd/kubeadm/app/util/staticpod/utils.go#L241-L245
					livenessProbe: {
						httpGet: {
							port: "http-healthz"
							path: "/livez"
						}
						initialDelaySeconds: 10
						periodSeconds:       10
						timeoutSeconds:      15
						successThreshold:    1
						failureThreshold:    8
					}
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
					}
				}]
				nodeSelector: (v1.#LabelOSStable): v1.#Linux
				serviceAccountName: "cert-manager"
				securityContext: {
					runAsNonRoot: true
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
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
				containers: [{
					name:  "cert-manager-webhook"
					image: "quay.io/jetstack/cert-manager-webhook:v\(#Version)"
					args: [
						"--v=2",
						"--secure-port=10250",
						"--dynamic-serving-ca-secret-namespace=$(POD_NAMESPACE)",
						"--dynamic-serving-ca-secret-name=cert-manager-webhook-ca",
						"--dynamic-serving-dns-names=cert-manager-webhook",
						"--dynamic-serving-dns-names=cert-manager-webhook.$(POD_NAMESPACE)",
						"--dynamic-serving-dns-names=cert-manager-webhook.$(POD_NAMESPACE).svc",
						{
							let featureGates = _#FeatureGates & {features: [
								"AdditionalCertificateOutputFormats",
							]}
							"--feature-gates=\(featureGates.value)"
						},
					]
					ports: [{
						name:          "https"
						containerPort: 10250
					}, {
						name:          "healthcheck"
						containerPort: 6080
					}, {
						name:          "http-metrics"
						containerPort: 9402
					}]
					env: [{
						name: "POD_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}]
					livenessProbe: {
						httpGet: {
							port: "healthcheck"
							path: "/livez"
						}
						initialDelaySeconds: 60
						periodSeconds:       10
						timeoutSeconds:      1
						successThreshold:    1
						failureThreshold:    3
					}
					readinessProbe: {
						httpGet: {
							port: "healthcheck"
							path: "/healthz"
						}
						initialDelaySeconds: 5
						periodSeconds:       5
						timeoutSeconds:      1
						successThreshold:    1
						failureThreshold:    3
					}
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
					}
				}]
				nodeSelector: (v1.#LabelOSStable): v1.#Linux
				serviceAccountName: "cert-manager-webhook"
				securityContext: {
					runAsNonRoot: true
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
	}
}]
