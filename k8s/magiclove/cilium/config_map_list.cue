package cilium

import "k8s.io/api/core/v1"

#ConfigMapList: v1.#ConfigMapList & {
	apiVersion: "v1"
	kind:       "ConfigMapList"
	items: [...{
		apiVersion: "v1"
		kind:       "ConfigMap"
	}]
}

#ConfigMapList: items: [{
	metadata: name: "cilium-config"
	data: {
		// Identity allocation mode selects how identities are shared between cilium
		// nodes by setting how they are stored. The options are "crd" or "kvstore".
		// - "crd" stores identities in kubernetes as CRDs (custom resource definition).
		//   These can be queried with:
		//     kubectl get ciliumid
		// - "kvstore" stores identities in an etcd kvstore, that is
		//   configured below. Cilium versions before 1.6 supported only the kvstore
		//   backend. Upgrades from these older cilium versions should continue using
		//   the kvstore by commenting out the identity-allocation-mode below, or
		//   setting it to "kvstore".
		"identity-allocation-mode":    "crd"
		"identity-heartbeat-timeout":  "30m0s"
		"identity-gc-interval":        "15m0s"
		"cilium-endpoint-gc-interval": "5m0s"
		"nodes-gc-interval":           "5m0s"

		// If you want to run cilium in debug mode change this value to true
		debug:           "false"
		"debug-verbose": ""

		// The agent can be put into the following three policy enforcement modes
		// default, always and never.
		// https://docs.cilium.io/en/latest/security/policy/intro/#policy-enforcement-modes
		"enable-policy":          "default"
		"policy-cidr-match-mode": ""

		// If you want metrics enabled in cilium-operator, set the port for
		// which the Cilium Operator will have their metrics exposed.
		// NOTE that this will open the port on the nodes where Cilium operator pod
		// is scheduled.
		"operator-prometheus-serve-addr":            ":9963"
		"enable-metrics":                            "true"
		"enable-envoy-config":                       "true"
		"envoy-config-retry-interval":               "15s"
		"enable-gateway-api":                        "true"
		"enable-gateway-api-secrets-sync":           "true"
		"enable-gateway-api-proxy-protocol":         "false"
		"enable-gateway-api-app-protocol":           "false"
		"enable-gateway-api-alpn":                   "false"
		"gateway-api-xff-num-trusted-hops":          "0"
		"gateway-api-service-externaltrafficpolicy": "Cluster"
		"gateway-api-secrets-namespace":             "cilium-secrets"
		"gateway-api-hostnetwork-enabled":           "false"
		"gateway-api-hostnetwork-nodelabelselector": ""

		// Enable IPv4 addressing. If enabled, all endpoints are allocated an IPv4
		// address.
		"enable-ipv4": "true"

		// Enable IPv6 addressing. If enabled, all endpoints are allocated an IPv6
		// address.
		"enable-ipv6": "false"
		// Users who wish to specify their own custom CNI configuration file must set
		// custom-cni-conf to "true", otherwise Cilium may overwrite the configuration.
		"custom-cni-conf":        "false"
		"enable-bpf-clock-probe": "false"
		// If you want cilium monitor to aggregate tracing for packets, set this level
		// to "low", "medium", or "maximum". The higher the level, the less packets
		// that will be seen in monitor output.
		"monitor-aggregation": "medium"

		// The monitor aggregation interval governs the typical time between monitor
		// notification events for each allowed connection.
		//
		// Only effective when monitor aggregation is set to "medium" or higher.
		"monitor-aggregation-interval": "5s"

		// The monitor aggregation flags determine which TCP flags which, upon the
		// first observation, cause monitor notifications to be generated.
		//
		// Only effective when monitor aggregation is set to "medium" or higher.
		"monitor-aggregation-flags": "all"
		// Specifies the ratio (0.0-1.0] of total system memory to use for dynamic
		// sizing of the TCP CT, non-TCP CT, NAT and policy BPF maps.
		"bpf-map-dynamic-size-ratio": "0.0025"
		// bpf-policy-map-max specifies the maximum number of entries in endpoint
		// policy map (per endpoint)
		"bpf-policy-map-max": "16384"
		// bpf-lb-map-max specifies the maximum number of entries in bpf lb service,
		// backend and affinity maps.
		"bpf-lb-map-max":                    "65536"
		"bpf-lb-external-clusterip":         "false"
		"bpf-events-drop-enabled":           "true"
		"bpf-events-policy-verdict-enabled": "true"
		"bpf-events-trace-enabled":          "true"

		// https://github.com/cilium/cilium/issues/27758
		"bpf-lb-sock-hostns-only": "true"

		// Pre-allocation of map entries allows per-packet latency to be reduced, at
		// the expense of up-front memory allocation for the entries in the maps. The
		// default value below will minimize memory usage in the default installation;
		// users who are sensitive to latency may consider setting this to "true".
		//
		// This option was introduced in Cilium 1.4. Cilium 1.3 and earlier ignore
		// this option and behave as though it is set to "true".
		//
		// If this value is modified, then during the next Cilium startup the restore
		// of existing endpoints and tracking of ongoing connections may be disrupted.
		// As a result, reply packets may be dropped and the load-balancing decisions
		// for established connections may change.
		//
		// If this option is set to "false" during an upgrade from 1.3 or earlier to
		// 1.4 or later, then it may cause one-time disruptions during the upgrade.
		"preallocate-bpf-maps": "false"

		// Name of the cluster. Only relevant when building a mesh of clusters.
		"cluster-name": "default"
		// Unique ID of the cluster. Must be unique across all conneted clusters and
		// in the range of 1 and 255. Only relevant when building a mesh of clusters.
		"cluster-id": "0"

		// Encapsulation mode for communication between nodes
		// Possible values:
		//   - disabled
		//   - vxlan (default)
		//   - geneve
		// Default case
		"routing-mode":                "tunnel"
		"tunnel-protocol":             "vxlan"
		"service-no-backend-response": "reject"

		// Enables L7 proxy for L7 policy enforcement and visibility
		"enable-l7-proxy":                             "true"
		"enable-ipv4-masquerade":                      "true"
		"enable-ipv4-big-tcp":                         "false"
		"enable-ipv6-big-tcp":                         "false"
		"enable-ipv6-masquerade":                      "true"
		"enable-tcx":                                  "true"
		"datapath-mode":                               "veth"
		"enable-masquerade-to-route-source":           "false"
		"enable-xt-socket-fallback":                   "true"
		"install-no-conntrack-iptables-rules":         "false"
		"auto-direct-node-routes":                     "false"
		"direct-routing-skip-unreachable":             "false"
		"enable-local-redirect-policy":                "false"
		"enable-runtime-device-detection":             "true"
		"kube-proxy-replacement":                      "true"
		"kube-proxy-replacement-healthz-bind-address": ""
		"bpf-lb-sock":                                 "false"
		"bpf-lb-sock-terminate-pod-connections":       "false"
		"nodeport-addresses":                          ""
		"enable-health-check-nodeport":                "true"
		"enable-health-check-loadbalancer-ip":         "false"
		"node-port-bind-protection":                   "true"
		"enable-auto-protect-node-port-range":         "true"
		"bpf-lb-acceleration":                         "disabled"
		"enable-svc-source-range-check":               "true"
		"enable-l2-neigh-discovery":                   "true"
		"arping-refresh-period":                       "30s"
		"k8s-require-ipv4-pod-cidr":                   "false"
		"k8s-require-ipv6-pod-cidr":                   "false"
		"enable-k8s-networkpolicy":                    "true"

		// Tell the agent to generate and write a CNI configuration file
		"write-cni-conf-when-ready":       "/host/etc/cni/net.d/05-cilium.conflist"
		"cni-exclusive":                   "true"
		"cni-log-file":                    "/var/run/cilium/cilium-cni.log"
		"enable-endpoint-health-checking": "true"
		"enable-health-checking":          "true"
		"enable-well-known-identities":    "false"
		"enable-node-selector-labels":     "false"
		"synchronize-k8s-nodes":           "true"
		"operator-api-serve-addr":         "127.0.0.1:9234"
		// Enable Hubble gRPC service.
		"enable-hubble": "true"
		// UNIX domain socket for Hubble server to listen to.
		"hubble-socket-path":             "/var/run/cilium/hubble.sock"
		"hubble-export-file-max-size-mb": "10"
		"hubble-export-file-max-backups": "5"
		// An additional address for Hubble server to listen to (e.g. ":4244").
		"hubble-listen-address":                          ":4244"
		"hubble-disable-tls":                             "false"
		"hubble-tls-cert-file":                           "/var/lib/cilium/tls/hubble/server.crt"
		"hubble-tls-key-file":                            "/var/lib/cilium/tls/hubble/server.key"
		"hubble-tls-client-ca-files":                     "/var/lib/cilium/tls/hubble/client-ca.crt"
		ipam:                                             "kubernetes"
		"ipam-cilium-node-update-rate":                   "15s"
		"egress-gateway-reconciliation-trigger-interval": "1s"
		"enable-vtep":                                    "false"
		"vtep-endpoint":                                  ""
		"vtep-cidr":                                      ""
		"vtep-mask":                                      ""
		"vtep-mac":                                       ""
		procfs:                                           "/host/proc"
		"bpf-root":                                       "/sys/fs/bpf"
		"cgroup-root":                                    "/sys/fs/cgroup"
		"enable-k8s-terminating-endpoint":                "true"
		"enable-sctp":                                    "false"
		"remove-cilium-node-taints":                      "true"
		"set-cilium-node-taints":                         "true"
		"set-cilium-is-up-condition":                     "true"
		"unmanaged-pod-watcher-interval":                 "15"

		// default DNS proxy to transparent mode in non-chaining modes
		"dnsproxy-enable-transparent-mode":        "true"
		"dnsproxy-socket-linger-timeout":          "10"
		"tofqdns-dns-reject-response-code":        "refused"
		"tofqdns-enable-dns-compression":          "true"
		"tofqdns-endpoint-max-ip-per-hostname":    "50"
		"tofqdns-idle-connection-grace-period":    "0s"
		"tofqdns-max-deferred-connection-deletes": "10000"
		"tofqdns-proxy-response-max-delay":        "100ms"
		"agent-not-ready-taint-key":               "node.cilium.io/agent-not-ready"
		"mesh-auth-enabled":                       "true"
		"mesh-auth-queue-size":                    "1024"
		"mesh-auth-rotated-identities-queue-size": "1024"
		"mesh-auth-gc-interval":                   "5m0s"
		"proxy-xff-num-trusted-hops-ingress":      "0"
		"proxy-xff-num-trusted-hops-egress":       "0"
		"proxy-connect-timeout":                   "2"
		"proxy-max-requests-per-connection":       "0"
		"proxy-max-connection-duration-seconds":   "0"
		"proxy-idle-timeout-seconds":              "60"
		"external-envoy-proxy":                    "true"
		"envoy-base-id":                           "0"
		"envoy-keep-cap-netbindservice":           "false"
		"max-connected-clusters":                  "255"
		"clustermesh-enable-endpoint-sync":        "false"
		"clustermesh-enable-mcs-api":              "false"
		"nat-map-stats-entries":                   "32"
		"nat-map-stats-interval":                  "30s"

		"mesh-auth-enabled":                       "true"
		"mesh-auth-queue-size":                    "1024"
		"mesh-auth-rotated-identities-queue-size": "1024"
		"mesh-auth-gc-interval":                   "5m0s"

		"proxy-connect-timeout":                 "2"
		"proxy-max-requests-per-connection":     "0"
		"proxy-max-connection-duration-seconds": "0"

		// https://docs.cilium.io/en/latest/network/l2-announcements/
		"enable-l2-announcements":         "true"
		"enable-external-ips":             "true"
		"l2-announcements-lease-duration": "30s"
		"l2-announcements-renew-deadline": "10s"
		"l2-announcements-retry-period":   "1s"

		// https://docs.cilium.io/en/latest/network/bgp-control-plane/bgp-control-plane/
		"enable-bgp-control-plane":               "true"
		"bgp-secrets-namespace":                  #Namespace
		"enable-bgp-control-plane-status-report": "true"
		"bgp-router-id-allocation-mode":          "default"
		"bgp-router-id-allocation-ip-pool":       ""
		"enable-bgp-legacy-origin-attribute":     "false"

		"k8s-client-qps":   "50"
		"k8s-client-burst": "150"
	}
}]
