// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// OrgDTO org DTO
//
// swagger:model OrgDTO
#OrgDTO: {
	// id
	id?: int64 @go(ID)

	// name
	name?: string @go(Name)
}