// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// RevokeAuthTokenCmd revoke auth token cmd
//
// swagger:model RevokeAuthTokenCmd
#RevokeAuthTokenCmd: {
	// auth token Id
	authTokenId?: int64 @go(AuthTokenID)
}
