// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// UpdateTeamMemberCommand update team member command
//
// swagger:model UpdateTeamMemberCommand
#UpdateTeamMemberCommand: {
	// permission
	permission?: #PermissionType @go(Permission)
}
