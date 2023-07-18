// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/crunchydata/postgres-operator/pkg/apis/postgres-operator.crunchydata.com/v1beta1

package v1beta1

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	corev1 "k8s.io/api/core/v1"
)

// PGBackRestJobStatus contains information about the state of a pgBackRest Job.
#PGBackRestJobStatus: {
	// A unique identifier for the manual backup as provided using the "pgbackrest-backup"
	// annotation when initiating a backup.
	// +kubebuilder:validation:Required
	id: string @go(ID)

	// Specifies whether or not the Job is finished executing (does not indicate success or
	// failure).
	// +kubebuilder:validation:Required
	finished: bool @go(Finished)

	// Represents the time the manual backup Job was acknowledged by the Job controller.
	// It is represented in RFC3339 form and is in UTC.
	// +optional
	startTime?: null | metav1.#Time @go(StartTime,*metav1.Time)

	// Represents the time the manual backup Job was determined by the Job controller
	// to be completed.  This field is only set if the backup completed successfully.
	// Additionally, it is represented in RFC3339 form and is in UTC.
	// +optional
	completionTime?: null | metav1.#Time @go(CompletionTime,*metav1.Time)

	// The number of actively running manual backup Pods.
	// +optional
	active?: int32 @go(Active)

	// The number of Pods for the manual backup Job that reached the "Succeeded" phase.
	// +optional
	succeeded?: int32 @go(Succeeded)

	// The number of Pods for the manual backup Job that reached the "Failed" phase.
	// +optional
	failed?: int32 @go(Failed)
}

#PGBackRestScheduledBackupStatus: {
	// The name of the associated pgBackRest scheduled backup CronJob
	// +kubebuilder:validation:Required
	cronJobName?: string @go(CronJobName)

	// The name of the associated pgBackRest repository
	// +kubebuilder:validation:Required
	repo?: string @go(RepoName)

	// The pgBackRest backup type for this Job
	// +kubebuilder:validation:Required
	type?: string @go(Type)

	// Represents the time the manual backup Job was acknowledged by the Job controller.
	// It is represented in RFC3339 form and is in UTC.
	// +optional
	startTime?: null | metav1.#Time @go(StartTime,*metav1.Time)

	// Represents the time the manual backup Job was determined by the Job controller
	// to be completed.  This field is only set if the backup completed successfully.
	// Additionally, it is represented in RFC3339 form and is in UTC.
	// +optional
	completionTime?: null | metav1.#Time @go(CompletionTime,*metav1.Time)

	// The number of actively running manual backup Pods.
	// +optional
	active?: int32 @go(Active)

	// The number of Pods for the manual backup Job that reached the "Succeeded" phase.
	// +optional
	succeeded?: int32 @go(Succeeded)

	// The number of Pods for the manual backup Job that reached the "Failed" phase.
	// +optional
	failed?: int32 @go(Failed)
}

// PGBackRestArchive defines a pgBackRest archive configuration
#PGBackRestArchive: {
	// +optional
	metadata?: null | #Metadata @go(Metadata,*Metadata)

	// Projected volumes containing custom pgBackRest configuration.  These files are mounted
	// under "/etc/pgbackrest/conf.d" alongside any pgBackRest configuration generated by the
	// PostgreSQL Operator:
	// https://pgbackrest.org/configuration.html
	// +optional
	configuration?: [...corev1.#VolumeProjection] @go(Configuration,[]corev1.VolumeProjection)

	// Global pgBackRest configuration settings.  These settings are included in the "global"
	// section of the pgBackRest configuration generated by the PostgreSQL Operator, and then
	// mounted under "/etc/pgbackrest/conf.d":
	// https://pgbackrest.org/configuration.html
	// +optional
	global?: {[string]: string} @go(Global,map[string]string)

	// The image name to use for pgBackRest containers.  Utilized to run
	// pgBackRest repository hosts and backups. The image may also be set using
	// the RELATED_IMAGE_PGBACKREST environment variable
	// +optional
	image?: string @go(Image)

	// Jobs field allows configuration for all backup jobs
	// +optional
	jobs?: null | #BackupJobs @go(Jobs,*BackupJobs)

	// Defines a pgBackRest repository
	// +kubebuilder:validation:MinItems=1
	// +listType=map
	// +listMapKey=name
	repos: [...#PGBackRestRepo] @go(Repos,[]PGBackRestRepo)

	// Defines configuration for a pgBackRest dedicated repository host.  This section is only
	// applicable if at least one "volume" (i.e. PVC-based) repository is defined in the "repos"
	// section, therefore enabling a dedicated repository host Deployment.
	// +optional
	repoHost?: null | #PGBackRestRepoHost @go(RepoHost,*PGBackRestRepoHost)

	// Defines details for manual pgBackRest backup Jobs
	// +optional
	manual?: null | #PGBackRestManualBackup @go(Manual,*PGBackRestManualBackup)

	// Defines details for performing an in-place restore using pgBackRest
	// +optional
	restore?: null | #PGBackRestRestore @go(Restore,*PGBackRestRestore)

	// Configuration for pgBackRest sidecar containers
	// +optional
	sidecars?: null | #PGBackRestSidecars @go(Sidecars,*PGBackRestSidecars)
}

// PGBackRestSidecars defines the configuration for pgBackRest sidecar containers
#PGBackRestSidecars: {
	// Defines the configuration for the pgBackRest sidecar container
	// +optional
	pgbackrest?: null | #Sidecar @go(PGBackRest,*Sidecar)

	// Defines the configuration for the pgBackRest config sidecar container
	// +optional
	pgbackrestConfig?: null | #Sidecar @go(PGBackRestConfig,*Sidecar)
}

#BackupJobs: {
	// Resource limits for backup jobs. Includes manual, scheduled and replica
	// create backups
	// +optional
	resources?: corev1.#ResourceRequirements @go(Resources)

	// Priority class name for the pgBackRest backup Job pods.
	// More info: https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/
	// +optional
	priorityClassName?: null | string @go(PriorityClassName,*string)

	// Scheduling constraints of pgBackRest backup Job pods.
	// More info: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node
	// +optional
	affinity?: null | corev1.#Affinity @go(Affinity,*corev1.Affinity)

	// Tolerations of pgBackRest backup Job pods.
	// More info: https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration
	// +optional
	tolerations?: [...corev1.#Toleration] @go(Tolerations,[]corev1.Toleration)

	// Limit the lifetime of a Job that has finished.
	// More info: https://kubernetes.io/docs/concepts/workloads/controllers/job
	// +optional
	// +kubebuilder:validation:Minimum=60
	ttlSecondsAfterFinished?: null | int32 @go(TTLSecondsAfterFinished,*int32)
}

// PGBackRestManualBackup contains information that is used for creating a
// pgBackRest backup that is invoked manually (i.e. it's unscheduled).
#PGBackRestManualBackup: {
	// The name of the pgBackRest repo to run the backup command against.
	// +kubebuilder:validation:Required
	// +kubebuilder:validation:Pattern=^repo[1-4]
	repoName: string @go(RepoName)

	// Command line options to include when running the pgBackRest backup command.
	// https://pgbackrest.org/command.html#command-backup
	// +optional
	options?: [...string] @go(Options,[]string)
}

// PGBackRestRepoHost represents a pgBackRest dedicated repository host
#PGBackRestRepoHost: {
	// Scheduling constraints of the Dedicated repo host pod.
	// Changing this value causes repo host to restart.
	// More info: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node
	// +optional
	affinity?: null | corev1.#Affinity @go(Affinity,*corev1.Affinity)

	// Priority class name for the pgBackRest repo host pod. Changing this value
	// causes PostgreSQL to restart.
	// More info: https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/
	// +optional
	priorityClassName?: null | string @go(PriorityClassName,*string)

	// Resource requirements for a pgBackRest repository host
	// +optional
	resources?: corev1.#ResourceRequirements @go(Resources)

	// Tolerations of a PgBackRest repo host pod. Changing this value causes a restart.
	// More info: https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration
	// +optional
	tolerations?: [...corev1.#Toleration] @go(Tolerations,[]corev1.Toleration)

	// Topology spread constraints of a Dedicated repo host pod. Changing this
	// value causes the repo host to restart.
	// More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/
	// +optional
	topologySpreadConstraints?: [...corev1.#TopologySpreadConstraint] @go(TopologySpreadConstraints,[]corev1.TopologySpreadConstraint)

	// ConfigMap containing custom SSH configuration.
	// Deprecated: Repository hosts use mTLS for encryption, authentication, and authorization.
	// +optional
	sshConfigMap?: null | corev1.#ConfigMapProjection @go(SSHConfiguration,*corev1.ConfigMapProjection)

	// Secret containing custom SSH keys.
	// Deprecated: Repository hosts use mTLS for encryption, authentication, and authorization.
	// +optional
	sshSecret?: null | corev1.#SecretProjection @go(SSHSecret,*corev1.SecretProjection)
}

// PGBackRestRestore defines an in-place restore for the PostgresCluster.
#PGBackRestRestore: {
	// Whether or not in-place pgBackRest restores are enabled for this PostgresCluster.
	// +kubebuilder:default=false
	enabled?: null | bool @go(Enabled,*bool)

	#PostgresClusterDataSource
}

// PGBackRestBackupSchedules defines a pgBackRest scheduled backup
#PGBackRestBackupSchedules: {
	// Defines the Cron schedule for a full pgBackRest backup.
	// Follows the standard Cron schedule syntax:
	// https://k8s.io/docs/concepts/workloads/controllers/cron-jobs/#cron-schedule-syntax
	// +optional
	// +kubebuilder:validation:MinLength=6
	full?: null | string @go(Full,*string)

	// Defines the Cron schedule for a differential pgBackRest backup.
	// Follows the standard Cron schedule syntax:
	// https://k8s.io/docs/concepts/workloads/controllers/cron-jobs/#cron-schedule-syntax
	// +optional
	// +kubebuilder:validation:MinLength=6
	differential?: null | string @go(Differential,*string)

	// Defines the Cron schedule for an incremental pgBackRest backup.
	// Follows the standard Cron schedule syntax:
	// https://k8s.io/docs/concepts/workloads/controllers/cron-jobs/#cron-schedule-syntax
	// +optional
	// +kubebuilder:validation:MinLength=6
	incremental?: null | string @go(Incremental,*string)
}

// PGBackRestStatus defines the status of pgBackRest within a PostgresCluster
#PGBackRestStatus: {
	// Status information for manual backups
	// +optional
	manualBackup?: null | #PGBackRestJobStatus @go(ManualBackup,*PGBackRestJobStatus)

	// Status information for scheduled backups
	// +optional
	scheduledBackups?: [...#PGBackRestScheduledBackupStatus] @go(ScheduledBackups,[]PGBackRestScheduledBackupStatus)

	// Status information for the pgBackRest dedicated repository host
	// +optional
	repoHost?: null | #RepoHostStatus @go(RepoHost,*RepoHostStatus)

	// Status information for pgBackRest repositories
	// +optional
	// +listType=map
	// +listMapKey=name
	repos?: [...#RepoStatus] @go(Repos,[]RepoStatus)

	// Status information for in-place restores
	// +optional
	restore?: null | #PGBackRestJobStatus @go(Restore,*PGBackRestJobStatus)
}

// PGBackRestRepo represents a pgBackRest repository.  Only one of its members may be specified.
#PGBackRestRepo: {
	// The name of the the repository
	// +kubebuilder:validation:Required
	// +kubebuilder:validation:Pattern=^repo[1-4]
	name: string @go(Name)

	// Defines the schedules for the pgBackRest backups
	// Full, Differential and Incremental backup types are supported:
	// https://pgbackrest.org/user-guide.html#concept/backup
	// +optional
	schedules?: null | #PGBackRestBackupSchedules @go(BackupSchedules,*PGBackRestBackupSchedules)

	// Represents a pgBackRest repository that is created using Azure storage
	// +optional
	azure?: null | #RepoAzure @go(Azure,*RepoAzure)

	// Represents a pgBackRest repository that is created using Google Cloud Storage
	// +optional
	gcs?: null | #RepoGCS @go(GCS,*RepoGCS)

	// RepoS3 represents a pgBackRest repository that is created using AWS S3 (or S3-compatible)
	// storage
	// +optional
	s3?: null | #RepoS3 @go(S3,*RepoS3)

	// Represents a pgBackRest repository that is created using a PersistentVolumeClaim
	// +optional
	volume?: null | #RepoPVC @go(Volume,*RepoPVC)
}

// RepoHostStatus defines the status of a pgBackRest repository host
#RepoHostStatus: {
	metav1.#TypeMeta

	// Whether or not the pgBackRest repository host is ready for use
	// +optional
	ready: bool @go(Ready)
}

// RepoPVC represents a pgBackRest repository that is created using a PersistentVolumeClaim
#RepoPVC: {
	// Defines a PersistentVolumeClaim spec used to create and/or bind a volume
	// +kubebuilder:validation:Required
	volumeClaimSpec: corev1.#PersistentVolumeClaimSpec @go(VolumeClaimSpec)
}

// RepoAzure represents a pgBackRest repository that is created using Azure storage
#RepoAzure: {
	// The Azure container utilized for the repository
	// +kubebuilder:validation:Required
	container: string @go(Container)
}

// RepoGCS represents a pgBackRest repository that is created using Google Cloud Storage
#RepoGCS: {
	// The GCS bucket utilized for the repository
	// +kubebuilder:validation:Required
	bucket: string @go(Bucket)
}

// RepoS3 represents a pgBackRest repository that is created using AWS S3 (or S3-compatible)
// storage
#RepoS3: {
	// The S3 bucket utilized for the repository
	// +kubebuilder:validation:Required
	bucket: string @go(Bucket)

	// A valid endpoint corresponding to the specified region
	// +kubebuilder:validation:Required
	endpoint: string @go(Endpoint)

	// The region corresponding to the S3 bucket
	// +kubebuilder:validation:Required
	region: string @go(Region)
}

// RepoStatus the status of a pgBackRest repository
#RepoStatus: {
	// The name of the pgBackRest repository
	// +kubebuilder:validation:Required
	name: string @go(Name)

	// Whether or not the pgBackRest repository PersistentVolumeClaim is bound to a volume
	// +optional
	bound?: bool @go(Bound)

	// The name of the volume the containing the pgBackRest repository
	// +optional
	volume?: string @go(VolumeName)

	// Specifies whether or not a stanza has been successfully created for the repository
	// +optional
	stanzaCreated: bool @go(StanzaCreated)

	// ReplicaCreateBackupReady indicates whether a backup exists in the repository as needed
	// to bootstrap replicas.
	replicaCreateBackupComplete?: bool @go(ReplicaCreateBackupComplete)

	// A hash of the required fields in the spec for defining an Azure, GCS or S3 repository,
	// Utilizd to detect changes to these fields and then execute pgBackRest stanza-create
	// commands accordingly.
	// +optional
	repoOptionsHash?: string @go(RepoOptionsHash)
}

// PGBackRestDataSource defines a pgBackRest configuration specifically for restoring from cloud-based data source
#PGBackRestDataSource: {
	// Projected volumes containing custom pgBackRest configuration.  These files are mounted
	// under "/etc/pgbackrest/conf.d" alongside any pgBackRest configuration generated by the
	// PostgreSQL Operator:
	// https://pgbackrest.org/configuration.html
	// +optional
	configuration?: [...corev1.#VolumeProjection] @go(Configuration,[]corev1.VolumeProjection)

	// Global pgBackRest configuration settings.  These settings are included in the "global"
	// section of the pgBackRest configuration generated by the PostgreSQL Operator, and then
	// mounted under "/etc/pgbackrest/conf.d":
	// https://pgbackrest.org/configuration.html
	// +optional
	global?: {[string]: string} @go(Global,map[string]string)

	// Defines a pgBackRest repository
	// +kubebuilder:validation:Required
	repo: #PGBackRestRepo @go(Repo)

	// The name of an existing pgBackRest stanza to use as the data source for the new PostgresCluster.
	// Defaults to `db` if not provided.
	// +kubebuilder:default="db"
	stanza: string @go(Stanza)

	// Command line options to include when running the pgBackRest restore command.
	// https://pgbackrest.org/command.html#command-restore
	// +optional
	options?: [...string] @go(Options,[]string)

	// Resource requirements for the pgBackRest restore Job.
	// +optional
	resources?: corev1.#ResourceRequirements @go(Resources)

	// Scheduling constraints of the pgBackRest restore Job.
	// More info: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node
	// +optional
	affinity?: null | corev1.#Affinity @go(Affinity,*corev1.Affinity)

	// Priority class name for the pgBackRest restore Job pod. Changing this
	// value causes PostgreSQL to restart.
	// More info: https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/
	// +optional
	priorityClassName?: null | string @go(PriorityClassName,*string)

	// Tolerations of the pgBackRest restore Job.
	// More info: https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration
	// +optional
	tolerations?: [...corev1.#Toleration] @go(Tolerations,[]corev1.Toleration)
}