package jellyfin

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
	let configDirectory = "/etc/\(#Name)/config"

	spec: {
		replicas: 1
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				volumes: [{
					name: "config"
					persistentVolumeClaim: claimName: "\(#Name)-config"
				}, {
					name: "data"
					persistentVolumeClaim: claimName: "\(#Name)-data"
				}, {
					name: "media"
					persistentVolumeClaim: claimName: "media"
				}]
				containers: [{
					name:  #Name
					image: "jellyfin/jellyfin:\(#Version)"
					ports: [{
						name:          "http"
						containerPort: 8096
					}, {
						name:          "https"
						containerPort: 8920
					}, {
						name:          "upnp"
						containerPort: 1900
						protocol:      v1.#ProtocolUDP
					}, {
						name:          "discovery"
						containerPort: 7359
						protocol:      v1.#ProtocolUDP
					}]
					env: [{
						// .NET CoreCLR crashes when run
						// in a container with a
						// read-only filesystem.
						//
						// https://github.com/Radarr/Radarr/issues/7030#issuecomment-1039689518
						// https://github.com/dotnet/runtime/issues/9336
						name:  "COMPlus_EnableDiagnostics"
						value: "0"
					}, {
						name:  "JELLYFIN_CONFIG_DIR"
						value: configDirectory
					}, {
						name:  "JELLYFIN_DATA_DIR"
						value: "/data"
					}]
					resources: {
						limits: {
							cpu:                  "4"
							memory:               "16Gi"
							"gpu.intel.com/i915": 1
						}
						requests: {
							cpu:    "2"
							memory: "4Gi"
						}
					}
					volumeMounts: [{
						name:      "config"
						mountPath: configDirectory
					}, {
						name:      "data"
						mountPath: "/data"
					}, {
						name:      "media"
						mountPath: "/media"
					}]
					livenessProbe: httpGet: {
						path: "/health"
						port: "http"
					}
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				securityContext: {
					runAsUser:    1000
					runAsGroup:   3000
					runAsNonRoot: true
					fsGroup:      2000
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
		strategy: type: appsv1.#RecreateDeploymentStrategyType
	}
}]
