// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go k8s.io/apimachinery/pkg/fields

package fields

import "k8s.io/apimachinery/pkg/selection"

// Requirements is AND of all requirements.
#Requirements: [...#Requirement]

// Requirement contains a field, a value, and an operator that relates the field and value.
// This is currently for reading internal selection information of field selector.
#Requirement: {
	Operator: selection.#Operator
	Field:    string
	Value:    string
}