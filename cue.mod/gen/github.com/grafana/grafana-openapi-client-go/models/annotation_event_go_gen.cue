// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// AnnotationEvent annotation event
//
// swagger:model AnnotationEvent
#AnnotationEvent: {
	// color
	color?: string @go(Color)

	// dashboard Id
	dashboardId?: int64 @go(DashboardID)

	// id
	id?: int64 @go(ID)

	// is region
	isRegion?: bool @go(IsRegion)

	// panel Id
	panelId?: int64 @go(PanelID)

	// source
	source?: null | #AnnotationQuery @go(Source,*AnnotationQuery)

	// tags
	tags: [...string] @go(Tags,[]string)

	// text
	text?: string @go(Text)

	// time
	time?: int64 @go(Time)

	// time end
	timeEnd?: int64 @go(TimeEnd)
}
