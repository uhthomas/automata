// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// DaemonConfiguration Response to a daemon configuration request.
//
// swagger:model DaemonConfiguration
#DaemonConfiguration: {
	// Changeable configuration
	spec?: null | #DaemonConfigurationSpec @go(Spec,*DaemonConfigurationSpec)

	// Current daemon configuration related status.Contains the addressing
	// information, k8s, node monitor and immutable and mutable
	// configuration settings.
	//
	status?: null | #DaemonConfigurationStatus @go(Status,*DaemonConfigurationStatus)
}