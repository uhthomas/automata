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
	metadata: {
		name: "smb"
		annotations: "reloader.stakater.com/auto": "true"
	}
	spec: {
		// replicas: 0
		selector: matchLabels: "app.kubernetes.io/name": "smb"
		template: {
			metadata: labels: "app.kubernetes.io/name": "smb"
			spec: {
				volumes: [{
					name: "smb-config"
					configMap: name: "smb"
				}, {
					name: "smb-credentials"
					secret: {
						secretName:  "smb"
						defaultMode: 0o440
					}
				}, {
					name: "smb-state"
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
						readOnly:  true
					}
				}, {
					name: "data-melonade"
					persistentVolumeClaim: {
						claimName: "melonade"
						readOnly:  true
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
				initContainers: [{
					name:  "smb-credentials"
					image: #SambaImage
					command: ["/bin/sh", "-ec"]
					args: ["""
						umask 077
						mkdir -p /var/lib/samba/private
						mkdir -p -m 0755 /var/lib/samba/cache
						password="$(cat /etc/samba/credentials/password)"
						printf '%s\\n%s\\n' "$password" "$password" | pdbedit \\
						    --configfile=/etc/samba/smb.conf \\
						    --create --user=smbuser --password-from-stdin >/dev/null
						"""]
					volumeMounts: [{
						name:      "smb-config"
						readOnly:  true
						mountPath: "/etc/samba/smb.conf"
						subPath:   "smb.conf"
					}, {
						name:      "smb-state"
						mountPath: "/var/lib/samba"
					}, {
						name:      "smb-credentials"
						readOnly:  true
						mountPath: "/etc/samba/credentials"
					}]
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				containers: [{
					name:  "samba"
					image: #SambaImage
					command: ["smbd"]
					args: [
						"--foreground",
						"--no-process-group",
						"--debug-stdout",
						"--log-basename=/var/lib/samba",
						"--configfile=/etc/samba/smb.conf",
					]
					ports: [{
						name:          "smb"
						containerPort: 445
					}]
					resources: {
						limits: (v1.#ResourceMemory): "1Gi"
						requests: (v1.#ResourceCPU):  "100m"
					}
					volumeMounts: [{
						name:      "smb-config"
						readOnly:  true
						mountPath: "/etc/samba/smb.conf"
						subPath:   "smb.conf"
					}, {
						name:      "smb-state"
						mountPath: "/var/lib/samba"
					}, {
						name:      "data-breakfast"
						readOnly:  true
						mountPath: "/data/breakfast"
					}, {
						name:      "data-immich-unwind"
						readOnly:  true
						mountPath: "/data/immich-unwind"
					}, {
						name:      "data-legacy"
						readOnly:  true
						mountPath: "/data/legacy"
					}, {
						name:      "data-lola"
						readOnly:  true
						mountPath: "/data/lola"
					}, {
						name:      "data-melonade"
						readOnly:  true
						mountPath: "/data/melonade"
					}, {
						name:      "data-sana"
						readOnly:  true
						mountPath: "/data/sana"
					}, {
						name:      "data-synology"
						readOnly:  true
						mountPath: "/data/synology"
					}]
					readinessProbe: tcpSocket: port: "smb"
					startupProbe: {
						tcpSocket: port: "smb"
						periodSeconds:    2
						failureThreshold: 30
					}
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
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
						readOnly:  true
						mountPath: "/data/breakfast"
					}, {
						name:      "data-immich-unwind"
						readOnly:  true
						mountPath: "/data/immich-unwind"
					}, {
						name:      "data-legacy"
						readOnly:  true
						mountPath: "/data/legacy"
					}, {
						name:      "data-lola"
						readOnly:  true
						mountPath: "/data/lola"
					}, {
						name:      "data-melonade"
						readOnly:  true
						mountPath: "/data/melonade"
					}, {
						name:      "data-sana"
						readOnly:  true
						mountPath: "/data/sana"
					}, {
						name:      "data-synology"
						readOnly:  true
						mountPath: "/data/synology"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
				}]
				automountServiceAccountToken: false
				securityContext: {
					runAsUser:           1000
					runAsGroup:          3000
					runAsNonRoot:        true
					fsGroup:             2000
					fsGroupChangePolicy: v1.#FSGroupChangeOnRootMismatch
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
		strategy: type: appsv1.#RecreateDeploymentStrategyType
	}
}]
