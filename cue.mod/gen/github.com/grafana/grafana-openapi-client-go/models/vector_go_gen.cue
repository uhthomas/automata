// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// Vector Vector is basically only an alias for model.Samples, but the
// contract is that in a Vector, all Samples have the same timestamp.
//
// swagger:model Vector
#Vector: [...null | #Sample]
