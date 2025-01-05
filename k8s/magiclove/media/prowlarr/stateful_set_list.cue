package prowlarr

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
				}]
				containers: [{
					name:  #Name
					image: "ghcr.io/onedr0p/prowlarr:\(#Version)"
					ports: [{
						name:          "http"
						containerPort: 9696
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "200m"
						(v1.#ResourceMemory): "256Mi"
					}
					volumeMounts: [{
						name:      "config"
						mountPath: "/config"
					}]
					livenessProbe: httpGet: {
						path: "/health"
						port: "http"
					}
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						// capabilities: drop: ["ALL"]
						// readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				// The s6 overlay requires root... It may be
				// better to build our own image instead.
				//
				// https://github.com/linuxserver/docker-radarr/issues/203
				securityContext: {
					runAsUser:           0
					runAsGroup:          0
					runAsNonRoot:        false
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
