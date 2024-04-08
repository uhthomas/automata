// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// CreateRoleForm create role form
//
// swagger:model CreateRoleForm
#CreateRoleForm: {
	// description
	description?: string @go(Description)

	// display name
	displayName?: string @go(DisplayName)

	// global
	global?: bool @go(Global)

	// group
	group?: string @go(Group)

	// hidden
	hidden?: bool @go(Hidden)

	// name
	name?: string @go(Name)

	// permissions
	permissions: [...null | #Permission] @go(Permissions,[]*Permission)

	// uid
	uid?: string @go(UID)

	// version
	version?: int64 @go(Version)
}