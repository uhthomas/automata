// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// LibraryElementSearchResult LibraryElementSearchResult is the search result for entities.
//
// swagger:model LibraryElementSearchResult
#LibraryElementSearchResult: {
	// elements
	elements: [...null | #LibraryElementDTO] @go(Elements,[]*LibraryElementDTO)

	// page
	page?: int64 @go(Page)

	// per page
	perPage?: int64 @go(PerPage)

	// total count
	totalCount?: int64 @go(TotalCount)
}
