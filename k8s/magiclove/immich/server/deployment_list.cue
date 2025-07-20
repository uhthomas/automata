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
					name: "smb-var-cache"
					emptyDir: {}
				}, {
					name: "smb-var-lib"
					emptyDir: {}
				}, {
					name: "smb-var-lib-private"
					emptyDir: {}
				}, {
					name: "smb-var-log"
					emptyDir: {}
				}, {
					name: "smb-var-run"
					emptyDir: {}
				}]
				containers: [{
					name:  "server"
					image: "ghcr.io/immich-app/immich-server:v\(#Version)"
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
					resources: limits: {
						(v1.#ResourceCPU):    "2"
						(v1.#ResourceMemory): "4Gi"
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
					image: "ghcr.io/uhthomas/uhthomas/samba:6f48fe9eef20bc6966f2694e89d351c4727bfcd1"
					ports: [{
						name:          "smb"
						containerPort: 445
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "1"
						(v1.#ResourceMemory): "1Gi"
					}
					volumeMounts: [{
						name:      "smb-var-cache"
						mountPath: "/var/cache/samba"
					}, {
						name:      "smb-var-lib"
						mountPath: "/var/lib/samba"
					}, {
						name:      "smb-var-lib-private"
						mountPath: "/var/lib/samba/private"
					}, {
						name:      "smb-var-log"
						mountPath: "/var/log/samba"
					}, {
						name:      "smb-var-run"
						mountPath: "/var/run/samba"
					}, {
						name:      "external-library"
						mountPath: "/data"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
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
