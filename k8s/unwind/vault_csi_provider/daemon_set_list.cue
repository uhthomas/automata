package vault_csi_provider

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
)

#DaemonSetList: appsv1.#DaemonSetList & {
	apiVersion: "apps/v1"
	kind:       "DaemonSetList"
	items: [...{
		apiVersion: "apps/v1"
		kind:       "DaemonSet"
	}]
}

#DaemonSetList: items: [{
	spec: {
		updateStrategy: type: appsv1.#RollingUpdateStatefulSetStrategyType
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: #Labels
			spec: {
				serviceAccountName: #Name
				containers: [{
					name:            "vault-csi-provider"
					image:           "hashicorp/vault-csi-provider:\(#Version)"
					imagePullPolicy: v1.#PullIfNotPresent
					args: [
						"--endpoint=/provider/vault.sock",
						"--debug=false",
					]
					env: [{
						name:  "VAULT_ADDR"
						value: "http://vault.vault.svc:8200"
					}]
					volumeMounts: [{
						name:      "providervol"
						mountPath: "/provider"
					}, {
						name:             "mountpoint-dir"
						mountPath:        "/var/lib/kubelet/pods"
						mountPropagation: v1.#MountPropagationHostToContainer
					}]
					livenessProbe: {
						httpGet: {
							path: "/health/ready"
							port: 8080
						}
						failureThreshold:    2
						initialDelaySeconds: 5
						periodSeconds:       5
						successThreshold:    1
						timeoutSeconds:      3
					}
					readinessProbe: {
						httpGet: {
							path: "/health/ready"
							port: 8080
						}
						failureThreshold:    2
						initialDelaySeconds: 5
						periodSeconds:       5
						successThreshold:    1
						timeoutSeconds:      3
					}
				}]
				volumes: [{
					name: "providervol"
					hostPath: path: "/etc/kubernetes/secrets-store-csi-providers"
				}, {
					name: "mountpoint-dir"
					hostPath: path: "/var/lib/kubelet/pods"
				}]
			}
		}
	}
}]
