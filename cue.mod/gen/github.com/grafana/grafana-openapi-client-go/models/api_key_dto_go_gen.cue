// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// APIKeyDTO Api key DTO
//
// swagger:model ApiKeyDTO
#APIKeyDTO: {
	// access control
	accessControl?: #Metadata @go(AccessControl)

	// id
	id?: int64 @go(ID)

	// name
	name?: string @go(Name)

	// role
	// Enum: [None Viewer Editor Admin]
	role?: string @go(Role)
}

// APIKeyDTORoleNone captures enum value "None"
#APIKeyDTORoleNone: "None"

// APIKeyDTORoleViewer captures enum value "Viewer"
#APIKeyDTORoleViewer: "Viewer"

// APIKeyDTORoleEditor captures enum value "Editor"
#APIKeyDTORoleEditor: "Editor"

// APIKeyDTORoleAdmin captures enum value "Admin"
#APIKeyDTORoleAdmin: "Admin"
