package node_problem_detector

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
)

#DaemonSetList: appsv1.#DaemonSetList & {
	apiVersion: "apps/v1"
	kind:       "DaemonSetList"
	items: [...{
		apiVersion: "apps/v1"
		kind:       "DaemonSet"
	}]
}

#DaemonSetList: items: [{
	spec: {
		updateStrategy: rollingUpdate: maxUnavailable:   1
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				serviceAccountName:            #Name
				hostNetwork:                   false
				hostPID:                       false
				terminationGracePeriodSeconds: 30
				priorityClassName:             "system-node-critical"
				volumes: [{
					name: "log"
					hostPath: path: "/var/log/"
				}, {
					name: "localtime"
					hostPath: {
						path: "/etc/localtime"
						type: v1.#HostPathFileOrCreate
					}
				}]
				containers: [{
					name:            "node-problem-detector"
					image:           "registry.k8s.io/node-problem-detector/node-problem-detector:v\(#Version)"
					imagePullPolicy: v1.#PullIfNotPresent
					command: ["/node-problem-detector"]
					args: [
						"--logtostderr",
						"--config.system-log-monitor=/config/kernel-monitor.json,/config/docker-monitor.json",
						"--prometheus-address=0.0.0.0",
						"--prometheus-port=20257",
						"--k8s-exporter-heartbeat-period=5m0s",
					]
					securityContext: privileged: true
					env: [{
						name: "NODE_NAME"
						valueFrom: fieldRef: fieldPath: "spec.nodeName"
					}]
					volumeMounts: [{
						name:      "log"
						mountPath: "/var/log/"
						readOnly:  true
					}, {
						name:      "localtime"
						mountPath: "/etc/localtime"
						readOnly:  true
					}]
					ports: [{
						name:          "exporter"
						containerPort: 20257
					}]
					resources: limits: {
						(v1.#ResourceCPU):   "1"
						(v1.#ResourceMemory): "500Mi"
					}
				}]
				tolerations: [{
					effect:   v1.#TaintEffectNoSchedule
					operator: v1.#TolerationOpExists
				}]
			}
		}
	}
}]
