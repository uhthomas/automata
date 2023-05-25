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
				image: "homeassistant/home-assistant:\(#Version)@sha256:58dcc33ee408a92c41c57e4f853612f8f8001d98ed8d1d3af0532d25fbaa995a"
				ports: [{
					name:          "http"
					containerPort: 8123
				}, {
					name:          "https"
					containerPort: 8443
				}]
				imagePullPolicy: v1.#PullIfNotPresent
				volumeMounts: [{
					name:      "config"
					mountPath: "/config"
				}]
			}]
		}
		volumeClaimTemplates: [{
			metadata: name: "config"
			spec: {
				accessModes: [v1.#ReadWriteOnce]
				storageClassName: "rook-ceph-hdd-ec-delete-block"
				resources: requests: storage: "32Gi"
			}
		}]
		serviceName: #Name
	}
}]
