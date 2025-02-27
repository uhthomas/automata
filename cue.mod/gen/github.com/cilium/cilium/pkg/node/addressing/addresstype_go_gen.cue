// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/pkg/node/addressing

package addressing

// AddressType represents a type of IP address for a node. They are copied
// from k8s.io/api/core/v1/types.go to avoid pulling in a lot of Kubernetes
// imports into this package.
#AddressType: string // #enumAddressType

#enumAddressType:
	#NodeHostName |
	#NodeExternalIP |
	#NodeInternalIP |
	#NodeExternalDNS |
	#NodeInternalDNS |
	#NodeCiliumInternalIP

#NodeHostName:         #AddressType & "Hostname"
#NodeExternalIP:       #AddressType & "ExternalIP"
#NodeInternalIP:       #AddressType & "InternalIP"
#NodeExternalDNS:      #AddressType & "ExternalDNS"
#NodeInternalDNS:      #AddressType & "InternalDNS"
#NodeCiliumInternalIP: #AddressType & "CiliumInternalIP"

#Address: _
