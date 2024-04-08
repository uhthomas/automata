// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// UpdateOrgUserCommand update org user command
//
// swagger:model UpdateOrgUserCommand
#UpdateOrgUserCommand: {
	// role
	// Enum: [None Viewer Editor Admin]
	role?: string @go(Role)
}

// UpdateOrgUserCommandRoleNone captures enum value "None"
#UpdateOrgUserCommandRoleNone: "None"

// UpdateOrgUserCommandRoleViewer captures enum value "Viewer"
#UpdateOrgUserCommandRoleViewer: "Viewer"

// UpdateOrgUserCommandRoleEditor captures enum value "Editor"
#UpdateOrgUserCommandRoleEditor: "Editor"

// UpdateOrgUserCommandRoleAdmin captures enum value "Admin"
#UpdateOrgUserCommandRoleAdmin: "Admin"