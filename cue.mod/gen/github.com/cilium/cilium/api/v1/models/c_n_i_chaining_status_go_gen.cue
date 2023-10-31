// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// CNIChainingStatus Status of CNI chaining
//
// +k8s:deepcopy-gen=true
//
// swagger:model CNIChainingStatus
#CNIChainingStatus: {
	// mode
	// Enum: [none aws-cni flannel generic-veth portmap]
	mode?: string @go(Mode)
}

// CNIChainingStatusModeNone captures enum value "none"
#CNIChainingStatusModeNone: "none"

// CNIChainingStatusModeAwsDashCni captures enum value "aws-cni"
#CNIChainingStatusModeAwsDashCni: "aws-cni"

// CNIChainingStatusModeFlannel captures enum value "flannel"
#CNIChainingStatusModeFlannel: "flannel"

// CNIChainingStatusModeGenericDashVeth captures enum value "generic-veth"
#CNIChainingStatusModeGenericDashVeth: "generic-veth"

// CNIChainingStatusModePortmap captures enum value "portmap"
#CNIChainingStatusModePortmap: "portmap"
