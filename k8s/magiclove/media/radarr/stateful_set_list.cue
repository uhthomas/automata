package radarr

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
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				volumes: [{
					name: "tmp"
					emptyDir: {}
				}, {
					name: "media"
					persistentVolumeClaim: claimName: "media"
				}]
				containers: [{
					name:  #Name
					image: "ghcr.io/onedr0p/radarr:\(#Version)"
					ports: [{
						name:          "http"
						containerPort: 7878
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
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "400m"
						(v1.#ResourceMemory): "512Mi"
					}
					volumeMounts: [{
						name:      "config"
						mountPath: "/config"
					}, {
						name:      "tmp"
						mountPath: "/tmp"
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
		}]
		serviceName: #Name
	}
}]
