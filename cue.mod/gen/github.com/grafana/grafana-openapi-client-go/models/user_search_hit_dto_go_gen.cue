// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// UserSearchHitDTO user search hit DTO
//
// swagger:model UserSearchHitDTO
#UserSearchHitDTO: {
	// auth labels
	authLabels: [...string] @go(AuthLabels,[]string)

	// avatar Url
	avatarUrl?: string @go(AvatarURL)

	// email
	email?: string @go(Email)

	// id
	id?: int64 @go(ID)

	// is admin
	isAdmin?: bool @go(IsAdmin)

	// is disabled
	isDisabled?: bool @go(IsDisabled)

	// last seen at age
	lastSeenAtAge?: string @go(LastSeenAtAge)

	// login
	login?: string @go(Login)

	// name
	name?: string @go(Name)
}