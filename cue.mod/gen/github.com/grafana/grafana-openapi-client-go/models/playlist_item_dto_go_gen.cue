// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// PlaylistItemDTO playlist item DTO
//
// swagger:model PlaylistItemDTO
#PlaylistItemDTO: {
	// Title is an unused property -- it will be removed in the future
	title?: string @go(Title)

	// Type of the item.
	type?: string @go(Type)

	// Value depends on type and describes the playlist item.
	//
	// dashboard_by_id: The value is an internal numerical identifier set by Grafana. This
	// is not portable as the numerical identifier is non-deterministic between different instances.
	// Will be replaced by dashboard_by_uid in the future. (deprecated)
	// dashboard_by_tag: The value is a tag which is set on any number of dashboards. All
	// dashboards behind the tag will be added to the playlist.
	// dashboard_by_uid: The value is the dashboard UID
	value?: string @go(Value)
}
