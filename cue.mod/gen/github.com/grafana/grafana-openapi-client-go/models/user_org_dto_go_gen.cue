// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// UserOrgDTO user org DTO
//
// swagger:model UserOrgDTO
#UserOrgDTO: {
	// name
	name?: string @go(Name)

	// org Id
	orgId?: int64 @go(OrgID)

	// role
	// Enum: [None Viewer Editor Admin]
	role?: string @go(Role)
}

// UserOrgDTORoleNone captures enum value "None"
#UserOrgDTORoleNone: "None"

// UserOrgDTORoleViewer captures enum value "Viewer"
#UserOrgDTORoleViewer: "Viewer"

// UserOrgDTORoleEditor captures enum value "Editor"
#UserOrgDTORoleEditor: "Editor"

// UserOrgDTORoleAdmin captures enum value "Admin"
#UserOrgDTORoleAdmin: "Admin"