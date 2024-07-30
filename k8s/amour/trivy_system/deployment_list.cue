package trivy_system

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
		strategy: type: appsv1.#RecreateDeploymentStrategyType
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				volumes: [{
					name: "policy-cache"
					emptyDir: {}
				}]
				containers: [{
					name:  "trivy-operator"
					image: "ghcr.io/aquasecurity/trivy-operator:\(#Version)"
					ports: [{
						name:          "http-metrics"
						containerPort: 8080
					}, {
						name:          "probes"
						containerPort: 9090
					}]
					envFrom: [{configMapRef: name: "trivy-operator-config"}]
					env: [{
						name:  "OPERATOR_NAMESPACE"
						value: #Namespace
					}, {
						name:  "OPERATOR_TARGET_NAMESPACES"
						value: ""
					}, {
						name:  "OPERATOR_EXCLUDE_NAMESPACES"
						value: ""
					}, {
						name:  "OPERATOR_TARGET_WORKLOADS"
						value: "pod,replicaset,replicationcontroller,statefulset,daemonset,cronjob,job"
					}, {
						name:  "OPERATOR_SERVICE_ACCOUNT"
						value: #Name
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "500m"
						(v1.#ResourceMemory): "512Mi"
					}
					volumeMounts: [{
						name:      "policy-cache"
						mountPath: "/tmp"
					}]

					let probe = {
						httpGet: port: "probes"
						initialDelaySeconds: 5
						periodSeconds:       10
						successThreshold:    1
					}

					readinessProbe: probe & {
						httpGet: path: "/readyz"
						failureThreshold: 3
					}
					livenessProbe: probe & {
						httpGet: path: "/healthz"
						failureThreshold: 10
					}

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
			}
		}
	}
}]
