// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// CorrelationConfigUpdateDTO correlation config update DTO
//
// swagger:model CorrelationConfigUpdateDTO
#CorrelationConfigUpdateDTO: {
	// Field used to attach the correlation link
	// Example: message
	field?: string @go(Field)

	// Target data query
	// Example: {"prop1":"value1","prop2":"value"}
	target?: _ @go(Target,interface{})

	// Source data transformations
	// Example: [{"type":"logfmt"},{"expression":"(Superman|Batman)","type":"regex","variable":"name"}]
	transformations: [...null | #Transformation] @go(Transformations,[]*Transformation)

	// type
	type?: #CorrelationConfigType @go(Type)
}
