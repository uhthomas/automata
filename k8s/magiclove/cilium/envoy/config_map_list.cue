package envoy

import (
	"encoding/json"

	"k8s.io/api/core/v1"
)

#ConfigMapList: v1.#ConfigMapList & {
	apiVersion: "v1"
	kind:       "ConfigMapList"
	items: [...{
		apiVersion: "v1"
		kind:       "ConfigMap"
	}]
}

#ConfigMapList: items: [{
	metadata: name: "\(#Name)-config"
	data: "bootstrap-config.json": json.Marshal({
		admin: address: pipe: path: "/var/run/cilium/envoy/sockets/admin.sock"
		applicationLogConfig: logFormat: textFormat: "[%Y-%m-%d %T.%e][%t][%l][%n] [%g:%#] %v"
		bootstrapExtensions: [{
			name: "envoy.bootstrap.internal_listener"
			typedConfig: "@type": "type.googleapis.com/envoy.extensions.bootstrap.internal_listener.v3.InternalListener"
		}]
		dynamicResources: {
			cdsConfig: {
				apiConfigSource: {
					apiType: "GRPC"
					grpcServices: [{
						envoyGrpc: clusterName: "xds-grpc-cilium"
					}]
					setNodeOnFirstMessageOnly: true
					transportApiVersion:       "V3"
				}
				initialFetchTimeout: "30s"
				resourceApiVersion:  "V3"
			}
			ldsConfig: {
				apiConfigSource: {
					apiType: "GRPC"
					grpcServices: [{
						envoyGrpc: clusterName: "xds-grpc-cilium"
					}]
					setNodeOnFirstMessageOnly: true
					transportApiVersion:       "V3"
				}
				initialFetchTimeout: "30s"
				resourceApiVersion:  "V3"
			}
		}
		node: {
			cluster: "ingress-cluster"
			id:      "host~127.0.0.1~no-id~localdomain"
		}
		overloadManager: resourceMonitors: [{
			name: "envoy.resource_monitors.global_downstream_max_connections"
			typedConfig: {
				"@type":                           "type.googleapis.com/envoy.extensions.resource_monitors.downstream_connections.v3.DownstreamConnectionsConfig"
				max_active_downstream_connections: "50000"
			}
		}]
		staticResources: {
			clusters: [{
				circuitBreakers: thresholds: [{
					maxRetries: 128
				}]
				cleanupInterval: "2.500s"
				connectTimeout:  "2s"
				lbPolicy:        "CLUSTER_PROVIDED"
				name:            "ingress-cluster"
				type:            "ORIGINAL_DST"
				typedExtensionProtocolOptions: "envoy.extensions.upstreams.http.v3.HttpProtocolOptions": {"@type": "type.googleapis.com/envoy.extensions.upstreams.http.v3.HttpProtocolOptions"
					commonHttpProtocolOptions: {
						idleTimeout:              "60s"
						maxConnectionDuration:    "0s"
						maxRequestsPerConnection: 0
					}
					useDownstreamProtocolConfig: {}
				}
			}, {
				circuitBreakers: thresholds: [{
					maxRetries: 128
				}]
				cleanupInterval: "2.500s"
				connectTimeout:  "2s"
				lbPolicy:        "CLUSTER_PROVIDED"
				name:            "egress-cluster-tls"
				transportSocket: {
					name: "cilium.tls_wrapper"
					typedConfig: "@type": "type.googleapis.com/cilium.UpstreamTlsWrapperContext"
				}
				type: "ORIGINAL_DST"
				typedExtensionProtocolOptions: "envoy.extensions.upstreams.http.v3.HttpProtocolOptions": {"@type": "type.googleapis.com/envoy.extensions.upstreams.http.v3.HttpProtocolOptions"
					commonHttpProtocolOptions: {
						idleTimeout:              "60s"
						maxConnectionDuration:    "0s"
						maxRequestsPerConnection: 0
					}
					upstreamHttpProtocolOptions: {}
					useDownstreamProtocolConfig: {}
				}
			}, {
				circuitBreakers: thresholds: [{
					maxRetries: 128
				}]
				cleanupInterval: "2.500s"
				connectTimeout:  "2s"
				lbPolicy:        "CLUSTER_PROVIDED"
				name:            "egress-cluster"
				type:            "ORIGINAL_DST"
				typedExtensionProtocolOptions: "envoy.extensions.upstreams.http.v3.HttpProtocolOptions": {"@type": "type.googleapis.com/envoy.extensions.upstreams.http.v3.HttpProtocolOptions"
					commonHttpProtocolOptions: {
						idleTimeout:              "60s"
						maxConnectionDuration:    "0s"
						maxRequestsPerConnection: 0
					}
					useDownstreamProtocolConfig: {}
				}
			}, {
				circuitBreakers: thresholds: [{
					maxRetries: 128
				}]
				cleanupInterval: "2.500s"
				connectTimeout:  "2s"
				lbPolicy:        "CLUSTER_PROVIDED"
				name:            "ingress-cluster-tls"
				transportSocket: {
					name: "cilium.tls_wrapper"
					typedConfig: "@type": "type.googleapis.com/cilium.UpstreamTlsWrapperContext"
				}
				type: "ORIGINAL_DST"
				typedExtensionProtocolOptions: "envoy.extensions.upstreams.http.v3.HttpProtocolOptions": {"@type": "type.googleapis.com/envoy.extensions.upstreams.http.v3.HttpProtocolOptions"
					commonHttpProtocolOptions: {
						idleTimeout:              "60s"
						maxConnectionDuration:    "0s"
						maxRequestsPerConnection: 0
					}
					upstreamHttpProtocolOptions: {}
					useDownstreamProtocolConfig: {}
				}
			}, {
				connectTimeout: "2s"
				loadAssignment: {
					clusterName: "xds-grpc-cilium"
					endpoints: [{
						lbEndpoints: [{
							endpoint: address: pipe: path: "/var/run/cilium/envoy/sockets/xds.sock"
						}]
					}]
				}
				name: "xds-grpc-cilium"
				type: "STATIC"
				typedExtensionProtocolOptions: "envoy.extensions.upstreams.http.v3.HttpProtocolOptions": {
					"@type": "type.googleapis.com/envoy.extensions.upstreams.http.v3.HttpProtocolOptions"
					explicitHttpConfig: http2ProtocolOptions: {}
				}
			}, {
				connectTimeout: "2s"
				loadAssignment: {
					clusterName: "/envoy-admin"
					endpoints: [{
						lbEndpoints: [{
							endpoint: address: pipe: path: "/var/run/cilium/envoy/sockets/admin.sock"
						}]
					}]
				}
				name: "/envoy-admin"
				type: "STATIC"
			}]
			listeners: [{
				address: socketAddress: {
					address:   "0.0.0.0"
					portValue: 9964
				}
				filterChains: [{
					filters: [{
						name: "envoy.filters.network.http_connection_manager"
						typedConfig: {
							"@type": "type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager"
							httpFilters: [{
								name: "envoy.filters.http.router"
								typedConfig: "@type": "type.googleapis.com/envoy.extensions.filters.http.router.v3.Router"
							}]
							internalAddressConfig: cidrRanges: [{
								addressPrefix: "10.0.0.0"
								prefixLen:     8
							}, {
								addressPrefix: "172.16.0.0"
								prefixLen:     12
							}, {
								addressPrefix: "192.168.0.0"
								prefixLen:     16
							}, {
								addressPrefix: "127.0.0.1"
								prefixLen:     32
							}]
							routeConfig: virtualHosts: [{
								domains: ["*"]
								name: "prometheus_metrics_route"
								routes: [{
									match: prefix: "/metrics"
									name: "prometheus_metrics_route"
									route: {
										cluster:       "/envoy-admin"
										prefixRewrite: "/stats/prometheus"
									}
								}]
							}]
							statPrefix:        "envoy-prometheus-metrics-listener"
							streamIdleTimeout: "300s"
						}
					}]
				}]
				name: "envoy-prometheus-metrics-listener"
			}, {
				address: socketAddress: {
					address:   "127.0.0.1"
					portValue: 9878
				}
				filterChains: [{
					filters: [{
						name: "envoy.filters.network.http_connection_manager"
						typedConfig: {
							"@type": "type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager"
							httpFilters: [{
								name: "envoy.filters.http.router"
								typedConfig: "@type": "type.googleapis.com/envoy.extensions.filters.http.router.v3.Router"
							}]
							internalAddressConfig: cidrRanges: [{
								addressPrefix: "10.0.0.0"
								prefixLen:     8
							}, {
								addressPrefix: "172.16.0.0"
								prefixLen:     12
							}, {
								addressPrefix: "192.168.0.0"
								prefixLen:     16
							}, {
								addressPrefix: "127.0.0.1"
								prefixLen:     32
							}]
							routeConfig: virtual_hosts: [{
								domains: ["*"]
								name: "health"
								routes: [{
									match: prefix: "/healthz"
									name: "health"
									route: {
										cluster:       "/envoy-admin"
										prefixRewrite: "/ready"
									}
								}]
							}]
							statPrefix:        "envoy-health-listener"
							streamIdleTimeout: "300s"
						}
					}]
				}]
				name: "envoy-health-listener"
			}]
		}
	})
}]
