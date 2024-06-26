// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// TestTemplatesErrorResult test templates error result
//
// swagger:model TestTemplatesErrorResult
#TestTemplatesErrorResult: {
	// Kind of template error that occurred.
	// Enum: [invalid_template execution_error]
	kind?: string @go(Kind)

	// Error message.
	message?: string @go(Message)

	// Name of the associated template for this error. Will be empty if the Kind is "invalid_template".
	name?: string @go(Name)
}

// TestTemplatesErrorResultKindInvalidTemplate captures enum value "invalid_template"
#TestTemplatesErrorResultKindInvalidTemplate: "invalid_template"

// TestTemplatesErrorResultKindExecutionError captures enum value "execution_error"
#TestTemplatesErrorResultKindExecutionError: "execution_error"
