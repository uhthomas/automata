// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// AddTeamMemberCommand add team member command
//
// swagger:model AddTeamMemberCommand
#AddTeamMemberCommand: {
	// user Id
	userId?: int64 @go(UserID)
}