// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// SetPermissionCommand set permission command
//
// swagger:model setPermissionCommand
#SetPermissionCommand: {
	// permission
	permission?: string @go(Permission)
}
