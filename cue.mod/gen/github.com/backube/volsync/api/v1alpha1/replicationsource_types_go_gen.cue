// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/backube/volsync/api/v1alpha1

// +kubebuilder:validation:Required
package v1alpha1

import (
	"k8s.io/apimachinery/pkg/api/resource"
	corev1 "k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

// ReplicationSourceTriggerSpec defines when a volume will be synchronized with
// the destination.
#ReplicationSourceTriggerSpec: {
	// schedule is a cronspec (https://en.wikipedia.org/wiki/Cron#Overview) that
	// can be used to schedule replication to occur at regular, time-based
	// intervals.
	// nolint:lll
	//+kubebuilder:validation:Pattern=`^(@(annually|yearly|monthly|weekly|daily|hourly))|((((\d+,)*\d+|(\d+(\/|-)\d+)|\*(\/\d+)?)\s?){5})$`
	//+optional
	schedule?: null | string @go(Schedule,*string)

	// manual is a string value that schedules a manual trigger.
	// Once a sync completes then status.lastManualSync is set to the same string value.
	// A consumer of a manual trigger should set spec.trigger.manual to a known value
	// and then wait for lastManualSync to be updated by the operator to the same value,
	// which means that the manual trigger will then pause and wait for further
	// updates to the trigger.
	//+optional
	manual?: string @go(Manual)
}

// ReplicationSourceExternalSpec defines the configuration when using an
// external replication provider.
#ReplicationSourceExternalSpec: {
	// provider is the name of the external replication provider. The name
	// should be of the form: domain.com/provider.
	provider?: string @go(Provider)

	// parameters are provider-specific key/value configuration parameters. For
	// more information, please see the documentation of the specific
	// replication provider being used.
	parameters?: {[string]: string} @go(Parameters,map[string]string)
}

#ReplicationSourceVolumeOptions: {
	// copyMethod describes how a point-in-time (PiT) image of the source volume
	// should be created.
	copyMethod?: #CopyMethodType @go(CopyMethod)

	// capacity can be used to override the capacity of the PiT image.
	//+optional
	capacity?: null | resource.#Quantity @go(Capacity,*resource.Quantity)

	// storageClassName can be used to override the StorageClass of the PiT
	// image.
	//+optional
	storageClassName?: null | string @go(StorageClassName,*string)

	// accessModes can be used to override the accessModes of the PiT image.
	//+kubebuilder:validation:MinItems=1
	//+optional
	accessModes?: [...corev1.#PersistentVolumeAccessMode] @go(AccessModes,[]corev1.PersistentVolumeAccessMode)

	// volumeSnapshotClassName can be used to specify the VSC to be used if
	// copyMethod is Snapshot. If not set, the default VSC is used.
	//+optional
	volumeSnapshotClassName?: null | string @go(VolumeSnapshotClassName,*string)
}

#ReplicationSourceRsyncSpec: {
	#ReplicationSourceVolumeOptions

	// sshKeys is the name of a Secret that contains the SSH keys to be used for
	// authentication. If not provided, the keys will be generated.
	//+optional
	sshKeys?: null | string @go(SSHKeys,*string)

	// serviceType determines the Service type that will be created for incoming
	// SSH connections.
	//+optional
	serviceType?: null | corev1.#ServiceType @go(ServiceType,*corev1.ServiceType)

	// address is the remote address to connect to for replication.
	//+optional
	address?: null | string @go(Address,*string)

	// port is the SSH port to connect to for replication. Defaults to 22.
	//+kubebuilder:validation:Minimum=0
	//+kubebuilder:validation:Maximum=65535
	//+optional
	port?: null | int32 @go(Port,*int32)

	// path is the remote path to rsync to. Defaults to "/"
	//+optional
	path?: null | string @go(Path,*string)

	// sshUser is the username for outgoing SSH connections. Defaults to "root".
	//+optional
	sshUser?: null | string @go(SSHUser,*string)

	// MoverServiceAccount allows specifying the name of the service account
	// that will be used by the data mover. This should only be used by advanced
	// users who want to override the service account normally used by the mover.
	// The service account needs to exist in the same namespace as the ReplicationSource.
	//+optional
	moverServiceAccount?: null | string @go(MoverServiceAccount,*string)
}

// ReplicationSourceRcloneSpec defines the field for rclone in replicationSource.
#ReplicationSourceRcloneSpec: {
	#ReplicationSourceVolumeOptions

	//RcloneConfigSection is the section in rclone_config file to use for the current job.
	rcloneConfigSection?: null | string @go(RcloneConfigSection,*string)

	// RcloneDestPath is the remote path to sync to.
	rcloneDestPath?: null | string @go(RcloneDestPath,*string)

	// RcloneConfig is the rclone secret name
	rcloneConfig?: null | string @go(RcloneConfig,*string)

	// customCA is a custom CA that will be used to verify the remote
	customCA?: #CustomCASpec @go(CustomCA)

	// MoverSecurityContext allows specifying the PodSecurityContext that will
	// be used by the data mover
	moverSecurityContext?: null | corev1.#PodSecurityContext @go(MoverSecurityContext,*corev1.PodSecurityContext)

	// MoverServiceAccount allows specifying the name of the service account
	// that will be used by the data mover. This should only be used by advanced
	// users who want to override the service account normally used by the mover.
	// The service account needs to exist in the same namespace as the ReplicationSource.
	//+optional
	moverServiceAccount?: null | string @go(MoverServiceAccount,*string)
}

// ResticRetainPolicy defines the feilds for Restic backup
#ResticRetainPolicy: {
	// Hourly defines the number of snapshots to be kept hourly
	//+optional
	hourly?: null | int32 @go(Hourly,*int32)

	// Daily defines the number of snapshots to be kept daily
	//+optional
	daily?: null | int32 @go(Daily,*int32)

	// Weekly defines the number of snapshots to be kept weekly
	//+optional
	weekly?: null | int32 @go(Weekly,*int32)

	// Monthly defines the number of snapshots to be kept monthly
	//+optional
	monthly?: null | int32 @go(Monthly,*int32)

	// Yearly defines the number of snapshots to be kept yearly
	//+optional
	yearly?: null | int32 @go(Yearly,*int32)

	// Within defines the number of snapshots to be kept Within the given time period
	//+optional
	within?: null | string @go(Within,*string)

	// Last defines the number of snapshots to be kept
	//+optional
	last?: null | string @go(Last,*string)
}

#ReplicationSourceResticCA: #CustomCASpec

// ReplicationSourceResticSpec defines the field for restic in replicationSource.
#ReplicationSourceResticSpec: {
	#ReplicationSourceVolumeOptions

	// PruneIntervalDays define how often to prune the repository
	pruneIntervalDays?: null | int32 @go(PruneIntervalDays,*int32)

	// Repository is the secret name containing repository info
	repository?: string @go(Repository)

	// customCA is a custom CA that will be used to verify the remote
	customCA?: #ReplicationSourceResticCA @go(CustomCA)

	// ResticRetainPolicy define the retain policy
	//+optional
	retain?: null | #ResticRetainPolicy @go(Retain,*ResticRetainPolicy)

	// cacheCapacity can be used to set the size of the restic metadata cache volume
	//+optional
	cacheCapacity?: null | resource.#Quantity @go(CacheCapacity,*resource.Quantity)

	// cacheStorageClassName can be used to set the StorageClass of the restic
	// metadata cache volume
	//+optional
	cacheStorageClassName?: null | string @go(CacheStorageClassName,*string)

	// CacheAccessModes can be used to set the accessModes of restic metadata cache volume
	//+optional
	cacheAccessModes?: [...corev1.#PersistentVolumeAccessMode] @go(CacheAccessModes,[]corev1.PersistentVolumeAccessMode)

	// unlock is a string value that schedules an unlock on the restic repository during
	// the next sync operation.
	// Once a sync completes then status.restic.lastUnlocked is set to the same string value.
	// To unlock a repository, set spec.restic.unlock to a known value and then wait for
	// lastUnlocked to be updated by the operator to the same value,
	// which means that the sync unlocked the repository by running a restic unlock command and
	// then ran a backup.
	// Unlock will not be run again unless spec.restic.unlock is set to a different value.
	unlock?: string @go(Unlock)

	// MoverSecurityContext allows specifying the PodSecurityContext that will
	// be used by the data mover
	moverSecurityContext?: null | corev1.#PodSecurityContext @go(MoverSecurityContext,*corev1.PodSecurityContext)

	// MoverServiceAccount allows specifying the name of the service account
	// that will be used by the data mover. This should only be used by advanced
	// users who want to override the service account normally used by the mover.
	// The service account needs to exist in the same namespace as the ReplicationSource.
	//+optional
	moverServiceAccount?: null | string @go(MoverServiceAccount,*string)
}

// ReplicationSourceResticStatus defines the field for ReplicationSourceStatus in ReplicationSourceStatus
#ReplicationSourceResticStatus: {
	// lastPruned in the object holding the time of last pruned
	//+optional
	lastPruned?: null | metav1.#Time @go(LastPruned,*metav1.Time)

	// lastUnlocked is set to the last spec.restic.unlock when a sync is done that unlocks the
	// restic repository.
	//+optional
	lastUnlocked?: string @go(LastUnlocked)
}

// define the Syncthing field
#ReplicationSourceSyncthingSpec: {
	// List of Syncthing peers to be connected for syncing
	peers?: [...#SyncthingPeer] @go(Peers,[]SyncthingPeer)

	// Type of service to be used when exposing the Syncthing peer
	//+optional
	serviceType?: null | corev1.#ServiceType @go(ServiceType,*corev1.ServiceType)

	// Used to set the size of the Syncthing config volume.
	//+optional
	configCapacity?: null | resource.#Quantity @go(ConfigCapacity,*resource.Quantity)

	// Used to set the StorageClass of the Syncthing config volume.
	//+optional
	configStorageClassName?: null | string @go(ConfigStorageClassName,*string)

	// Used to set the accessModes of Syncthing config volume.
	//+optional
	configAccessModes?: [...corev1.#PersistentVolumeAccessMode] @go(ConfigAccessModes,[]corev1.PersistentVolumeAccessMode)

	// MoverSecurityContext allows specifying the PodSecurityContext that will
	// be used by the data mover
	moverSecurityContext?: null | corev1.#PodSecurityContext @go(MoverSecurityContext,*corev1.PodSecurityContext)

	// MoverServiceAccount allows specifying the name of the service account
	// that will be used by the data mover. This should only be used by advanced
	// users who want to override the service account normally used by the mover.
	// The service account needs to exist in the same namespace as the ReplicationSource.
	//+optional
	moverServiceAccount?: null | string @go(MoverServiceAccount,*string)
}

// ReplicationSourceSpec defines the desired state of ReplicationSource
#ReplicationSourceSpec: {
	// sourcePVC is the name of the PersistentVolumeClaim (PVC) to replicate.
	sourcePVC?: string @go(SourcePVC)

	// trigger determines when the latest state of the volume will be captured
	// (and potentially replicated to the destination).
	//+optional
	trigger?: null | #ReplicationSourceTriggerSpec @go(Trigger,*ReplicationSourceTriggerSpec)

	// rsync defines the configuration when using Rsync-based replication.
	//+optional
	rsync?: null | #ReplicationSourceRsyncSpec @go(Rsync,*ReplicationSourceRsyncSpec)

	// rsyncTLS defines the configuration when using Rsync-based replication over TLS.
	//+optional
	rsyncTLS?: null | #ReplicationSourceRsyncTLSSpec @go(RsyncTLS,*ReplicationSourceRsyncTLSSpec)

	// rclone defines the configuration when using Rclone-based replication.
	//+optional
	rclone?: null | #ReplicationSourceRcloneSpec @go(Rclone,*ReplicationSourceRcloneSpec)

	// restic defines the configuration when using Restic-based replication.
	//+optional
	restic?: null | #ReplicationSourceResticSpec @go(Restic,*ReplicationSourceResticSpec)

	// syncthing defines the configuration when using Syncthing-based replication.
	//+optional
	syncthing?: null | #ReplicationSourceSyncthingSpec @go(Syncthing,*ReplicationSourceSyncthingSpec)

	// external defines the configuration when using an external replication
	// provider.
	//+optional
	external?: null | #ReplicationSourceExternalSpec @go(External,*ReplicationSourceExternalSpec)

	// paused can be used to temporarily stop replication. Defaults to "false".
	//+optional
	paused?: bool @go(Paused)
}

#ReplicationSourceRsyncStatus: {
	// sshKeys is the name of a Secret that contains the SSH keys to be used for
	// authentication. If not provided in .spec.rsync.sshKeys, SSH keys will be
	// generated and the appropriate keys for the remote side will be placed
	// here.
	//+optional
	sshKeys?: null | string @go(SSHKeys,*string)

	// address is the address to connect to for incoming SSH replication
	// connections.
	//+optional
	address?: null | string @go(Address,*string)

	// port is the SSH port to connect to for incoming SSH replication
	// connections.
	//+optional
	port?: null | int32 @go(Port,*int32)
}

#ReplicationSourceSyncthingStatus: {
	// List of the Syncthing nodes we are currently connected to.
	peers?: [...#SyncthingPeerStatus] @go(Peers,[]SyncthingPeerStatus)

	// Device ID of the current syncthing device
	ID?: string

	// Service address where Syncthing is exposed to the rest of the world
	address?: string @go(Address)
}

// ReplicationSourceStatus defines the observed state of ReplicationSource
#ReplicationSourceStatus: {
	// lastSyncTime is the time of the most recent successful synchronization.
	//+optional
	lastSyncTime?: null | metav1.#Time @go(LastSyncTime,*metav1.Time)

	// lastSyncStartTime is the time the most recent synchronization started.
	//+optional
	lastSyncStartTime?: null | metav1.#Time @go(LastSyncStartTime,*metav1.Time)

	// lastSyncDuration is the amount of time required to send the most recent
	// update.
	//+optional
	lastSyncDuration?: null | metav1.#Duration @go(LastSyncDuration,*metav1.Duration)

	// nextSyncTime is the time when the next volume synchronization is
	// scheduled to start (for schedule-based synchronization).
	//+optional
	nextSyncTime?: null | metav1.#Time @go(NextSyncTime,*metav1.Time)

	// lastManualSync is set to the last spec.trigger.manual when the manual sync is done.
	//+optional
	lastManualSync?: string @go(LastManualSync)

	// Logs/Summary from latest mover job
	//+optional
	latestMoverStatus?: null | #MoverStatus @go(LatestMoverStatus,*MoverStatus)

	// rsync contains status information for Rsync-based replication.
	rsync?: null | #ReplicationSourceRsyncStatus @go(Rsync,*ReplicationSourceRsyncStatus)

	// rsyncTLS contains status information for Rsync-based replication over TLS.
	rsyncTLS?: null | #ReplicationSourceRsyncTLSStatus @go(RsyncTLS,*ReplicationSourceRsyncTLSStatus)

	// external contains provider-specific status information. For more details,
	// please see the documentation of the specific replication provider being
	// used.
	//+optional
	external?: {[string]: string} @go(External,map[string]string)

	// conditions represent the latest available observations of the
	// source's state.
	conditions?: [...metav1.#Condition] @go(Conditions,[]metav1.Condition)

	// restic contains status information for Restic-based replication.
	restic?: null | #ReplicationSourceResticStatus @go(Restic,*ReplicationSourceResticStatus)

	// contains status information when Syncthing-based replication is used.
	//+optional
	syncthing?: null | #ReplicationSourceSyncthingStatus @go(Syncthing,*ReplicationSourceSyncthingStatus)
}

// ReplicationSource defines the source for a replicated volume
// +kubebuilder:object:root=true
// +kubebuilder:resource:scope=Namespaced
// +kubebuilder:subresource:status
// +kubebuilder:printcolumn:name="Source",type="string",JSONPath=`.spec.sourcePVC`
// +kubebuilder:printcolumn:name="Last sync",type="string",format="date-time",JSONPath=`.status.lastSyncTime`
// +kubebuilder:printcolumn:name="Duration",type="string",JSONPath=`.status.lastSyncDuration`
// +kubebuilder:printcolumn:name="Next sync",type="string",format="date-time",JSONPath=`.status.nextSyncTime`
#ReplicationSource: {
	metav1.#TypeMeta

	//+optional
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// spec is the desired state of the ReplicationSource, including the
	// replication method to use and its configuration.
	spec?: #ReplicationSourceSpec @go(Spec)

	// status is the observed state of the ReplicationSource as determined by
	// the controller.
	//+optional
	status?: null | #ReplicationSourceStatus @go(Status,*ReplicationSourceStatus)
}

// ReplicationSourceList contains a list of Source
// +kubebuilder:object:root=true
#ReplicationSourceList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#ReplicationSource] @go(Items,[]ReplicationSource)
}
