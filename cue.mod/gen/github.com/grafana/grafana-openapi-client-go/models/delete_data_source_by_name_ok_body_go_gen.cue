// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// DeleteDataSourceByNameOKBody delete data source by name Ok body
//
// swagger:model deleteDataSourceByNameOkBody
#DeleteDataSourceByNameOKBody: {
	// ID Identifier of the deleted data source.
	// Example: 65
	// Required: true
	id?: null | int64 @go(ID,*int64)

	// Message Message of the deleted dashboard.
	// Example: Dashboard My Dashboard deleted
	// Required: true
	message?: null | string @go(Message,*string)
}
