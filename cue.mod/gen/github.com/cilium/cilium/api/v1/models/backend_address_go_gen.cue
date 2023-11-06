// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// BackendAddress Service backend address
//
// swagger:model BackendAddress
#BackendAddress: {
	// Layer 3 address
	// Required: true
	ip?: null | string @go(IP,*string)

	// Optional name of the node on which this backend runs
	nodeName?: string @go(NodeName)

	// Layer 4 port number
	port?: uint16 @go(Port)

	// Indicator if this backend is preferred in the context of clustermesh service affinity. The value is set based
	// on related annotation of global service. Applicable for active state only.
	preferred?: bool @go(Preferred)

	// State of the backend for load-balancing service traffic
	// Enum: [active terminating quarantined maintenance]
	state?: string @go(State)

	// Backend weight
	weight?: null | uint16 @go(Weight,*uint16)
}

// BackendAddressStateActive captures enum value "active"
#BackendAddressStateActive: "active"

// BackendAddressStateTerminating captures enum value "terminating"
#BackendAddressStateTerminating: "terminating"

// BackendAddressStateQuarantined captures enum value "quarantined"
#BackendAddressStateQuarantined: "quarantined"

// BackendAddressStateMaintenance captures enum value "maintenance"
#BackendAddressStateMaintenance: "maintenance"