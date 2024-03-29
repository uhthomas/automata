// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/backube/volsync/api/v1alpha1

package v1alpha1

#EvRTransferStarted: "TransferStarted"
#EvRTransferFailed:  "TransferFailed"
#EvRSnapCreated:     "VolumeSnapshotCreated"
#EvRSnapNotBound:    "VolumeSnapshotNotBound"
#EvRPVCCreated:      "PersistentVolumeClaimCreated"
#EvRPVCNotBound:     "PersistentVolumeClaimNotBound"
#EvRSvcAddress:      "ServiceAddressAssigned"
#EvRSvcNoAddress:    "NoServiceAddressAssigned"

#EvANone:        ""
#EvACreateMover: "CreateMover"
#EvADeleteMover: "DeleteMover"
#EvACreatePVC:   "CreatePersistentVolumeClaim"
#EvACreateSnap:  "CreateVolumeSnapshot"

#EvRVolPopPVCPopulatorFinished:            "VolSyncPopulatorFinished"
#EvRVolPopPVCPopulatorError:               "VolSyncPopulatorError"
#EvVolPopPVCReplicationDestMissing:        "VolSyncPopulatorReplicationDestinationMissing"
#EvRVolPopPVCReplicationDestNoLatestImage: "VolSyncPopulatorReplicationDestinationNoLatestImage"
#EvRVolPopPVCCreationSuccess:              "VolSyncPopulatorPVCCreated"
#EvRVolPopPVCCreationError:                "VolSyncPopulatorPVCCreationError"
