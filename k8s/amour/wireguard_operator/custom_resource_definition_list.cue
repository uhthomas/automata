package wireguard_operator

import apiextensionsv1 "k8s.io/apiextensions-apiserver/pkg/apis/apiextensions/v1"

#CustomResourceDefinitionList: apiextensionsv1.#CustomResourceDefinitionList & {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinitionList"
	items: [...{
		apiVersion: "apiextensions.k8s.io/v1"
		kind:       "CustomResourceDefinition"
	}]
}

#CustomResourceDefinitionList: items: [{
	metadata: name: "wireguardpeers.vpn.wireguard-operator.io"
	spec: {
		group: "vpn.wireguard-operator.io"
		names: {
			kind:     "WireguardPeer"
			listKind: "WireguardPeerList"
			plural:   "wireguardpeers"
			singular: "wireguardpeer"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "WireguardPeer is the Schema for the wireguardpeers API"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description: "The desired state of the peer."
						properties: {
							PrivateKeyRef: {
								description: "The private key of the peer"
								properties: secretKeyRef: {
									description: "SecretKeySelector selects a key of a Secret."
									properties: {
										key: {
											description: "The key of the secret to select from.  Must be a valid secret key."
											type:        "string"
										}
										name: {
											description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
											type:        "string"
										}
										optional: {
											description: "Specify whether the Secret or its key must be defined"
											type:        "boolean"
										}
									}
									required: ["key"]
									type: "object"
								}
								required: ["secretKeyRef"]
								type: "object"
							}
							address: {
								description: "INSERT ADDITIONAL SPEC FIELDS - desired state of cluster Important: Run \"make\" to regenerate code after modifying this file The address of the peer."
								type:        "string"
							}
							disabled: {
								description: "Set to true to temporarily disable the peer."
								type:        "boolean"
							}
							dns: {
								description: "The DNS configuration for the peer."
								type:        "string"
							}
							downloadSpeed: {
								properties: {
									config: type: "integer"
									unit: {
										enum: [
											"mbps",
											"kbps",
										]
										type: "string"
									}
								}
								type: "object"
							}
							egressNetworkPolicies: {
								description: "Egress network policies for the peer."
								items: {
									properties: {
										action: {
											description: "Specifies the action to take when outgoing traffic from a Wireguard peer matches the policy. This could be 'Accept' or 'Reject'."
											enum: [
												"ACCEPT",
												"REJECT",
												"Accept",
												"Reject",
											]
											type: "string"
										}
										protocol: {
											description: "Specifies the protocol to match for this policy. This could be TCP, UDP, or ICMP."
											enum: [
												"TCP",
												"UDP",
												"ICMP",
											]
											type: "string"
										}
										to: {
											description: "A struct that specifies the destination address and port for the traffic. This could include IP addresses or hostnames, as well as specific port numbers or port ranges."
											properties: {
												ip: {
													description: "A string field that specifies the destination IP address for traffic that matches the policy."
													type:        "string"
												}
												port: {
													description: "An integer field that specifies the destination port number for traffic that matches the policy."
													format:      "int32"
													type:        "integer"
												}
											}
											type: "object"
										}
									}
									type: "object"
								}
								type: "array"
							}
							publicKey: {
								description: "The key used by the peer to authenticate with the wg server."
								type:        "string"
							}
							uploadSpeed: {
								properties: {
									config: type: "integer"
									unit: {
										enum: [
											"mbps",
											"kbps",
										]
										type: "string"
									}
								}
								type: "object"
							}
							wireguardRef: {
								description: "The name of the Wireguard instance in k8s that the peer belongs to. The wg instance should be in the same namespace as the peer."
								minLength:   1
								type:        "string"
							}
						}
						required: ["wireguardRef"]
						type: "object"
					}
					status: {
						description: "A field that defines the observed state of the Wireguard peer. This includes fields like the current configuration and status of the peer."
						properties: {
							config: {
								description: "INSERT ADDITIONAL STATUS FIELD - define observed state of cluster Important: Run \"make\" to regenerate code after modifying this file A string field that contains the current configuration for the Wireguard peer."
								type:        "string"
							}
							message: {
								description: "A string field that provides additional information about the status of the Wireguard peer. This could include error messages or other information that helps to diagnose issues with the peer."
								type:        "string"
							}
							status: {
								description: "A string field that represents the current status of the Wireguard peer. This could include values like ready, pending, or error."
								type:        "string"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
	status: {
		acceptedNames: {
			kind:   ""
			plural: ""
		}
		conditions: []
		storedVersions: []
	}
}, {
	metadata: name: "wireguards.vpn.wireguard-operator.io"
	spec: {
		group: "vpn.wireguard-operator.io"
		names: {
			kind:     "Wireguard"
			listKind: "WireguardList"
			plural:   "wireguards"
			singular: "wireguard"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "Wireguard is the Schema for the wireguards API"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description: "WireguardSpec defines the desired state of Wireguard"
						properties: {
							address: {
								description: "A string field that specifies the address for the Wireguard VPN server. This is the public IP address or hostname that peers will use to connect to the VPN."
								type:        "string"
							}
							dns: {
								description: "A string field that specifies the DNS server(s) to be used by the peers."
								type:        "string"
							}
							enableIpForwardOnPodInit: {
								description: "A boolean field that specifies whether IP forwarding should be enabled on the Wireguard VPN pod at startup. This can be useful to enable if the peers are having problems with sending traffic to the internet."
								type:        "boolean"
							}
							mtu: {
								description: "A string field that specifies the maximum transmission unit (MTU) size for Wireguard packets for all peers."
								type:        "string"
							}
							port: {
								description: "A field that specifies the value to use for a nodePort ServiceType"
								format:      "int32"
								type:        "integer"
							}
							serviceAnnotations: {
								additionalProperties: type: "string"
								description: "A map of key value strings for service annotations"
								type:        "object"
							}
							serviceType: {
								description: "A field that specifies the type of Kubernetes service that should be used for the Wireguard VPN. This could be NodePort or LoadBalancer, depending on the needs of the deployment."
								type:        "string"
							}
							useWgUserspaceImplementation: {
								description: "A boolean field that specifies whether to use the userspace implementation of Wireguard instead of the kernel one."
								type:        "boolean"
							}
						}
						type: "object"
					}
					status: {
						description: "WireguardStatus defines the observed state of Wireguard"
						properties: {
							address: {
								description: "A string field that specifies the address for the Wireguard VPN server that is currently being used."
								type:        "string"
							}
							dns: type: "string"
							message: {
								description: "A string field that provides additional information about the status of Wireguard. This could include error messages or other information that helps to diagnose issues with the wg instance."
								type:        "string"
							}
							port: {
								description: "A string field that specifies the port for the Wireguard VPN server that is currently being used."
								type:        "string"
							}
							status: {
								description: "A string field that represents the current status of Wireguard. This could include values like ready, pending, or error."
								type:        "string"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
	status: {
		acceptedNames: {
			kind:   ""
			plural: ""
		}
		conditions: []
		storedVersions: []
	}
}]
