// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// AlertQuery AlertQuery represents a single query associated with an alert definition.
//
// swagger:model AlertQuery
#AlertQuery: {
	// Grafana data source unique identifier; it should be '__expr__' for a Server Side Expression operation.
	datasourceUid?: string @go(DatasourceUID)

	// JSON is the raw JSON query and includes the above properties as well as custom properties.
	model?: _ @go(Model,interface{})

	// QueryType is an optional identifier for the type of query.
	// It can be used to distinguish different types of queries.
	queryType?: string @go(QueryType)

	// RefID is the unique identifier of the query, set by the frontend call.
	refId?: string @go(RefID)

	// relative time range
	relativeTimeRange?: null | #RelativeTimeRange @go(RelativeTimeRange,*RelativeTimeRange)
}
