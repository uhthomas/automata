// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// Description description
//
// swagger:model Description
#Description: {
	// assignments
	assignments?: null | #Assignments @go(Assignments,*Assignments)

	// permissions
	permissions: [...string] @go(Permissions,[]string)
}
