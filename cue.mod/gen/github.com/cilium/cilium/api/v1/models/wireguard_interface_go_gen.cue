// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// WireguardInterface Status of a Wireguard interface
//
// +k8s:deepcopy-gen=true
//
// swagger:model WireguardInterface
#WireguardInterface: {
	// Port on which the Wireguard endpoint is exposed
	"listen-port"?: int64 @go(ListenPort)

	// Name of the interface
	name?: string @go(Name)

	// Number of peers configured on this interface
	"peer-count"?: int64 @go(PeerCount)

	// Optional list of wireguard peers
	peers: [...null | #WireguardPeer] @go(Peers,[]*WireguardPeer)

	// Public key of this interface
	"public-key"?: string @go(PublicKey)
}
