package volsync_system

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
			metadata: {
				annotations: "kubectl.kubernetes.io/default-container": "manager"
				labels: "app.kubernetes.io/name":                       #Name
			}
			spec: {
				volumes: [{
					name: "tmp"
					emptyDir: {}
				}]
				containers: [{
					name:  "kube-rbac-proxy"
					image: "quay.io/brancz/kube-rbac-proxy:v0.14.0"
					args: [
						"--secure-listen-address=0.0.0.0:8443",
						"--upstream=http://127.0.0.1:8080/",
						"--logtostderr=true",
						"--tls-min-version=VersionTLS12",
						"--v=0",
						"--ignore-paths=/metrics",
					]
					ports: [{
						name:          "https"
						containerPort: 8443
					}]
					resources: limits: {
						cpu:    "100m"
						memory: "128Mi"
					}
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}, {
					name:  "manager"
					image: "quay.io/backube/volsync:\(#Version)"
					command: ["/manager"]
					args: [
						"--health-probe-bind-address=:8081",
						"--metrics-bind-address=127.0.0.1:8080",
						"--leader-elect",
						"--rclone-container-image=quay.io/backube/volsync:\(#Version)",
						"--restic-container-image=quay.io/backube/volsync:\(#Version)",
						"--rsync-container-image=quay.io/backube/volsync:\(#Version)",
						"--rsync-tls-container-image=quay.io/backube/volsync:\(#Version)",
						"--syncthing-container-image=quay.io/backube/volsync:\(#Version)",
						"--scc-name=volsync-privileged-mover",
					]
					ports: [{
						name:          "http-metrics"
						containerPort: 8080
					}, {
						name:          "http-health"
						containerPort: 8081
					}]
					livenessProbe: {
						httpGet: {
							path: "/healthz"
							port: "http-health"
						}
						initialDelaySeconds: 15
						periodSeconds:       20
					}
					readinessProbe: {
						httpGet: {
							path: "/readyz"
							port: "http-health"
						}
						initialDelaySeconds: 5
						periodSeconds:       10
					}
					resources: limits: {
						cpu:    "200m"
						memory: "256Mi"
					}
					volumeMounts: [{
						name:      "tmp"
						mountPath: "/tmp"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				terminationGracePeriodSeconds: 10
				serviceAccountName:            "volsync"
				securityContext: {
					runAsUser:    1000
					runAsGroup:   3000
					runAsNonRoot: true
					fsGroup:      2000
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
	}
}]
