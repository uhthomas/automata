// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// RetrieveJWKSOKBody retrieve j w k s Ok body
//
// swagger:model retrieveJWKSOkBody
#RetrieveJWKSOKBody: {
	// keys
	keys: [...null | #JSONWebKey] @go(Keys,[]*JSONWebKey)
}