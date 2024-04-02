// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// UpdateAnnotationsCmd update annotations cmd
//
// swagger:model UpdateAnnotationsCmd
#UpdateAnnotationsCmd: {
	// data
	data?: #JSON @go(Data)

	// id
	id?: int64 @go(ID)

	// tags
	tags: [...string] @go(Tags,[]string)

	// text
	text?: string @go(Text)

	// time
	time?: int64 @go(Time)

	// time end
	timeEnd?: int64 @go(TimeEnd)
}
