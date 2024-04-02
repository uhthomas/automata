// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// DashboardVersionMeta DashboardVersionMeta extends the DashboardVersionDTO with the names
// associated with the UserIds, overriding the field with the same name from
// the DashboardVersionDTO model.
//
// swagger:model DashboardVersionMeta
#DashboardVersionMeta: {
	// created by
	createdBy?: string @go(CreatedBy)

	// dashboard Id
	dashboardId?: int64 @go(DashboardID)

	// data
	data?: #JSON @go(Data)

	// id
	id?: int64 @go(ID)

	// message
	message?: string @go(Message)

	// parent version
	parentVersion?: int64 @go(ParentVersion)

	// restored from
	restoredFrom?: int64 @go(RestoredFrom)

	// uid
	uid?: string @go(UID)

	// version
	version?: int64 @go(Version)
}
