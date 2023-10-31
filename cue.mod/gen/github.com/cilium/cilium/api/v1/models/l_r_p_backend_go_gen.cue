// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// LRPBackend Pod backend of an LRP
//
// swagger:model LRPBackend
#LRPBackend: {
	// backend address
	"backend-address"?: null | #BackendAddress @go(BackendAddress,*BackendAddress)

	// Namespace and name of the backend pod
	"pod-id"?: string @go(PodID)
}
