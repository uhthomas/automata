package snapshot_controller

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
		minReadySeconds: 15
		replicas:        2
		selector: matchLabels: "app.kubernetes.io/name": #Name
		strategy: rollingUpdate: {
			maxSurge:       0
			maxUnavailable: 1
		}
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				containers: [{
					name:  "snapshot-controller"
					image: "registry.k8s.io/sig-storage/snapshot-controller:v6.3.4"
					args: [
						"--v=5",
						"--leader-election=true",
					]
					imagePullPolicy: v1.#PullIfNotPresent
				}]
				serviceAccountName: #Name
			}
		}
	}
}]
