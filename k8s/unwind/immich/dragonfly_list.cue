package immich

import "k8s.io/api/core/v1"

#DragonflyList: v1.#List & {
	apiVersion: "dragonflydb.io/v1alpha1"
	kind:       "DragonflyList"
	items: [...{
		apiVersion: "dragonflydb.io/v1alpha1"
		kind:       "Dragonfly"
	}]
}

#DragonflyList: items: [{
	metadata: {
		name: "dragonfly"
		labels: {
			"app.kubernetes.io/name":      #Name
			"app.kubernetes.io/component": "redis"
		}
	}
	spec: {
		replicas: 2
		resources: {
			requests: {
				cpu:    "500m"
				memory: "500Mi"
			}
			limits: {
				cpu:    "600m"
				memory: "750Mi"
			}
		}
	}
}]
