// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// SetHelpFlagOKBody set help flag Ok body
//
// swagger:model setHelpFlagOkBody
#SetHelpFlagOKBody: {
	// help flags1
	helpFlags1?: int64 @go(HelpFlags1)

	// message
	message?: string @go(Message)
}