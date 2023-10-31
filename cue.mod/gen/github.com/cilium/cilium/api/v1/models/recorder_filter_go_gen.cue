// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// RecorderFilter n-tuple filter to match traffic to be recorded
//
// swagger:model RecorderFilter
#RecorderFilter: {
	// Layer 4 destination port, zero (or in future range)
	"dst-port"?: string @go(DstPort)

	// Layer 3 destination CIDR
	"dst-prefix"?: string @go(DstPrefix)

	// Layer 4 protocol
	// Enum: [TCP UDP SCTP ANY]
	protocol?: string @go(Protocol)

	// Layer 4 source port, zero (or in future range)
	"src-port"?: string @go(SrcPort)

	// Layer 3 source CIDR
	"src-prefix"?: string @go(SrcPrefix)
}

// RecorderFilterProtocolTCP captures enum value "TCP"
#RecorderFilterProtocolTCP: "TCP"

// RecorderFilterProtocolUDP captures enum value "UDP"
#RecorderFilterProtocolUDP: "UDP"

// RecorderFilterProtocolSCTP captures enum value "SCTP"
#RecorderFilterProtocolSCTP: "SCTP"

// RecorderFilterProtocolANY captures enum value "ANY"
#RecorderFilterProtocolANY: "ANY"
