package home_assistant

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
				image: "homeassistant/home-assistant:\(#Version)"
				ports: [{
					name:          "http-metrics"
					containerPort: 8123
				}, {
					name:          "https"
					containerPort: 8443
				}]
				resources: limits: {
					(v1.#ResourceCPU):    "300m"
					(v1.#ResourceMemory): "256Mi"
				}
				volumeMounts: [{
					name:      "config"
					mountPath: "/config"
				}]

				let probe = {
					httpGet: {
						path: "/"
						port: "http-metrics"
					}
				}

				livenessProbe:  probe
				readinessProbe: probe

				imagePullPolicy: v1.#PullIfNotPresent
			}]
		}
		volumeClaimTemplates: [{
			metadata: name: "config"
			spec: {
				accessModes: [v1.#ReadWriteOnce]
				storageClassName: "rook-ceph-nvme"
				resources: requests: (v1.#ResourceStorage): "2Gi"
			}
		}]
		serviceName: #Name
	}
}]
