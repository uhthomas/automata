// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// LinkTransformationConfig link transformation config
//
// swagger:model LinkTransformationConfig
#LinkTransformationConfig: {
	// expression
	expression?: string @go(Expression)

	// field
	field?: string @go(Field)

	// map value
	mapValue?: string @go(MapValue)

	// type
	type?: #SupportedTransformationTypes @go(Type)
}
