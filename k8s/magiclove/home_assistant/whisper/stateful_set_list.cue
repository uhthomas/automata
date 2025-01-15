package whisper

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
			spec: containers: [{
				name:  #Name
				image: "rhasspy/wyoming-whisper:\(#Version)"
				args: [
					"--model=tiny-int8",
					"--language=en",
					// "--device=cuda",
				]
				ports: [{
					name:          "wyoming"
					containerPort: 10300
				}]
				// env: [{
				// 	name:  "HF_HUB_CACHE"
				// 	value: "/tmp"
				// }]
				resources: {
					requests: {
						(v1.#ResourceCPU):    "200m"
						(v1.#ResourceMemory): "512Mi"
					}
					limits: {
						(v1.#ResourceCPU):    "1"
						(v1.#ResourceMemory): "1Gi"
						"nvidia.com/gpu":     "1"
					}
				}
				volumeMounts: [{
					name:      "data"
					mountPath: "/data"
				}]

				imagePullPolicy: v1.#PullIfNotPresent
			}]
		}
		volumeClaimTemplates: [{
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
