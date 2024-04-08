// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// UpdateServiceAccountOKBody update service account Ok body
//
// swagger:model updateServiceAccountOkBody
#UpdateServiceAccountOKBody: {
	// id
	id?: int64 @go(ID)

	// message
	message?: string @go(Message)

	// name
	name?: string @go(Name)

	// serviceaccount
	serviceaccount?: null | #ServiceAccountProfileDTO @go(Serviceaccount,*ServiceAccountProfileDTO)
}