// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// EndpointStatus The current state and configuration of the endpoint, its policy & datapath, and subcomponents
//
// swagger:model EndpointStatus
#EndpointStatus: {
	// Status of internal controllers attached to this endpoint
	controllers?: #ControllerStatuses @go(Controllers)

	// Unique identifiers for this endpoint from outside cilium
	"external-identifiers"?: null | #EndpointIdentifiers @go(ExternalIdentifiers,*EndpointIdentifiers)

	// Summary overall endpoint & subcomponent health
	health?: null | #EndpointHealth @go(Health,*EndpointHealth)

	// The security identity for this endpoint
	identity?: null | #Identity @go(Identity,*Identity)

	// Labels applied to this endpoint
	labels?: null | #LabelConfigurationStatus @go(Labels,*LabelConfigurationStatus)

	// Most recent status log. See endpoint/{id}/log for the complete log.
	log?: #EndpointStatusLog @go(Log)

	// List of named ports that can be used in Network Policy
	namedPorts?: #NamedPorts @go(NamedPorts)

	// Networking properties of the endpoint
	networking?: null | #EndpointNetworking @go(Networking,*EndpointNetworking)

	// The policy applied to this endpoint from the policy repository
	policy?: null | #EndpointPolicyStatus @go(Policy,*EndpointPolicyStatus)

	// The configuration in effect on this endpoint
	realized?: null | #EndpointConfigurationSpec @go(Realized,*EndpointConfigurationSpec)

	// Current state of endpoint
	// Required: true
	state?: null | #EndpointState @go(State,*EndpointState)
}
