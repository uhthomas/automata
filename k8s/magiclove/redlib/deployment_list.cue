package redlib

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
					name: "config"
					secret: secretName: #Name
				}]
				initContainers: [{
					name:  "proxy"
					image: "ghcr.io/uhthomas/socks5-wireguard-proxy@sha256:bd532015f7621733a0cda03a357dcbe68221398f38188b77c283588625e5631a"
					args: ["--wireguard-address=10.8.0.2"]
					ports: [{
						name:          "socks5-proxy"
						containerPort: 1080
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "300m"
						(v1.#ResourceMemory): "64Mi"
					}
					restartPolicy: v1.#ContainerRestartPolicyAlways
					volumeMounts: [{
						name:      "config"
						mountPath: "/etc/socks5-wireguard-proxy/config"
						subPath:   "config"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				containers: [{
					name:  "redlib"
					image: _image.reference
					ports: [{
						name:          "http"
						containerPort: 8080
					}]
					env: [{
						name:  "SOCKS_PROXY"
						value: "127.0.0.1:1080"
					}, {
						name:  "REDLIB_DEFAULT_WIDE"
						value: "on"
					}, {
						name:  "REDLIB_DEFAULT_SHOW_NSFW"
						value: "on"
					}, {
						name:  "REDLIB_DEFAULT_USE_HLS"
						value: "on"
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "300m"
						(v1.#ResourceMemory): "96Mi"
					}

					let probe = {
						httpGet: {
							path: "/settings"
							port: "http"
						}
					}

					livenessProbe:  probe
					readinessProbe: probe

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
	}
}]
