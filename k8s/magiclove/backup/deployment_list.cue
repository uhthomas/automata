package backup

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
	metadata: name: "smb"
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": "smb"
		template: {
			metadata: labels: "app.kubernetes.io/name": "smb"
			spec: {
				volumes: [{
					name: "var-log"
					emptyDir: {}
				}, {
					name: "data-breakfast"
					persistentVolumeClaim: {
						claimName: "breakfast"
						readOnly:  true
					}
				}, {
					name: "data-legacy"
					persistentVolumeClaim: {
						claimName: "legacy"
						readOnly:  true
					}
				}, {
					name: "data-sana"
					persistentVolumeClaim: {
						claimName: "sana"
						readOnly:  false
					}
				}]
				containers: [{
					name:  "samba"
					image: "ghcr.io/uhthomas/automata/samba:latest"
					ports: [{
						name:          "smb"
						containerPort: 445
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "1"
						(v1.#ResourceMemory): "1Gi"
					}
					volumeMounts: [{
						name:      "var-log"
						mountPath: "/var/log/samba"
					}, {
						name:      "data-breakfast"
						mountPath: "/data/breakfast"
					}, {
						name:      "data-legacy"
						mountPath: "/data/legacy"
					}, {
						name:      "data-sana"
						mountPath: "/data/sana"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
				},
					// securityContext: {
					// 	capabilities: drop: ["ALL"]
					// 	readOnlyRootFilesystem:   true
					// 	allowPrivilegeEscalation: false
					// }
				]
				securityContext: {
					// runAsUser:  1000
					// runAsGroup: 3000
					// runAsNonRoot:        true
					// fsGroup:             2000
					fsGroupChangePolicy: v1.#FSGroupChangeOnRootMismatch
					// 	seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
	}
}]
