// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// PublicDashboardDTO public dashboard DTO
//
// swagger:model PublicDashboardDTO
#PublicDashboardDTO: {
	// access token
	accessToken?: string @go(AccessToken)

	// annotations enabled
	annotationsEnabled?: bool @go(AnnotationsEnabled)

	// is enabled
	isEnabled?: bool @go(IsEnabled)

	// share
	share?: #ShareType @go(Share)

	// time selection enabled
	timeSelectionEnabled?: bool @go(TimeSelectionEnabled)

	// uid
	uid?: string @go(UID)
}
