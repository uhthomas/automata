package descheduler

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
					name: "policy"
					configMap: name: #Name
				}]
				containers: [{
					name:  "descheduler"
					image: "registry.k8s.io/descheduler/descheduler:v\(#Version)"
					command: ["/bin/descheduler"]
					args: [
						"--policy-config-file=/var/descheduler/policy.yaml",
						"--descheduling-interval=5m",
						"--v=3",
					]
					ports: [{
						name:          "https"
						containerPort: 10258
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "500m"
						(v1.#ResourceMemory): "256Mi"
					}
					livenessProbe: httpGet: {
						path:   "/healthz"
						port:   "https"
						scheme: v1.#URISchemeHTTPS
					}
					volumeMounts: [{
						name:      "policy"
						mountPath: "/var/descheduler/policy.yaml"
						subPath:   "policy.yaml"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				serviceAccountName: #Name
				securityContext: {
					runAsUser:           1000
					runAsGroup:          3000
					runAsNonRoot:        true
					fsGroup:             2000
					fsGroupChangePolicy: v1.#FSGroupChangeOnRootMismatch
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
				tolerations: [{
					key:      "node-role.kubernetes.io/control-plane"
					operator: v1.#TolerationOpExists
					effect:   v1.#TaintEffectNoSchedule
				}]
				priorityClassName: "system-cluster-critical"
			}
		}
	}
}]
