package rook_ceph

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
	// Domain labels define which node labels to use as domains
	// for CSI nodeplugins to advertise their domains
	// NOTE: the value here serves as an example and needs to be
	// updated with node labels that define domains of interest
	// CSI_TOPOLOGY_DOMAIN_LABELS: "kubernetes.io/hostname,topology.kubernetes.io/zone,topology.rook.io/rack"
	// OLM: BEGIN OPERATOR DEPLOYMENT
	metadata: {
		name: "rook-ceph-operator"
		labels: {
			operator:                      "rook"
			"storage-backend":             "ceph"
			"app.kubernetes.io/name":      "rook-ceph"
			"app.kubernetes.io/instance":  "rook-ceph"
			"app.kubernetes.io/component": "rook-ceph-operator"
			"app.kubernetes.io/part-of":   "rook-ceph-operator"
		}
	}
	spec: {
		selector: matchLabels: app: "rook-ceph-operator"
		strategy: type: appsv1.#RecreateDeploymentStrategyType
		replicas: 1
		template: {
			metadata: labels: app: "rook-ceph-operator"
			spec: {
				volumes: [{
					name: "rook-config"
					emptyDir: {}
				}, {
					name: "default-config-dir"
					emptyDir: {}
				}, {
					name: "webhook-cert"
					emptyDir: {}
				}, {
					name: "tmp"
					emptyDir: {}
				}]
				containers: [{
					name:  "rook-ceph-operator"
					image: "rook/ceph:v\(#Version)"
					args: ["ceph", "operator"]
					ports: [{
						name:          "https-webhook"
						containerPort: 9443
					}]
					env: [{
						// If the operator should only watch for cluster CRDs in the same namespace, set this to "true".
						// If this is not set to true, the operator will watch for cluster CRDs in all namespaces.
						name:  "ROOK_CURRENT_NAMESPACE_ONLY"
						value: "false"
					}, {
						// Rook Discover toleration. Will tolerate all taints with all keys.
						// Choose between NoSchedule, PreferNoSchedule and NoExecute:
						// - name: DISCOVER_TOLERATION
						//   value: "NoSchedule"
						// (Optional) Rook Discover toleration key. Set this to the key of the taint you want to tolerate
						// - name: DISCOVER_TOLERATION_KEY
						//   value: "<KeyOfTheTaintToTolerate>"
						// (Optional) Rook Discover tolerations list. Put here list of taints you want to tolerate in YAML format.
						// - name: DISCOVER_TOLERATIONS
						//   value: |
						//     - effect: NoSchedule
						//       key: node-role.kubernetes.io/control-plane
						//       operator: Exists
						//     - effect: NoExecute
						//       key: node-role.kubernetes.io/etcd
						//       operator: Exists
						// (Optional) Rook Discover priority class name to set on the pod(s)
						// - name: DISCOVER_PRIORITY_CLASS_NAME
						//   value: "<PriorityClassName>"
						// (Optional) Discover Agent NodeAffinity.
						// - name: DISCOVER_AGENT_NODE_AFFINITY
						//   value: "role=storage-node; storage=rook, ceph"
						// (Optional) Discover Agent Pod Labels.
						// - name: DISCOVER_AGENT_POD_LABELS
						//   value: "key1=value1,key2=value2"
						// The duration between discovering devices in the rook-discover daemonset.
						name:  "ROOK_DISCOVER_DEVICES_INTERVAL"
						value: "60m"
					}, {
						// Whether to start pods as privileged that mount a host path, which includes the Ceph mon and osd pods.
						// Set this to true if SELinux is enabled (e.g. OpenShift) to workaround the anyuid issues.
						// For more details see https://github.com/rook/rook/issues/1314#issuecomment-355799641
						name:  "ROOK_HOSTPATH_REQUIRES_PRIVILEGED"
						value: "false"
					}, {
						// Disable automatic orchestration when new devices are discovered
						name:  "ROOK_DISABLE_DEVICE_HOTPLUG"
						value: "false"
					}, {
						// Provide customised regex as the values using comma. For eg. regex for rbd based volume, value will be like "(?i)rbd[0-9]+".
						// In case of more than one regex, use comma to separate between them.
						// Default regex will be "(?i)dm-[0-9]+,(?i)rbd[0-9]+,(?i)nbd[0-9]+"
						// Add regex expression after putting a comma to blacklist a disk
						// If value is empty, the default regex will be used.
						name:  "DISCOVER_DAEMON_UDEV_BLACKLIST"
						value: "(?i)dm-[0-9]+,(?i)rbd[0-9]+,(?i)nbd[0-9]+"
					}, {
						// - name: DISCOVER_DAEMON_RESOURCES
						//   value: |
						//     resources:
						//       limits:
						//         cpu: 500m
						//         memory: 512Mi
						//       requests:
						//         cpu: 100m
						//         memory: 128Mi
						// Time to wait until the node controller will move Rook pods to other
						// nodes after detecting an unreachable node.
						// Pods affected by this setting are:
						// mgr, rbd, mds, rgw, nfs, PVC based mons and osds, and ceph toolbox
						// The value used in this variable replaces the default value of 300 secs
						// added automatically by k8s as Toleration for
						// <node.kubernetes.io/unreachable>
						// The total amount of time to reschedule Rook pods in healthy nodes
						// before detecting a <not ready node> condition will be the sum of:
						//  --> node-monitor-grace-period: 40 seconds (k8s kube-controller-manager flag)
						//  --> ROOK_UNREACHABLE_NODE_TOLERATION_SECONDS: 5 seconds
						name:  "ROOK_UNREACHABLE_NODE_TOLERATION_SECONDS"
						value: "5"
					}, {
						// The name of the node to pass with the downward API
						name: "NODE_NAME"
						valueFrom: fieldRef: fieldPath: "spec.nodeName"
					}, {
						// The pod name to pass with the downward API
						name: "POD_NAME"
						valueFrom: fieldRef: fieldPath: "metadata.name"
					}, {
						// The pod namespace to pass with the downward API
						name: "POD_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}]
					resources: {
						limits: {
							cpu:    "500m"
							memory: "512Mi"
						}
						requests: {
							cpu:    "100m"
							memory: "128Mi"
						}
					}
					volumeMounts: [{
						mountPath: "/var/lib/rook"
						name:      "rook-config"
					}, {
						mountPath: "/etc/ceph"
						name:      "default-config-dir"
					}, {
						mountPath: "/etc/webhook"
						name:      "webhook-cert"
					}, {
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
				//  Uncomment it to run lib bucket provisioner in multithreaded mode
				//- name: LIB_BUCKET_PROVISIONER_THREADS
				//  value: "5"
				serviceAccountName: "rook-ceph-system"
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
}, {
	metadata: {
		name: "rook-ceph-tools"
		labels: app: "rook-ceph-tools"
	}
	spec: {
		replicas: 1
		selector: matchLabels: app: "rook-ceph-tools"
		template: {
			metadata: labels: app: "rook-ceph-tools"
			spec: {
				volumes: [{
					name: "ceph-admin-secret"
					secret: {
						secretName: "rook-ceph-mon"
						optional:   false
						items: [{
							key:  "ceph-secret"
							path: "secret.keyring"
						}]
					}
				}, {
					name: "mon-endpoint-volume"
					configMap: {
						name: "rook-ceph-mon-endpoints"
						items: [{
							key:  "data"
							path: "mon-endpoints"
						}]
					}
				}, {
					name: "ceph-config"
					emptyDir: {}
				}]
				containers: [{
					name:  "rook-ceph-tools"
					image: "quay.io/ceph/ceph:v17.2.6"
					command: [
						"/bin/bash",
						"-c",
						"""
						# Replicate the script from toolbox.sh inline so the ceph image
						# can be run directly, instead of requiring the rook toolbox
						CEPH_CONFIG=\"/etc/ceph/ceph.conf\"
						MON_CONFIG=\"/etc/rook/mon-endpoints\"
						KEYRING_FILE=\"/etc/ceph/keyring\"

						# create a ceph config file in its default location so ceph/rados tools can be used
						# without specifying any arguments
						write_endpoints() {
						  endpoints=$(cat ${MON_CONFIG})

						  # filter out the mon names
						  # external cluster can have numbers or hyphens in mon names, handling them in regex
						  # shellcheck disable=SC2001
						  mon_endpoints=$(echo \"${endpoints}\"| sed 's/[a-z0-9_-]\\+=//g')

						  DATE=$(date)
						  echo \"$DATE writing mon endpoints to ${CEPH_CONFIG}: ${endpoints}\"
						    cat <<EOF > ${CEPH_CONFIG}
						[global]
						mon_host = ${mon_endpoints}

						[client.admin]
						keyring = ${KEYRING_FILE}
						EOF
						}

						# watch the endpoints config file and update if the mon endpoints ever change
						watch_endpoints() {
						  # get the timestamp for the target of the soft link
						  real_path=$(realpath ${MON_CONFIG})
						  initial_time=$(stat -c %Z \"${real_path}\")
						  while true; do
						    real_path=$(realpath ${MON_CONFIG})
						    latest_time=$(stat -c %Z \"${real_path}\")

						    if [[ \"${latest_time}\" != \"${initial_time}\" ]]; then
						      write_endpoints
						      initial_time=${latest_time}
						    fi

						    sleep 10
						  done
						}

						# read the secret from an env var (for backward compatibility), or from the secret file
						ceph_secret=${ROOK_CEPH_SECRET}
						if [[ \"$ceph_secret\" == \"\" ]]; then
						  ceph_secret=$(cat /var/lib/rook-ceph-mon/secret.keyring)
						fi

						# create the keyring file
						cat <<EOF > ${KEYRING_FILE}
						[${ROOK_CEPH_USERNAME}]
						key = ${ceph_secret}
						EOF

						# write the initial config file
						write_endpoints

						# continuously update the mon endpoints if they fail over
						watch_endpoints

						""",
					]
					tty: true
					env: [{
						name: "ROOK_CEPH_USERNAME"
						valueFrom: secretKeyRef: {
							name: "rook-ceph-mon"
							key:  "ceph-username"
						}
					}]
					volumeMounts: [{
						mountPath: "/etc/ceph"
						name:      "ceph-config"
					}, {
						name:      "mon-endpoint-volume"
						mountPath: "/etc/rook"
					}, {
						name:      "ceph-admin-secret"
						mountPath: "/var/lib/rook-ceph-mon"
						readOnly:  true
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						// readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				dnsPolicy: v1.#DNSClusterFirstWithHostNet
				securityContext: {
					runAsUser:    1000
					runAsGroup:   3000
					runAsNonRoot: true
					fsGroup:      2000
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
				tolerations: [{
					key:               v1.#TaintNodeUnreachable
					operator:          v1.#NodeSelectorOpExists
					effect:            v1.#TaintEffectNoExecute
					tolerationSeconds: 5
				}]
			}
		}
	}

}]
