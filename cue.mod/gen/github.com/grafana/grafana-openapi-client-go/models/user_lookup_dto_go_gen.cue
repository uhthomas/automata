// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// UserLookupDTO user lookup DTO
//
// swagger:model UserLookupDTO
#UserLookupDTO: {
	// avatar Url
	avatarUrl?: string @go(AvatarURL)

	// login
	login?: string @go(Login)

	// user Id
	userId?: int64 @go(UserID)
}