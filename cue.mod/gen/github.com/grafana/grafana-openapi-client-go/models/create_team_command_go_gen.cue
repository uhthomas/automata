// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// CreateTeamCommand create team command
//
// swagger:model CreateTeamCommand
#CreateTeamCommand: {
	// email
	email?: string @go(Email)

	// name
	name?: string @go(Name)
}
