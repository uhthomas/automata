// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// PlaylistItem playlist item
//
// swagger:model PlaylistItem
#PlaylistItem: {
	// Id
	Id?: int64 @go(ID)

	// playlist Id
	PlaylistId?: int64 @go(PlaylistID)

	// order
	order?: int64 @go(Order)

	// title
	title?: string @go(Title)

	// type
	type?: string @go(Type)

	// value
	value?: string @go(Value)
}
