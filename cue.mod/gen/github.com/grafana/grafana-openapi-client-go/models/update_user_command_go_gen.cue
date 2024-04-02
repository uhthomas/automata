// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// UpdateUserCommand update user command
//
// swagger:model UpdateUserCommand
#UpdateUserCommand: {
	// email
	email?: string @go(Email)

	// login
	login?: string @go(Login)

	// name
	name?: string @go(Name)

	// theme
	theme?: string @go(Theme)
}
