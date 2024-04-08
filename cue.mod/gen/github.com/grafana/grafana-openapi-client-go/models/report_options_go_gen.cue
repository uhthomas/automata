// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// ReportOptions report options
//
// swagger:model ReportOptions
#ReportOptions: {
	// layout
	layout?: string @go(Layout)

	// orientation
	orientation?: string @go(Orientation)

	// time range
	timeRange?: null | #ReportTimeRange @go(TimeRange,*ReportTimeRange)
}