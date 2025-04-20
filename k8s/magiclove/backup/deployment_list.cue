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
		// replicas: 0
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
					name: "data-immich-unwind"
					persistentVolumeClaim: {
						claimName: "immich-unwind"
						readOnly:  true
					}
				}, {
					name: "data-legacy"
					persistentVolumeClaim: {
						claimName: "legacy"
						readOnly:  true
					}
				}, {
					name: "data-lola"
					persistentVolumeClaim: {
						claimName: "lola"
						readOnly:  false
					}
				}, {
					name: "data-melonade"
					persistentVolumeClaim: {
						claimName: "melonade"
						readOnly:  false
					}
				}, {
					name: "data-sana"
					persistentVolumeClaim: {
						claimName: "sana"
						readOnly:  true
					}
				}, {
					name: "data-synology"
					persistentVolumeClaim: {
						claimName: "synology"
						readOnly:  true
					}
				}]
				containers: [{
					name:  "samba"
					image: "ghcr.io/uhthomas/uhthomas/samba:37219169ba8a7248017fecf8fe191933b47d2672"
					ports: [{
						name:          "smb"
						containerPort: 445
					}]
					// resources: limits: {
					// 	(v1.#ResourceCPU):    "1"
					// 	(v1.#ResourceMemory): "1Gi"
					// }
					volumeMounts: [{
						name:      "var-log"
						mountPath: "/var/log/samba"
					}, {
						name:      "data-breakfast"
						mountPath: "/data/breakfast"
					}, {
						name:      "data-immich-unwind"
						mountPath: "/data/immich-unwind"
					}, {
						name:      "data-legacy"
						mountPath: "/data/legacy"
					}, {
						name:      "data-lola"
						mountPath: "/data/lola"
					}, {
						name:      "data-melonade"
						mountPath: "/data/melonade"
					}, {
						name:      "data-sana"
						mountPath: "/data/sana"
					}, {
						name:      "data-synology"
						mountPath: "/data/synology"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					_securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}, {
					name:  "debug"
					image: "archlinux"
					args: ["tail", "-f", "/dev/null"]
					volumeMounts: [{
						name:      "data-breakfast"
						mountPath: "/data/breakfast"
					}, {
						name:      "data-immich-unwind"
						mountPath: "/data/immich-unwind"
					}, {
						name:      "data-legacy"
						mountPath: "/data/legacy"
					}, {
						name:      "data-lola"
						mountPath: "/data/lola"
					}, {
						name:      "data-melonade"
						mountPath: "/data/melonade"
					}, {
						name:      "data-sana"
						mountPath: "/data/sana"
					}, {
						name:      "data-synology"
						mountPath: "/data/synology"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
				}]
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
		strategy: type: appsv1.#RecreateDeploymentStrategyType
	}
}]
