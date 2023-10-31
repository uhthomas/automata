// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// RequestResponseStatistics Statistics of a proxy redirect
//
// +k8s:deepcopy-gen=true
//
// swagger:model RequestResponseStatistics
#RequestResponseStatistics: {
	// requests
	requests?: null | #MessageForwardingStatistics @go(Requests,*MessageForwardingStatistics)

	// responses
	responses?: null | #MessageForwardingStatistics @go(Responses,*MessageForwardingStatistics)
}
