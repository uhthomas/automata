// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// PauseAlertCommand pause alert command
//
// swagger:model PauseAlertCommand
#PauseAlertCommand: {
	// alert Id
	alertId?: int64 @go(AlertID)

	// paused
	paused?: bool @go(Paused)
}
