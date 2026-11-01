package server

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
	metadata: annotations: "reloader.stakater.com/auto": "true"
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				volumes: [{
					name: "library"
					persistentVolumeClaim: claimName: "\(#Name)-library"
				}, {
					name: "external-library"
					persistentVolumeClaim: claimName: "\(#Name)-external-library"
				}, {
					name: "smb-config"
					configMap: name: "\(#Name)-smb"
				}, {
					name: "smb-credentials"
					secret: {
						secretName:  "\(#Name)-smb"
						defaultMode: 0o440
					}
				}, {
					name: "smb-state"
					emptyDir: {}
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
					name: "server"
					// image: "ghcr.io/immich-app/immich-server:v\(#Version)"
					image: "ghcr.io/immich-app/immich-server:main@sha256:3ed2831bd7f5bb78fa82541985ddedcbe2cffdfc3a58e340fe735c7e370f242d"
					ports: [{
						name:          "http"
						containerPort: 2283
					}, {
						name:          "http-metrics"
						containerPort: 8081
					}]
					env: [{
						name:  "DB_HOSTNAME"
						value: "immich-pg-db-rw"
					}, {
						name:  "DB_DATABASE_NAME"
						value: "app"
					}, {
						name: "DB_USERNAME"
						valueFrom: secretKeyRef: {
							name: "immich-pg-db-credentials"
							key:  "username"
						}
					}, {
						name: "DB_PASSWORD"
						valueFrom: secretKeyRef: {
							name: "immich-pg-db-credentials"
							key:  "password"
						}
					}, {
						name:  "REDIS_HOSTNAME"
						value: "valkey"
					}, {
						name:  "IMMICH_MACHINE_LEARNING_URL"
						value: "http://immich-machine-learning"
					}, {
						name:  "IMMICH_TELEMETRY_INCLUDE"
						value: "all"
					}]
					resources: {
						requests: (v1.#ResourceCPU):  "2"
						limits: (v1.#ResourceMemory): "8Gi"
					}
					volumeMounts: [{
						name:      "library"
						mountPath: "/usr/src/app/upload"
					}, {
						name:      "external-library"
						readOnly:  true
						mountPath: "/external-library"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}, {
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
						name:      "external-library"
						mountPath: "/data"
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
