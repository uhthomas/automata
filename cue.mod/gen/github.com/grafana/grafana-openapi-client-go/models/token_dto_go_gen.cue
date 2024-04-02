// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// TokenDTO token DTO
//
// swagger:model TokenDTO
#TokenDTO: {
	// has expired
	// Example: false
	hasExpired?: bool @go(HasExpired)

	// id
	// Example: 1
	id?: int64 @go(ID)

	// is revoked
	// Example: false
	isRevoked?: bool @go(IsRevoked)

	// name
	// Example: grafana
	name?: string @go(Name)

	// seconds until expiration
	// Example: 0
	secondsUntilExpiration?: float64 @go(SecondsUntilExpiration)
}
