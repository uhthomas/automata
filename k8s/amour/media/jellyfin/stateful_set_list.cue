package jellyfin

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
)

#StatefulSetList: appsv1.#StatefulSetList & {
	apiVersion: "apps/v1"
	kind:       "StatefulSetList"
	items: [...{
		apiVersion: "apps/v1"
		kind:       "StatefulSet"
	}]
}

#StatefulSetList: items: [{
	let configDirectory = "/etc/\(#Name)/config"

	spec: {
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				volumes: [{
					name: "media"
					persistentVolumeClaim: claimName: "media"
				}, {
					name: "cache"
					emptyDir: sizeLimit: "64Gi"
				}]
				containers: [{
					name:  #Name
					image: "jellyfin/jellyfin:\(#Version)"
					ports: [{
						name:          "http"
						containerPort: 8096
					}, {
						name:          "https"
						containerPort: 8920
					}, {
						name:          "upnp"
						containerPort: 1900
						protocol:      v1.#ProtocolUDP
					}, {
						name:          "discovery"
						containerPort: 7359
						protocol:      v1.#ProtocolUDP
					}]
					env: [{
						// .NET CoreCLR crashes when run
						// in a container with a
						// read-only filesystem.
						//
						// https://github.com/Radarr/Radarr/issues/7030#issuecomment-1039689518
						// https://github.com/dotnet/runtime/issues/9336
						name:  "COMPlus_EnableDiagnostics"
						value: "0"
					}, {
						name:  "JELLYFIN_CONFIG_DIR"
						value: configDirectory
					}, {
						name:  "JELLYFIN_DATA_DIR"
						value: "/data"
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "6"
						(v1.#ResourceMemory): "4Gi"
						"nvidia.com/gpu":     "1"
					}
					volumeMounts: [{
						name:      "config"
						mountPath: configDirectory
					}, {
						name:      "cache"
						mountPath: "/cache"
					}, {
						name:      "data"
						mountPath: "/data"
					}, {
						name:      "media"
						mountPath: "/media"
					}]
					livenessProbe: httpGet: {
						path: "/health"
						port: "http"
					}
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
		volumeClaimTemplates: [{
			metadata: name: "config"
			spec: {
				accessModes: [v1.#ReadWriteOnce]
				storageClassName: "rook-ceph-nvme"
				resources: requests: (v1.#ResourceStorage): "1Gi"
			}
		}, {
			metadata: name: "data"
			spec: {
				accessModes: [v1.#ReadWriteOnce]
				storageClassName: "rook-ceph-nvme"
				resources: requests: (v1.#ResourceStorage): "1Gi"
			}
		}]
		serviceName: #Name
	}
}]
