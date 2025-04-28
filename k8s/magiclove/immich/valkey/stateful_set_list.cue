package valkey

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
				containers: [{
					name:  #Name
					image: "valkey/valkey:\(#Version)-alpine"
					args: ["--save 60 1"]
					ports: [{
						name:          "valkey"
						containerPort: 6379
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "1"
						(v1.#ResourceMemory): "256Mi"
					}
					volumeMounts: [{
						name:      "data"
						mountPath: "/data"
					}]
					// livenessProbe: httpGet: {
					// 	path: "/health"
					// 	port: "http"
					// }
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
			metadata: name: "data"
			spec: {
				accessModes: [v1.#ReadWriteOnce]
				storageClassName: "rook-ceph-nvme"
				resources: requests: (v1.#ResourceStorage): "64Mi"
			}
		}]
		serviceName: #Name
	}
}]
