// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// RelativeTimeRange RelativeTimeRange is the per query start and end time
// for requests.
//
// swagger:model RelativeTimeRange
#RelativeTimeRange: {
	// from
	from?: #Duration @go(From)

	// to
	to?: #Duration @go(To)
}
