// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// Integration integration
//
// swagger:model integration
#Integration: {
	// Duration of the last attempt to deliver a notification in humanized format (`1s` or `15ms`, etc).
	lastNotifyAttemptDuration?: string @go(LastNotifyAttemptDuration)

	// Error string for the last attempt to deliver a notification. Empty if the last attempt was successful.
	lastNotifyAttemptError?: string @go(LastNotifyAttemptError)

	// name
	// Required: true
	name?: null | string @go(Name,*string)

	// send resolved
	// Required: true
	sendResolved?: null | bool @go(SendResolved,*bool)
}
