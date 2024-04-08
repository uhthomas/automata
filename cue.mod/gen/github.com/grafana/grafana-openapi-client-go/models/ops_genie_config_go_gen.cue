// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// OpsGenieConfig OpsGenieConfig configures notifications via OpsGenie.
//
// swagger:model OpsGenieConfig
#OpsGenieConfig: {
	// actions
	actions?: string @go(Actions)

	// api key
	api_key?: #Secret @go(APIKey)

	// api key file
	api_key_file?: string @go(APIKeyFile)

	// api url
	api_url?: null | #URL @go(APIURL,*URL)

	// description
	description?: string @go(Description)

	// details
	details?: {[string]: string} @go(Details,map[string]string)

	// entity
	entity?: string @go(Entity)

	// http config
	http_config?: null | #HTTPClientConfig @go(HTTPConfig,*HTTPClientConfig)

	// message
	message?: string @go(Message)

	// note
	note?: string @go(Note)

	// priority
	priority?: string @go(Priority)

	// responders
	responders: [...null | #OpsGenieConfigResponder] @go(Responders,[]*OpsGenieConfigResponder)

	// send resolved
	send_resolved?: bool @go(SendResolved)

	// source
	source?: string @go(Source)

	// tags
	tags?: string @go(Tags)

	// update alerts
	update_alerts?: bool @go(UpdateAlerts)
}