// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// AdminUpdateUserPermissionsForm admin update user permissions form
//
// swagger:model AdminUpdateUserPermissionsForm
#AdminUpdateUserPermissionsForm: {
	// is grafana admin
	isGrafanaAdmin?: bool @go(IsGrafanaAdmin)
}
