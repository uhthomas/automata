// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// QueryHistorySearchResponse query history search response
//
// swagger:model QueryHistorySearchResponse
#QueryHistorySearchResponse: {
	// result
	result?: null | #QueryHistorySearchResult @go(Result,*QueryHistorySearchResult)
}