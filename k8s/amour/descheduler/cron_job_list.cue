package descheduler

import (
	"k8s.io/api/core/v1"
	batchv1 "k8s.io/api/batch/v1"
)

#CronJobList: batchv1.#CronJobList & {
	apiVersion: "batch/v1"
	kind:       "CronJobList"
	items: [...{
		apiVersion: "batch/v1"
		kind:       "CronJob"
	}]
}

#CronJobList: items: [{
	spec: {
		schedule:          "*/2 * * * *" // At every second minute.
		concurrencyPolicy: batchv1.#ForbidConcurrent
		jobTemplate: spec: template: spec: {
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
					"--v=3",
				]
				ports: [{
					name:          "https"
					containerPort: 10258
				}]
				resources: limits: {
					cpu:    "500m"
					memory: "256Mi"
				}
				livenessProbe: {
					httpGet: {
						path:   "/healthz"
						port:   "https"
						scheme: v1.#URISchemeHTTPS
					}
					initialDelaySeconds: 3
					periodSeconds:       10
					failureThreshold:    3
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
			restartPolicy:      v1.#RestartPolicyNever
			serviceAccountName: #Name
			securityContext: {
				runAsUser:    1000
				runAsGroup:   3000
				runAsNonRoot: true
				fsGroup:      2000
				seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
			}
			priorityClassName: "system-cluster-critical"
		}
	}
}]
