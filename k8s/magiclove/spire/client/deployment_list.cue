package client

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
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				volumes: [{
					name: "spire-agent-socket"
					hostPath: {
						path: "/run/spire/sockets"
						type: v1.#HostPathDirectory
					}
				}]
				containers: [{
					name:  "spire-client"
					image: "ghcr.io/spiffe/spire-agent:\(#Version)"
					command: ["/opt/spire/bin/spire-agent"]
					args: ["api", "watch", "-socketPath", "/run/spire/sockets/agent.sock"]
					volumeMounts: [{
						name:      "spire-agent-socket"
						mountPath: "/run/spire/sockets"
						readOnly:  true
					}]
					imagePullPolicy: v1.#PullIfNotPresent
				}]
				hostPID: true
			}
		}
	}
}]
