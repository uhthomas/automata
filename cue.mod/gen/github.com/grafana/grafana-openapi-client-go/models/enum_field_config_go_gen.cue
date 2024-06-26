// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// EnumFieldConfig Enum field config
// Vector values are used as lookup keys into the enum fields
//
// swagger:model EnumFieldConfig
#EnumFieldConfig: {
	// Color is the color value for a given index (empty is undefined)
	color: [...string] @go(Color,[]string)

	// Description of the enum state
	description: [...string] @go(Description,[]string)

	// Icon supports setting an icon for a given index value
	icon: [...string] @go(Icon,[]string)

	// Value is the string display value for a given index
	text: [...string] @go(Text,[]string)
}
