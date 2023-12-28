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
					name:          "http"
					containerPort: 8123
				}, {
					name:          "https"
					containerPort: 8443
				}]
				resources: limits: {
					(v1.#ResourceCPU):    "200m"
					(v1.#ResourceMemory): "128Mi"
				}
				volumeMounts: [{
					name:      "config"
					mountPath: "/config"
				}]
				imagePullPolicy: v1.#PullIfNotPresent
			}]
		}
		volumeClaimTemplates: [{
			metadata: name: "config"
			spec: {
				accessModes: [v1.#ReadWriteOnce]
				storageClassName: "rook-ceph-nvme-ec-delete-block"
				resources: requests: (v1.#ResourceStorage): "2Gi"
			}
		}]
		serviceName: #Name
	}
}]
