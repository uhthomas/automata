// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// VersionInfo VersionInfo version info
//
// swagger:model versionInfo
#VersionInfo: {
	// branch
	// Required: true
	branch?: null | string @go(Branch,*string)

	// build date
	// Required: true
	buildDate?: null | string @go(BuildDate,*string)

	// build user
	// Required: true
	buildUser?: null | string @go(BuildUser,*string)

	// go version
	// Required: true
	goVersion?: null | string @go(GoVersion,*string)

	// revision
	// Required: true
	revision?: null | string @go(Revision,*string)

	// version
	// Required: true
	version?: null | string @go(Version,*string)
}
