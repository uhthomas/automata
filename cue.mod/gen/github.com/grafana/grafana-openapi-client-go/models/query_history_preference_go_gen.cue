// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// QueryHistoryPreference QueryHistoryPreference defines model for QueryHistoryPreference.
//
// swagger:model QueryHistoryPreference
#QueryHistoryPreference: {
	// HomeTab one of: '' | 'query' | 'starred';
	homeTab?: string @go(HomeTab)
}
