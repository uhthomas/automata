// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// UpdateProviderSettingsParamsBody update provider settings params body
//
// swagger:model updateProviderSettingsParamsBody
#UpdateProviderSettingsParamsBody: {
	// id
	id?: string @go(ID)

	// provider
	provider?: string @go(Provider)

	// settings
	settings?: _ @go(Settings,interface{})
}