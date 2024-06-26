// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// CreateFolderCommand CreateFolderCommand captures the information required by the folder service
// to create a folder.
//
// swagger:model CreateFolderCommand
#CreateFolderCommand: {
	// description
	description?: string @go(Description)

	// parent Uid
	parentUid?: string @go(ParentUID)

	// title
	title?: string @go(Title)

	// uid
	uid?: string @go(UID)
}
