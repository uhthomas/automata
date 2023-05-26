// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/rook/rook/pkg/apis/ceph.rook.io/v1

package v1

// SanitizeDataSourceZero uses /dev/zero as sanitize source
#SanitizeDataSourceZero: #SanitizeDataSourceProperty & "zero"

// SanitizeDataSourceRandom uses `shred's default entropy source
#SanitizeDataSourceRandom: #SanitizeDataSourceProperty & "random"

// SanitizeMethodComplete will sanitize everything on the disk
#SanitizeMethodComplete: #SanitizeMethodProperty & "complete"

// SanitizeMethodQuick will sanitize metadata only on the disk
#SanitizeMethodQuick: #SanitizeMethodProperty & "quick"

// DeleteDataDirOnHostsConfirmation represents the validation to destroy dataDirHostPath
#DeleteDataDirOnHostsConfirmation: #CleanupConfirmationProperty & "yes-really-destroy-data"
