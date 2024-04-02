// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// AnnotationTarget TODO: this should be a regular DataQuery that depends on the selected dashboard
// these match the properties of the "grafana" datasouce that is default in most dashboards
//
// swagger:model AnnotationTarget
#AnnotationTarget: {
	// Only required/valid for the grafana datasource...
	// but code+tests is already depending on it so hard to change
	limit?: int64 @go(Limit)

	// Only required/valid for the grafana datasource...
	// but code+tests is already depending on it so hard to change
	matchAny?: bool @go(MatchAny)

	// Only required/valid for the grafana datasource...
	// but code+tests is already depending on it so hard to change
	tags: [...string] @go(Tags,[]string)

	// Only required/valid for the grafana datasource...
	// but code+tests is already depending on it so hard to change
	type?: string @go(Type)
}
