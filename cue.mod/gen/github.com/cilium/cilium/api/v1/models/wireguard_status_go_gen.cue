// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// WireguardStatus Status of the Wireguard agent
//
// +k8s:deepcopy-gen=true
//
// swagger:model WireguardStatus
#WireguardStatus: {
	// Wireguard interfaces managed by this Cilium instance
	interfaces: [...null | #WireguardInterface] @go(Interfaces,[]*WireguardInterface)

	// Node Encryption status
	"node-encryption"?: string @go(NodeEncryption)
}
