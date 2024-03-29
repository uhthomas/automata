// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// BgpFamily Address Family Indicator (AFI) and Subsequent Address Family Indicator (SAFI) of the path
//
// swagger:model BgpFamily
#BgpFamily: {
	// Address Family Indicator (AFI) of the path
	afi?: string @go(Afi)

	// Subsequent Address Family Indicator (SAFI) of the path
	safi?: string @go(Safi)
}
