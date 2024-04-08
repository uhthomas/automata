// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// CreateAlertNotificationCommand create alert notification command
//
// swagger:model CreateAlertNotificationCommand
#CreateAlertNotificationCommand: {
	// disable resolve message
	disableResolveMessage?: bool @go(DisableResolveMessage)

	// frequency
	frequency?: string @go(Frequency)

	// is default
	isDefault?: bool @go(IsDefault)

	// name
	name?: string @go(Name)

	// secure settings
	secureSettings?: {[string]: string} @go(SecureSettings,map[string]string)

	// send reminder
	sendReminder?: bool @go(SendReminder)

	// settings
	settings?: #JSON @go(Settings)

	// type
	type?: string @go(Type)

	// uid
	uid?: string @go(UID)
}