package legacy

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
	metadata: name: "\(#Name)-smb"
	spec: {
		// replicas: 0
		selector: matchLabels: "app.kubernetes.io/name": "\(#Name)-smb"
		template: {
			metadata: labels: "app.kubernetes.io/name": "\(#Name)-smb"
			spec: {
				volumes: [{
					name: "data"
					persistentVolumeClaim: {
						claimName: #Name
						readOnly:  true
					}
				}]
				containers: [{
					name:  "samba"
					image: "ghcr.io/uhthomas/automata/samba:latest"
					ports: [{
						name:          "smb"
						containerPort: 445
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "1"
						(v1.#ResourceMemory): "1Gi"
					}
					volumeMounts: [{
						name:      "data"
						mountPath: "/data"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
				},
					// securityContext: {
					// 	capabilities: drop: ["ALL"]
					// 	readOnlyRootFilesystem:   true
					// 	allowPrivilegeEscalation: false
					// }
				]
				// securityContext: {
				// 	runAsUser:           1000
				// 	runAsGroup:          3000
				// 	runAsNonRoot:        true
				// 	fsGroup:             2000
				// 	fsGroupChangePolicy: v1.#FSGroupChangeOnRootMismatch
				// 	seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				// }
			}
		}
	}
}]
