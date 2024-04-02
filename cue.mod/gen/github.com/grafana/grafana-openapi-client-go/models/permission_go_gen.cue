// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// Permission Permission is the model for access control permissions.
//
// swagger:model Permission
#Permission: {
	// action
	action?: string @go(Action)

	// scope
	scope?: string @go(Scope)
}
