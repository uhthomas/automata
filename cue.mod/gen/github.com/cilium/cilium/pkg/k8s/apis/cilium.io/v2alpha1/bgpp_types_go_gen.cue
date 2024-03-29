// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/pkg/k8s/apis/cilium.io/v2alpha1

package v2alpha1

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	slimv1 "github.com/cilium/cilium/pkg/k8s/slim/k8s/apis/meta/v1"
)

// DefaultBGPExportPodCIDR defines the default value for ExportPodCIDR determining whether to export the Node's private CIDR block.
#DefaultBGPExportPodCIDR: false

// DefaultBGPPeerPort defines the TCP port number of a CiliumBGPNeighbor when PeerPort is unspecified.
#DefaultBGPPeerPort: 179

// DefaultBGPEBGPMultihopTTL defines the default value for the TTL value used in BGP packets sent to the eBGP neighbors.
#DefaultBGPEBGPMultihopTTL: 1

// DefaultBGPConnectRetryTimeSeconds defines the default initial value for the BGP ConnectRetryTimer (RFC 4271, Section 8).
#DefaultBGPConnectRetryTimeSeconds: 120

// DefaultBGPHoldTimeSeconds defines the default initial value for the BGP HoldTimer (RFC 4271, Section 4.2).
#DefaultBGPHoldTimeSeconds: 90

// DefaultBGPKeepAliveTimeSeconds defines the default initial value for the BGP KeepaliveTimer (RFC 4271, Section 8).
#DefaultBGPKeepAliveTimeSeconds: 30

// DefaultBGPGRRestartTimeSeconds defines default Restart Time for graceful restart (RFC 4724, section 4.2)
#DefaultBGPGRRestartTimeSeconds: 120

// CiliumBGPPeeringPolicy is a Kubernetes third-party resource for instructing
// Cilium's BGP control plane to create virtual BGP routers.
#CiliumBGPPeeringPolicy: {
	metav1.#TypeMeta

	// +deepequal-gen=false
	metadata: metav1.#ObjectMeta @go(ObjectMeta)

	// Spec is a human readable description of a BGP peering policy
	//
	// +kubebuilder:validation:Optional
	spec?: #CiliumBGPPeeringPolicySpec @go(Spec)
}

// CiliumBGPPeeringPolicyList is a list of
// CiliumBGPPeeringPolicy objects.
#CiliumBGPPeeringPolicyList: {
	metav1.#TypeMeta
	metadata: metav1.#ListMeta @go(ListMeta)

	// Items is a list of CiliumBGPPeeringPolicies.
	items: [...#CiliumBGPPeeringPolicy] @go(Items,[]CiliumBGPPeeringPolicy)
}

// CiliumBGPPeeringPolicySpec specifies one or more CiliumBGPVirtualRouter(s)
// to apply to nodes matching it's label selector.
#CiliumBGPPeeringPolicySpec: {
	// NodeSelector selects a group of nodes where this BGP Peering
	// Policy applies.
	//
	// If empty / nil this policy applies to all nodes.
	//
	// +kubebuilder:validation:Optional
	nodeSelector?: null | slimv1.#LabelSelector @go(NodeSelector,*slimv1.LabelSelector)

	// A list of CiliumBGPVirtualRouter(s) which instructs
	// the BGP control plane how to instantiate virtual BGP routers.
	//
	// +kubebuilder:validation:Required
	// +kubebuilder:validation:MinItems=1
	virtualRouters: [...#CiliumBGPVirtualRouter] @go(VirtualRouters,[]CiliumBGPVirtualRouter)
}

#CiliumBGPNeighborGracefulRestart: {
	// Enabled flag, when set enables graceful restart capability.
	//
	// +kubebuilder:validation:Required
	enabled: bool @go(Enabled)

	// RestartTimeSeconds is the estimated time it will take for the BGP
	// session to be re-established with peer after a restart.
	// After this period, peer will remove stale routes. This is
	// described RFC 4724 section 4.2.
	//
	// +kubebuilder:validation:Optional
	// +kubebuilder:validation:Minimum=1
	// +kubebuilder:validation:Maximum=4095
	// +kubebuilder:default=120
	restartTimeSeconds?: null | int32 @go(RestartTimeSeconds,*int32)
}

// CiliumBGPNeighbor is a neighboring peer for use in a
// CiliumBGPVirtualRouter configuration.
#CiliumBGPNeighbor: {
	// PeerAddress is the IP address of the peer.
	// This must be in CIDR notation and use a /32 to express
	// a single host.
	//
	// +kubebuilder:validation:Required
	// +kubebuilder:validation:Format=cidr
	peerAddress: string @go(PeerAddress)

	// PeerPort is the TCP port of the peer. 1-65535 is the range of
	// valid port numbers that can be specified. If unset, defaults to 179.
	//
	// +kubebuilder:validation:Optional
	// +kubebuilder:validation:Minimum=1
	// +kubebuilder:validation:Maximum=65535
	// +kubebuilder:default=179
	peerPort?: null | int32 @go(PeerPort,*int32)

	// PeerASN is the ASN of the peer BGP router.
	// Supports extended 32bit ASNs
	//
	// +kubebuilder:validation:Required
	// +kubebuilder:validation:Minimum=0
	// +kubebuilder:validation:Maximum=4294967295
	peerASN: int64 @go(PeerASN)

	// EBGPMultihopTTL controls the multi-hop feature for eBGP peers.
	// Its value defines the Time To Live (TTL) value used in BGP packets sent to the neighbor.
	// The value 1 implies that eBGP multi-hop feature is disabled (only a single hop is allowed).
	// This field is ignored for iBGP peers.
	//
	// +kubebuilder:validation:Optional
	// +kubebuilder:validation:Minimum=1
	// +kubebuilder:validation:Maximum=255
	// +kubebuilder:default=1
	eBGPMultihopTTL?: null | int32 @go(EBGPMultihopTTL,*int32)

	// ConnectRetryTimeSeconds defines the initial value for the BGP ConnectRetryTimer (RFC 4271, Section 8).
	//
	// +kubebuilder:validation:Optional
	// +kubebuilder:validation:Minimum=1
	// +kubebuilder:validation:Maximum=2147483647
	// +kubebuilder:default=120
	connectRetryTimeSeconds?: null | int32 @go(ConnectRetryTimeSeconds,*int32)

	// HoldTimeSeconds defines the initial value for the BGP HoldTimer (RFC 4271, Section 4.2).
	// Updating this value will cause a session reset.
	//
	// +kubebuilder:validation:Optional
	// +kubebuilder:validation:Minimum=3
	// +kubebuilder:validation:Maximum=65535
	// +kubebuilder:default=90
	holdTimeSeconds?: null | int32 @go(HoldTimeSeconds,*int32)

	// KeepaliveTimeSeconds defines the initial value for the BGP KeepaliveTimer (RFC 4271, Section 8).
	// It can not be larger than HoldTimeSeconds. Updating this value will cause a session reset.
	//
	// +kubebuilder:validation:Optional
	// +kubebuilder:validation:Minimum=1
	// +kubebuilder:validation:Maximum=65535
	// +kubebuilder:default=30
	keepAliveTimeSeconds?: null | int32 @go(KeepAliveTimeSeconds,*int32)

	// GracefulRestart defines graceful restart parameters which are negotiated
	// with this neighbor. If empty / nil, the graceful restart capability is disabled.
	//
	// +kubebuilder:validation:Optional
	gracefulRestart?: null | #CiliumBGPNeighborGracefulRestart @go(GracefulRestart,*CiliumBGPNeighborGracefulRestart)
}

// CiliumBGPVirtualRouter defines a discrete BGP virtual router configuration.
#CiliumBGPVirtualRouter: {
	// LocalASN is the ASN of this virtual router.
	// Supports extended 32bit ASNs
	//
	// +kubebuilder:validation:Required
	// +kubebuilder:validation:Minimum=0
	// +kubebuilder:validation:Maximum=4294967295
	localASN: int64 @go(LocalASN)

	// ExportPodCIDR determines whether to export the Node's private CIDR block
	// to the configured neighbors.
	//
	// +kubebuilder:validation:Optional
	// +kubebuilder:default=false
	exportPodCIDR?: null | bool @go(ExportPodCIDR,*bool)

	// ServiceSelector selects a group of load balancer services which this
	// virtual router will announce.
	//
	// If empty / nil no services will be announced.
	//
	// +kubebuilder:validation:Optional
	serviceSelector?: null | slimv1.#LabelSelector @go(ServiceSelector,*slimv1.LabelSelector)

	// Neighbors is a list of neighboring BGP peers for this virtual router
	//
	// +kubebuilder:validation:Required
	// +kubebuilder:validation:MinItems=1
	neighbors: [...#CiliumBGPNeighbor] @go(Neighbors,[]CiliumBGPNeighbor)
}
