package vault

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
)

#StatefulSetList: appsv1.#StatefulSetList & {
	apiVersion: "apps/v1"
	kind:       "StatefulSetList"
	items: [...{
		apiVersion: "apps/v1"
		kind:       "StatefulSet"
	}]
}

#StatefulSetList: items: [{
	spec: {
		serviceName:         "\(#Name)-internal"
		podManagementPolicy: appsv1.#ParallelPodManagement
		replicas:            3
		updateStrategy: type: appsv1.#OnDeleteStatefulSetStrategyType
		selector: matchLabels: {
			"app.kubernetes.io/name":      #Name
			"app.kubernetes.io/component": "server"
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      #Name
				"app.kubernetes.io/component": "server"
			}
			spec: {
				affinity: podAntiAffinity: requiredDuringSchedulingIgnoredDuringExecution: [{
					labelSelector: matchLabels: {
						"app.kubernetes.io/name":      #Name
						"app.kubernetes.io/component": "server"
					}
					topologyKey: "kubernetes.io/hostname"
				}]
				terminationGracePeriodSeconds: 10
				serviceAccountName:            #Name
				securityContext: {
					runAsNonRoot: true
					runAsGroup:   1000
					runAsUser:    100
					fsGroup:      1000
				}
				hostNetwork: false
				volumes: [{
					name: "config"
					configMap: name: "\(#Name)-config"
				}, {
					name: "home"
					emptyDir: {}
				}]
				containers: [{
					name:            "vault"
					image:           "hashicorp/vault:\(#Version)"
					imagePullPolicy: v1.#PullIfNotPresent
					command: [
						"/bin/sh",
						"-ec",
					]
					args: [
						"""
		cp /vault/config/extraconfig-from-values.hcl /tmp/storageconfig.hcl;
		[ -n \"${HOST_IP}\" ] && sed -Ei \"s|HOST_IP|${HOST_IP?}|g\" /tmp/storageconfig.hcl;
		[ -n \"${POD_IP}\" ] && sed -Ei \"s|POD_IP|${POD_IP?}|g\" /tmp/storageconfig.hcl;
		[ -n \"${HOSTNAME}\" ] && sed -Ei \"s|HOSTNAME|${HOSTNAME?}|g\" /tmp/storageconfig.hcl;
		[ -n \"${API_ADDR}\" ] && sed -Ei \"s|API_ADDR|${API_ADDR?}|g\" /tmp/storageconfig.hcl;
		[ -n \"${TRANSIT_ADDR}\" ] && sed -Ei \"s|TRANSIT_ADDR|${TRANSIT_ADDR?}|g\" /tmp/storageconfig.hcl;
		[ -n \"${RAFT_ADDR}\" ] && sed -Ei \"s|RAFT_ADDR|${RAFT_ADDR?}|g\" /tmp/storageconfig.hcl;
		/usr/local/bin/docker-entrypoint.sh vault server -config=/tmp/storageconfig.hcl

		""",
					]
					securityContext: allowPrivilegeEscalation: false
					env: [{
						name: "HOST_IP"
						valueFrom: fieldRef: fieldPath: "status.hostIP"
					}, {
						name: "POD_IP"
						valueFrom: fieldRef: fieldPath: "status.podIP"
					}, {
						name: "VAULT_K8S_POD_NAME"
						valueFrom: fieldRef: fieldPath: "metadata.name"
					}, {
						name: "VAULT_K8S_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}, {
						name:  "VAULT_ADDR"
						value: "http://127.0.0.1:8200"
					}, {
						name:  "VAULT_API_ADDR"
						value: "http://$(POD_IP):8200"
					}, {
						name:  "SKIP_CHOWN"
						value: "true"
					}, {
						name:  "SKIP_SETCAP"
						value: "true"
					}, {
						name: "HOSTNAME"
						valueFrom: fieldRef: fieldPath: "metadata.name"
					}, {
						name:  "VAULT_CLUSTER_ADDR"
						value: "https://$(HOSTNAME).\(#Name)-internal:8201"
					}, {
						name:  "HOME"
						value: "/home/vault"
					}]

					volumeMounts: [{
						name:      "data"
						mountPath: "/vault/data"
					}, {
						name:      "config"
						mountPath: "/vault/config"
					}, {
						name:      "home"
						mountPath: "/home/vault"
					}]
					ports: [{
						containerPort: 8200
						name:          "http"
					}, {
						containerPort: 8201
						name:          "https-internal"
					}, {
						containerPort: 8202
						name:          "http-rep"
					}]
					readinessProbe: {
						// Check status; unsealed vault servers return 0
						// The exit code reflects the seal status:
						//   0 - unsealed
						//   1 - error
						//   2 - sealed
						exec: {
							command: ["/bin/sh", "-ec", "vault status -tls-skip-verify"]
						}
						failureThreshold:    2
						initialDelaySeconds: 5
						periodSeconds:       5
						successThreshold:    1
						timeoutSeconds:      3
					}
					lifecycle: {
						// Vault container doesn't receive SIGTERM from Kubernetes
						// and after the grace period ends, Kube sends SIGKILL.  This
						// causes issues with graceful shutdowns such as deregistering itself
						// from Consul (zombie services).
						preStop: {
							exec: command: [
								"/bin/sh",
								"-c",
								"sleep 5 && kill -SIGTERM $(pidof vault)",
							]
						}
					}
				}]
			}
		}
		volumeClaimTemplates: [{
			metadata: name: "data"
			spec: {
				accessModes: [v1.#ReadWriteOnce]
				storageClassName: "rook-ceph-hdd-ec-delete-block"
				resources: requests: (v1.#ResourceStorage): "10Gi"
			}
		}]
	}
}]
