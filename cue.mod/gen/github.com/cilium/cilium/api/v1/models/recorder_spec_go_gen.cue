// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// RecorderSpec Configuration of a recorder
//
// swagger:model RecorderSpec
#RecorderSpec: {
	// Maximum packet length or zero for full packet length
	"capture-length"?: int64 @go(CaptureLength)

	// List of wildcard filters for given recorder
	// Required: true
	filters: [...null | #RecorderFilter] @go(Filters,[]*RecorderFilter)

	// Unique identification
	// Required: true
	id?: null | int64 @go(ID,*int64)
}
