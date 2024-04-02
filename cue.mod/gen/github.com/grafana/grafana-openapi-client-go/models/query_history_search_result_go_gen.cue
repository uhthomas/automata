// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// QueryHistorySearchResult query history search result
//
// swagger:model QueryHistorySearchResult
#QueryHistorySearchResult: {
	// page
	page?: int64 @go(Page)

	// per page
	perPage?: int64 @go(PerPage)

	// query history
	queryHistory: [...null | #QueryHistoryDTO] @go(QueryHistory,[]*QueryHistoryDTO)

	// total count
	totalCount?: int64 @go(TotalCount)
}
