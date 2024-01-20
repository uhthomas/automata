package collector

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
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				volumes: [{
					name: "udev"
					hostPath: path: "/run/udev"
				}]
				containers: [{
					name:  "collector"
					image: "ghcr.io/analogj/scrutiny:v\(#Version)-collector"
					env: [{
						name:  "COLLECTOR_API_ENDPOINT"
						value: "http://scrutiny-web"
					}, {
						name: "COLLECTOR_HOST_ID"
						valueFrom: fieldRef: fieldPath: "spec.nodeName"
					}, {
						name:  "COLLECTOR_RUN_STARTUP"
						value: "true"
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "100m"
						(v1.#ResourceMemory): "32Mi"
					}
					volumeMounts: [{
						name:      "udev"
						mountPath: "/run/udev"
						readOnly:  true
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: {
							add: ["SYS_ADMIN", "SYS_RAWIO"]
							drop: ["ALL"]
						}
						privileged: true
						// readOnlyRootFilesystem:   true
						// allowPrivilegeEscalation: false
					}

				}]
				serviceAccountName: #Name
				// securityContext: {
				// 	runAsUser:    1000
				// 	runAsGroup:   3000
				// 	runAsNonRoot: true
				// 	fsGroup:      2000
				// 	seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				// }
			}
		}
	}
}]
